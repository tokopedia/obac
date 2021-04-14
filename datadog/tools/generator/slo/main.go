package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclparse"
)

type config struct {
	SLO slo `hcl:"slo,block"`
}

type slo struct {
	Name     string   `hcl:"name,label"`
	Monitors []string `hcl:"monitors"`
}

const (
	templateSLO string = `include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::github.com:tokopedia/obac.git//tf-module//datadog//slo"
}

// dependencies
%s

inputs = {
  slo_name = "%s"
  slo_monitor_ids = [ %s ]
}`

	templateDependency = `dependency "%d" {
  config_path = "../../../%s"
}`

	templateMonitorID = `dependency.%d.outputs.monitor_id`
)

func main() {
	var srcName string

	flag.StringVar(&srcName, "src", "slo.hcl", "SLO definition file name")
	flag.Parse()

	var cfg config
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

	dependencies := make([]string, len(cfg.SLO.Monitors))
	monitors := make([]string, len(cfg.SLO.Monitors))

	for i, monitor := range cfg.SLO.Monitors {

		if _, err := os.Stat(fmt.Sprintf("../../../%s", monitor)); os.IsNotExist(err) {
			log.Fatal(err)
		}

		dependencies[i] = fmt.Sprintf(templateDependency, i, monitor)
		monitors[i] = fmt.Sprintf(templateMonitorID, i)
	}

	fmt.Printf(
		templateSLO,
		strings.Join(dependencies, "\n"),
		cfg.SLO.Name,
		strings.Join(monitors, ",\n"),
	)
}
