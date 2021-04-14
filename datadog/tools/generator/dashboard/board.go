package main

import (
	"encoding/json"
	"io/ioutil"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclparse"
	"github.com/zclconf/go-cty/cty"
)

const (
	Padding = 1

	GroupNameHeight = 7
	GroupNameWidth  = 7
	GroupFontSize   = 88

	SectionHeaderHeight = 9
	SectionArrowWidth   = 8

	WidgetTitleHeight = 2

	BigWidgetHeight = 14
	BigWidgetWidth  = 24

	WidgetHeight = 7
	WidgetWidth  = 12
)

type layout struct {
	X      int `json:"x"`
	Y      int `json:"y"`
	Height int `json:"height"`
	Width  int `json:"width"`
}

type board struct {
	Name            string           `json:"fd_title"`
	FreeTextWidgets []FreeTextWidget `json:"fd_free_text_widgets"`
	NoteWidgets     []NoteWidget     `json:"fd_note_widgets"`
	ImageWidgets    []ImageWidget    `json:"fd_image_widgets"`
	QueryWidgets    []QueryWidget    `json:"fd_query_value_widgets"`
}

func (b board) Generate() error {
	err := ioutil.WriteFile("terragrunt.hcl", []byte(`include {
	path = find_in_parent_folders()
}

terraform {
	source = "git::git@github.com:tokopedia/obac.git//tf-module//datadog//freestyle-dashboard-old"
}`), 0644)

	if err != nil {
		return err
	}

	inputs, err := json.MarshalIndent(b, "  ", "  ")
	if err != nil {
		return err
	}

	return ioutil.WriteFile("terraform.tfvars.json", []byte(inputs), 0644)
}

type MonitorConfig struct {
	Include struct {
		Remain hcl.Body `hcl:",remain"`
	} `hcl:"include,block"`

	Terraform struct {
		Remain hcl.Body `hcl:",remain"`
	} `hcl:"terraform,block"`

	Inputs cty.Value `hcl:"inputs"`
}

func (b *board) generateNode(startX, startY int, node Node) (height, width int) {
	hideSuccessRate := true
	hideRPS := true
	hideLatency := true

	y := startY + Padding

	if node.Monitor != nil {
		parser := hclparse.NewParser()

		var srCfg, rpsCfg, latCfg MonitorConfig
		// success-rate-threshold
		if src, diags := parser.ParseHCLFile("../../../" + *node.Monitor + "/success-rate-threshold/terragrunt.hcl"); !diags.HasErrors() {
			decodeDiags := gohcl.DecodeBody(src.Body, nil, &srCfg)
			hideSuccessRate = decodeDiags.HasErrors()
		}

		// has success rate
		if !hideSuccessRate && (node.Type != nil && *node.Type != "sr_module") {
			// rps-threshold
			if src, diags := parser.ParseHCLFile("../../../" + *node.Monitor + "/rps-threshold/terragrunt.hcl"); !diags.HasErrors() {
				decodeDiags := gohcl.DecodeBody(src.Body, nil, &rpsCfg)
				hideRPS = decodeDiags.HasErrors()
			}

			// latency-threshold
			if src, diags := parser.ParseHCLFile("../../../" + *node.Monitor + "/latency-threshold/terragrunt.hcl"); !diags.HasErrors() {
				decodeDiags := gohcl.DecodeBody(src.Body, nil, &latCfg)
				hideLatency = decodeDiags.HasErrors()
			}
		}

		topWidgetHeight := BigWidgetHeight
		if hideRPS && hideLatency {
			topWidgetHeight += WidgetHeight - WidgetTitleHeight
		}

		var name string
		if node.Name != nil {
			name = *node.Name
		}

		// has success rate
		if !hideSuccessRate {
			if qw := NewQueryWidget(
				layout{
					X:      startX,
					Y:      y,
					Height: topWidgetHeight,
					Width:  BigWidgetWidth,
				}, name, "%", 2, srCfg.Inputs,
			); qw != nil {
				b.QueryWidgets = append(b.QueryWidgets, *qw)
			}

			y += BigWidgetHeight

			// show rps
			if !hideRPS {
				if qw := NewQueryWidget(
					layout{
						X:      startX,
						Y:      y,
						Height: WidgetHeight,
						Width:  WidgetWidth,
					}, "", "RPS", 0, rpsCfg.Inputs,
				); qw != nil {
					b.QueryWidgets = append(b.QueryWidgets, *qw)
				}
			}

			// show latency
			if !hideLatency {
				if qw := NewQueryWidget(
					layout{
						X:      startX + WidgetWidth,
						Y:      y,
						Height: WidgetHeight,
						Width:  WidgetWidth,
					},
					"", "ms", 2, latCfg.Inputs,
				); qw != nil {
					b.QueryWidgets = append(b.QueryWidgets, *qw)
				}
			}

		} else {
			b.NoteWidgets = append(
				b.NoteWidgets,
				NewNoteWidget(
					layout{
						X:      startX,
						Y:      y,
						Height: topWidgetHeight,
						Width:  BigWidgetWidth,
					},
					*node.Name,
				),
			)
		}
	}

	return BigWidgetWidth + (2 * Padding), BigWidgetHeight + WidgetHeight - WidgetTitleHeight + (2 * Padding)
}

