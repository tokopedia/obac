package main

import (
	"github.com/zclconf/go-cty/cty"
	"regexp"
)

type QueryWidget struct {
	Layout    layout               `json:"layout"`
	Request   queryWidgetRequest   `json:"request"`
	ExtraArgs queryWidgetExtraArgs `json:"extra_args"`
}

type queryWidgetRequest struct {
	Q                  string              `json:"q"`
	Aggregator         string              `json:"aggregator"`
	ConditionalFormats []conditionalFormat `json:"conditional_formats"`
}

type conditionalFormat struct {
	Comparator string `json:"comparator"`
	Palette    string `json:"palette"`
	Value      string `json:"value"`
}

type queryWidgetExtraArgs struct {
	AutoScale  bool   `json:"autoscale"`
	CustomUnit string `json:"custom_unit"`
	Precision  int    `json:"precision"`
	Title      string `json:"title"`
	TitleAlign string `json:"title_align"`
	TitleSize  int    `json:"title_size"`
}

func NewQueryWidget(lay layout, title, customUnit string, precision int, config cty.Value) *QueryWidget {
	valueMap := config.AsValueMap()
	query, ok := valueMap["monitor_query"]
	if !ok {
		return nil
	}

	re := regexp.MustCompile(`^(.*)\(.*\):(.*)([<>]=?)[ ]*`)
	matches := re.FindStringSubmatch(query.AsString())

	thresholdCritical, ok := valueMap["monitor_thresholds_critical"]
	if !ok {
		return nil
	}

	conditionalFormats := []conditionalFormat{
		{
			Comparator: matches[3],
			Palette:    "white_on_red",
			Value:      thresholdCritical.AsBigFloat().String(),
		},
	}

	if thresholdWarning, ok := valueMap["monitor_thresholds_warning"]; ok {
		conditionalFormats = append(
			conditionalFormats,
			conditionalFormat{
				Comparator: matches[3],
				Palette:    "white_on_yellow",
				Value:      thresholdWarning.AsBigFloat().String(),
			},
		)
	}

	nCond := "<="
	switch matches[3] {
	case "<":
		nCond = ">="
	case "<=":
		nCond = ">"
	case ">=":
		nCond = "<="
	}

	conditionalFormats = append(
		conditionalFormats,
		conditionalFormat{
			Comparator: nCond,
			Palette:    "white_on_green",
			Value:      thresholdCritical.AsBigFloat().String(),
		},
	)

	return &QueryWidget{
		Layout: lay,
		Request: queryWidgetRequest{
			Q:                  matches[2],
			Aggregator:         matches[1],
			ConditionalFormats: conditionalFormats,
		},
		ExtraArgs: queryWidgetExtraArgs{
			AutoScale:  true,
			CustomUnit: customUnit,
			Precision:  precision,
			Title:      title,
			TitleAlign: "left",
			TitleSize:  16,
		},
	}
}
