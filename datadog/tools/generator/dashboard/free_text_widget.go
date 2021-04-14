package main

import "fmt"

type FreeTextWidget struct {
	Layout    layout                  `json:"layout"`
	Text      string                  `json:"text"`
	ExtraArgs freeTextWidgetExtraArgs `json:"extra_args"`
}

type freeTextWidgetExtraArgs struct {
	Color     string `json:"color"`
	FontSize  string `json:"font_size"`
	TextAlign string `json:"text_align"`
}

func NewFreeTextWidget(lay layout, text string, fontSize int) FreeTextWidget {
	return FreeTextWidget{
		Layout: lay,
		Text:   text,
		ExtraArgs: freeTextWidgetExtraArgs{
			Color:     "#000",
			FontSize:  fmt.Sprintf("%d", fontSize),
			TextAlign: "left",
		},
	}
}
