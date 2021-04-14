package main

type ImageWidget struct {
	Layout    layout               `json:"layout"`
	URL       string               `json:"url"`
	ExtraArgs imageWidgetExtraArgs `json:"extra_args"`
}

type imageWidgetExtraArgs struct {
	Sizing string `json:"sizing"`
}

func NewImageWidget(lay layout, url string) ImageWidget {
	return ImageWidget{
		Layout: lay,
		URL:    url,
		ExtraArgs: imageWidgetExtraArgs{
			Sizing: "fit",
		},
	}
}
