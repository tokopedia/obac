package droprule

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"

	"github.com/hashicorp/hcl2/gohcl"
	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclparse"
	"github.com/zclconf/go-cty/cty"

	"github.com/tokopedia/obac/generator/command/helper"
)

type MonitorConfig struct {
	Remain hcl.Body  `hcl:",remain"`
	Inputs cty.Value `hcl:"inputs"`
}

//GenerateSummary go run ./generator/main.go -itemDir=new-relic/monitors/directorate/pdp/drop-rules -cmd=drop-rule-summary
func GenerateSummary(path string) {
	dirs := strings.Split(path, "/")

	if len(dirs) != 5 {
		fmt.Println("directory not valid")
		return
	}

	directorate := dirs[3]

	paths, err := helper.FilePathWalkDir(path)

	if err != nil {
		log.Println("failed read directory", err)
		return
	}

	listMetric := make([]string, 0)
	for _, val := range paths {
		parser := hclparse.NewParser()
		srcConfig := MonitorConfig{}

		if src, diags := parser.ParseHCLFile(fmt.Sprintf("./%s", val)); diags.HasErrors() {
			fmt.Println("error parse file")
			return
		} else {
			gohcl.DecodeBody(src.Body, nil, &srcConfig)
		}

		valueMap := srcConfig.Inputs.AsValueMap()
		query, ok := valueMap["metrics"]
		if !ok {
			fmt.Println("not ok (attribute not valid)")
			continue
		}

		for _, metric := range query.AsValueSlice() {
			listMetric = append(listMetric, fmt.Sprintf("'%s'", metric.AsString()))
		}

	}
	strListMetric := strings.Join(listMetric, ",")

	newPath := strings.Replace(path, "/drop-rules", "/drop-rules-summary", 1)

	err = os.Mkdir(newPath, 0777)

	if err != nil {
		fmt.Println("failed create directory", err)
		return
	}

	// write the whole body at once
	content := fmt.Sprintf(tmpl, directorate, strListMetric, strListMetric)
	err = ioutil.WriteFile(fmt.Sprintf("%s/terragrunt.hcl", newPath), []byte(content), 0644)
	if err != nil {
		panic(err)
	}

	fmt.Println("success create dashboard summary")
}