func (b *board) processColumn(startX, startY int, column Column, isSectionEmpty bool) (width, height int, isEmpty bool) {

	if len(column.Nodes) == 0 && isSectionEmpty {
		return BigWidgetWidth + (2 * Padding), BigWidgetHeight + WidgetHeight - WidgetTitleHeight + (2 * Padding), true
	}

	if len(column.Nodes) == 0 {
		return 0, 0, true
	}

	x := startX + Padding
	y := startY

	var columnWidth, columnHeight int
	for _, node := range column.Nodes {
		nodeWidth, nodeHeight := b.generateNode(x, columnHeight+y, node)
		columnHeight += nodeHeight

		if nodeWidth > columnWidth {
			columnWidth = nodeWidth
		}
	}

	return columnWidth, columnHeight, false
}

func (b *board) processSection(startX, startY int, name string, section Section) (width, height int) {
	if len(section.Cols) == 0 {
		return 0, 0
	}

	var sectionWidth, sectionHeight int
	isEmptySection := true
	for _, column := range section.Cols {
		columnWidth, columnHeight, isEmptyColumn := b.processColumn(startX+sectionWidth, startY+SectionHeaderHeight, column, name == "-")

		if !isEmptyColumn {
			isEmptySection = false
		}

		sectionWidth += columnWidth

		if columnHeight > sectionHeight {
			sectionHeight = columnHeight
		}
	}

	if isEmptySection {
		return sectionWidth + 2, sectionHeight + SectionHeaderHeight
	}

	// section name
	b.NoteWidgets = append(
		b.NoteWidgets,
		NewNoteWidget(
			layout{
				X:      startX,
				Y:      startY,
				Height: SectionHeaderHeight,
				Width:  sectionWidth,
			},
			name,
		),
	)

	return sectionWidth, sectionHeight + SectionHeaderHeight
}

func (b *board) processGroup(startX, startY int, name string, group Group) (width, height int) {
	if len(group.Sections) == 0 {
		return 0, 0
	}

	// group title example is TOKOPEDIA MITRA, TOKOPEDIA DIGITAL, TOKOPEDIA PLAY, TOKOPEDIA DIGITAL B2B
	b.FreeTextWidgets = append(
		b.FreeTextWidgets,
		NewFreeTextWidget(
			layout{
				X:      startX,
				Y:      startY + Padding,
				Height: GroupNameHeight,
				Width:  GroupNameWidth,
			},
			name, GroupFontSize,
		),
	)

	startY += GroupNameHeight + 2*Padding

	var groupWidth, groupHeight int
	for index, section := range group.Sections {
		if index > 0 && section.Name != "-" {
			b.ImageWidgets = append(
				b.ImageWidgets,
				NewImageWidget(
					layout{
						X:      startX + groupWidth + Padding,
						Y:      startY,
						Height: SectionHeaderHeight,
						Width:  SectionArrowWidth,
					},
					"https://img.icons8.com/carbon-copy/100/000000/arrow.png",
				),
			)
			groupWidth += SectionArrowWidth + 2*Padding
		}

		sectionWidth, sectionHeight := b.processSection(startX+groupWidth, startY, section.Name, section)
		groupWidth += sectionWidth

		if sectionHeight > groupHeight {
			groupHeight = sectionHeight
		}
	}

	return groupWidth, groupHeight + GroupNameHeight + 2*Padding
}

func (b *board) processRow(startY int, row Row) (height int) {
	if len(row.Groups) == 0 {
		return startY
	}

	var startX, rowHeight int
	for _, group := range row.Groups {
		groupWidth, groupHeight := b.processGroup(startX, startY, group.Name, group)
		startX += groupWidth + 20
		if groupHeight > rowHeight {
			rowHeight = groupHeight
		}
	}

	return rowHeight
}
