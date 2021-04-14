package main

import (
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclparse"

	"github.com/tokopedia/obac/generator/board"
	"github.com/tokopedia/obac/generator/command/droprule"
	"github.com/tokopedia/obac/generator/command/policy"
	"github.com/tokopedia/obac/generator/directorate"
	"github.com/tokopedia/obac/generator/newrelic"
	"github.com/tokopedia/obac/generator/newrelic/document"
)

type Req struct {
	Query    string                 `json:"query"`
	Variable map[string]interface{} `json:"variables"`
}

func generateExisting(srcName string) []document.Widget {
	var cfg board.Config
	var diags hcl.Diagnostics

	parser := hclparse.NewParser()
	file, parseDiags := parser.ParseHCLFile(srcName)
	diags = append(diags, parseDiags...)
	if diags.HasErrors() {
		log.Fatal(diags)
	}

	decodeDiags := gohcl.DecodeBody(file.Body, nil, &cfg)
	diags = append(diags, decodeDiags...)
	if diags.HasErrors() {
		log.Fatal(diags)
	}

	startY := 0
	maxYInSection := 0
	wdNR := make([]document.Widget, 0)

	// init configuration of widget
	nodeWidget := board.Widget{
		NodeWidth:     5,
		NodeHeight:    7,
		ArrowHeight:   1,
		ArrowWidth:    1,
		SectionHeight: 2,
		GroupHeight:   2,
		GroupWidth:    5,
		SpaceInRow:    2,
	}

	for r, row := range cfg.Rows {
		// set the space between every rows
		// with calculation current position of Y and max Y position in every row
		// the calculation should be start at row > 0
		maxYInSection = maxYInSection + (nodeWidget.MaxYInRow)*nodeWidget.NodeHeight

		if r == 0 {
			startY = maxYInSection
		} else {
			// (nodeWidget.SectionHeight + nodeWidget.GroupHeight)*r => 1 height section + 1 height group
			// nodeWidget.SpaceInRow*r => space between every rows
			startY = maxYInSection + (nodeWidget.SpaceInRow * r) + ((nodeWidget.SectionHeight + nodeWidget.GroupHeight) * r)
		}

		startX := 0
		nodeWidget.MaxYInRow = 0
		startYGroup := startY
		for g, group := range row.Groups {
			// set group widget
			//startYGroup is starting point of group widget,
			// this one will fill with starting point of Y coordinate in every row
			// because every row has multiple group

			var totalCols int
			for _, scCol := range group.Sections {
				totalCols = totalCols + len(scCol.Cols)
			}

			gr := document.Widget{
				Name:      group.Name,
				X:         startX,
				Y:         startYGroup,
				Width:     (nodeWidget.GroupWidth * totalCols) + (len(group.Sections) - 1),
				Height:    nodeWidget.GroupHeight,
				HTMLChart: "group",
				Chart:     "open:html",
			}
			wdNR = append(wdNR, gr)

			// set only the first , because others Y position group will follow the first group
			if g == 0 {
				startY = startY + nodeWidget.GroupHeight
			}

			//set the width of section
			//section value like, User+Platform, Home, Search and etc
			//one section have multiple column
			//in every column has multiple node
			for s, section := range group.Sections {
				//set section
				sec := document.Widget{
					Name:      section.Name,
					X:         startX,
					Y:         startY,
					Width:     len(section.Cols) * nodeWidget.NodeWidth,
					Height:    nodeWidget.SectionHeight,
					HTMLChart: "section",
					Chart:     "open:html",
				}
				wdNR = append(wdNR, sec)

				// fill the box to column at section part
				widgetColumn := nodeWidget.FillNodeInColumn(
					startX,
					startY,
					section,
				)
				wdNR = append(wdNR, widgetColumn...)

				// set arrow
				var arrowImg []document.Widget
				arrowImg, startX = nodeWidget.SetArrow(startX, startY, section, group, s)
				wdNR = append(wdNR, arrowImg...)
			}
		}
	}

	return wdNR

}

func main() {
	var (
		srcName  string
		docID    string
		funcName string
		itemDir  string
	)

	flag.StringVar(&srcName, "src", "board.hcl", "board definition file name")
	flag.StringVar(&docID, "docID", "testing-open-board", "open board docs id")
	flag.StringVar(&funcName, "cmd", "generate-dashboard", "to choose func name to be executed")
	flag.StringVar(&itemDir, "itemDir", "", "get current directorate changes")
	flag.Parse()

	// get mapping directorate per account
	directorate.SetDirectorate()

	switch strings.ToLower(funcName) {
	case strings.ToLower("change-env-api-key"):
		policy.ChangeWithDynamicENV(itemDir, "NEW_RELIC_API_KEY")
		return
	case strings.ToLower("change-env-acc-id"):
		policy.ChangeWithDynamicENV(itemDir, "NEW_RELIC_ACCOUNT_ID")
		return
	case strings.ToLower("drop-rule-summary"):
		droprule.GenerateSummary(itemDir)
		return
	}

	v, a := newrelic.GenMutationGQL(document.NerdStorageWriteDocument{
		Document: document.Document{
			Widgets: generateExisting(srcName),
		},
	})

	bt, _ := json.Marshal(Req{
		Query: newrelic.NerdStorageWriteDocumentSchema,
		Variable: map[string]interface{}{
			"doc":        v,
			"scope":      a,
			"docID":      docID,
			"collection": "OpenBoards",
		},
	})

	req, err := http.NewRequest(http.MethodPost, "https://api.newrelic.com/graphql", bytes.NewBuffer(bt))

	if err != nil {
		return
	}

	req.Header.Set("API-Key", os.Getenv("NEW_RELIC_API_KEY"))
	req.Header.Set("newrelic-package-id", os.Getenv("OPEN_BOARD_PACKAGE_ID"))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	fmt.Println("response Status:", resp.Status)
	fmt.Println("response Headers:", resp.Header)
	body, _ := ioutil.ReadAll(resp.Body)
	fmt.Println("response Body:", string(body))
}
