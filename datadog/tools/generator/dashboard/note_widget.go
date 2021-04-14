package main

import "fmt"

type NoteWidget struct {
	Layout    layout              `json:"layout"`
	Content   string              `json:"content"`
	ExtraArgs noteWidgetExtraArgs `json:"extra_args"`
}

type noteWidgetExtraArgs struct {
	BackgroundColor string `json:"background_color"`
	FontSize        string `json:"font_size"`
	ShowTick        bool   `json:"show_tick"`
	TextAlign       string `json:"text_align"`
	TickEdge        string `json:"tick_edge"`
	TickPos         string `json:"tick_pos"`
}

func NewNoteWidget(lay layout, content string) NoteWidget {
	return NoteWidget{
		Layout:  lay,
		Content: fmt.Sprintf("**%s**", content),
		ExtraArgs: noteWidgetExtraArgs{
			BackgroundColor: "white",
			FontSize:        "36",
			ShowTick:        false,
			TextAlign:       "center",
			TickEdge:        "left",
			TickPos:         "50%",
		},
	}
}
