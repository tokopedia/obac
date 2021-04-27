package board

import (
	"errors"
	"os"
	"strings"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hclparse"
	"github.com/zclconf/go-cty/cty"

	"github.com/tokopedia/obac/generator/directorate"
	"github.com/tokopedia/obac/generator/newrelic/document"
)

type Widget struct {
	NodeWidth      int
	NodeHeight     int
	MaxYInRow      int // MaxYInRow total calculation Y of node in a column and a row
	ArrowWidth     int
	ArrowHeight    int
	SectionHeight  int
	GroupHeight    int
	GroupWidth     int
	SpaceInRow     int
	HTMLWidgetID   string
	HTMLWidgetType string
}

var nrqlSources = []string{"success-rate", "rps", "latency"}

//SetNode is actually func to set the node (box) contain
// success rate, rps, processing time
//node Node is represent widget
//startX is represent start position of horizontal position
//startY is represent start position of vertical position
func (w *Widget) SetNode(node Node, startX, startY int) (document.Widget, int) {
	if node.Name == nil {
		node = Node{
			Name: func() *string {
				s := "unkonwn"
				return &s
			}(),
		}
	}

	var monit string
	if node.Monitor != nil {
		monit = *node.Monitor
	}
	// add policies & friend dir
	//monitSplit := strings.Split(monit, "/")
	//
	//if len(monitSplit) != 4 {
	//	//TODO should be ignore
	//	n := w.setEmptyNode(node, startX, startY)
	//	startY = startY + w.NodeHeight
	//	return n, startY
	//}

	//sourceDir := []string{"newrelic", monitSplit[0], "policies", "directorate", monitSplit[1], monitSplit[2], "conditions", monitSplit[3]}
	//TODO use the real one
	//sourceDir := []string{"newrelic", "monitors", "policies", "directorate", "home-and-browse", "_executive", "conditions", "homepage"}
	mainSourceDir := monit

	sources := make([]document.Source, 0)

	for _, source := range nrqlSources {
		parser := hclparse.NewParser()

		srcConfig := MonitorConfig{}

		dirArr := strings.Split(mainSourceDir, "/")

		if len(dirArr) < 3 {
			n := w.setEmptyNode(node, startX, startY)
			return n, startY
		}

		directorateName := dirArr[2]

		accInfo, ok := directorate.GetListDirectorate()[directorateName]
		accountID := accInfo.ID

		if !ok {
			accountID = os.Getenv("NEW_RELIC_ACCOUNT_ID")
		}

		if src, diags := parser.ParseHCLFile("./new-relic/" + mainSourceDir + "/" + source + "/terragrunt.hcl"); diags.HasErrors() {
			n := w.setEmptyNode(node, startX, startY)
			startY = startY + w.NodeHeight
			return n, startY
		} else {
			gohcl.DecodeBody(src.Body, nil, &srcConfig)
		}

		val, err := getValueHCLString("nrql_alert_condition_query", srcConfig.Inputs)
		if err != nil {
			//TODO should be ignore
			n := w.setEmptyNode(node, startX, startY)
			startY = startY + w.NodeHeight
			return n, startY
		}

		sources = append(sources, document.Source{
			NRQL: val,
			//TODO should get the real one
			Account: accountID,
		})
	}

	nod := document.Widget{
		Sources:   sources,
		Name:      *node.Name,
		X:         startX,
		Y:         startY,
		Width:     w.NodeWidth,
		Height:    w.NodeHeight,
		HTMLChart: "node",
		Chart:     "open:html",
	}

	startY = startY + w.NodeHeight
	return nod, startY
}

func (w *Widget) setEmptyNode(node Node, startX, startY int) document.Widget {
	return document.Widget{
		Name:      *node.Name,
		X:         startX,
		Y:         startY,
		Width:     w.NodeWidth,
		Height:    w.NodeHeight,
		HTMLChart: "node",
		Chart:     "open:html",
	}
}

func getValueHCLString(attr string, config cty.Value) (string, error) {
	valueMap := config.AsValueMap()
	query, ok := valueMap[attr]
	if !ok {
		return "", errors.New("not found attr")
	}

	return query.AsString(), nil
}

//FillNodeInColumn this method use for fill the node (box) at column level
// col1 | col2
// box1.1 | box2.1
// box1.2 | box2.2
// box1.3 |
func (w *Widget) FillNodeInColumn(startX, startY int, section Section) (wdNR []document.Widget) {
	for iColumn, column := range section.Cols {
		startNodeY := startY + w.SectionHeight
		for _, node := range column.Nodes {
			nod, currNodeY := w.SetNode(
				node,
				startX+(iColumn*w.NodeWidth),
				startNodeY,
			)
			startNodeY = currNodeY
			wdNR = append(wdNR, nod)
		}

		if w.MaxYInRow < len(column.Nodes) {
			// fill vertical node Y value in each row with the higher one
			// every new row has one maximum vertical node
			w.MaxYInRow = len(column.Nodes)
		}
	}
	return
}

//SetArrow is func to set the arrow between section in each group
func (w *Widget) SetArrow(startX, startY int, section Section, group Group, s int) (wdNR []document.Widget, newStartX int) {
	newStartX = startX + (len(section.Cols) * w.NodeWidth)
	// don't set arrow if last of node in section
	if s < len(group.Sections)-1 {
		arrowImg := document.Widget{
			Name:      " ",
			X:         newStartX,
			Y:         startY,
			Width:     w.ArrowWidth,
			Height:    w.ArrowHeight,
			HTMLChart: "arrow",
			Chart:     "open:html",
		}

		wdNR = append(wdNR, arrowImg)
		// every add arrow need calculate horizontal starting point
		newStartX = newStartX + w.ArrowWidth
	}

	return
}
