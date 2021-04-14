package main

import (
	"flag"
	"log"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclparse"
)

type Config struct {
	Name string `hcl:"name,attr"`
	Rows []Row  `hcl:"row,block"`
}

type Row struct {
	Groups []Group `hcl:"group,block"`
}

type Group struct {
	Name     string    `hcl:"name,label"`
	Sections []Section `hcl:"section,block"`
}

type Section struct {
	Name string `hcl:"name,label"`
	// SLOCols []SLOColumn `hcl:"slo_column,block"`
	Cols []Column `hcl:"column,block"`
}

type Column struct {
	Nodes []Node `hcl:"node,block"`
}

type Node struct {
	Type    *string `hcl:"type,attr"`
	Name    *string `hcl:"name,attr"`
	Monitor *string `hcl:"monitor,attr"`
}

func main() {
	var srcName string

	flag.StringVar(&srcName, "src", "board.hcl", "board definition file name")
	flag.Parse()

	var cfg Config
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

	b := board{
		Name:            cfg.Name,
		FreeTextWidgets: []FreeTextWidget{},
		NoteWidgets:     []NoteWidget{},
		ImageWidgets:    []ImageWidget{},
		QueryWidgets:    []QueryWidget{},
	}

	var startY int
	for _, row := range cfg.Rows {
		rowHeight := b.processRow(startY, row)
		startY += rowHeight + 10
	}

	err := b.Generate()
	if err != nil {
		log.Fatal(err)
	}
}
