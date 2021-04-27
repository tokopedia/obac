package newrelic

import (
	"os"
	"strconv"

	"github.com/tokopedia/obac/generator/newrelic/document"
)

func GenMutationGQL(doc document.NerdStorageWriteDocument) (document.NRQLNerdStorageDocument, document.NRQLAccount) {
	var v document.NRQLNerdStorageDocument
	for _, widget := range doc.Document.Widgets {
		nrqlSource := make([]document.NRQLSource, 0)
		for _, source := range widget.Sources {
			accInt, _ := strconv.Atoi(source.Account)

			nrqlSource = append(nrqlSource, document.NRQLSource{
				NrqlQuery: source.NRQL,
				Accounts: []int{
					accInt,
				},
			})
		}
		v.Widgets = append(v.Widgets, document.NRQLWidget{
			Name:            widget.Name,
			Chart:           widget.Chart,
			StyleConditions: []interface{}{},
			Sources:         nrqlSource,
			Events:          []interface{}{},
			MultiQueryMode:  "group",
			Props:           struct{}{},
			Ms:              "",
			X:               widget.X,
			Y:               widget.Y,
			W:               widget.Width,
			H:               widget.Height,
			Type:            "nrql",
			HTMLChart:       widget.HTMLChart,
		})
	}

	htmlWidget := make([]document.NRQLHTMLWidget, 0)

	//#41c464 = green
	//#ffbf00 = yellow
	//#eb364b = red
	htmlWidget = append(htmlWidget, document.NRQLHTMLWidget{
		Name: "node",
		Value: `
<div style="text-align:center">
		<div style="border:1px solid white;height:140px;color:white;display:flex;justify-content:center;align-items:center;font-weight:bold;font-size:larger;background-color:${((Q1:SuccessRate)*100) < 99.5 ? ( ((Q1:SuccessRate)*100) < 99 ? '#eb364b' : '#ffbf00') :'#41c464'}">
<label style="font-size: 45px;">${((Q1:SuccessRate)*100).toFixed(2)}</label> <p> %</p>
</div>
		<div style="column-count:2;text-align:center;column-gap:1px">
		<div style="border:1px solid white;height:60px;color:white;display:flex;justify-content:center;align-items:center;font-weight:bold;font-size:larger;background-color:${Q2:RPS < 2 ? (Q2:RPS <= 1  ? '#eb364b' : '#ffbf00') :'#41c464'}">
<label style="font-size: 15px;">${(Q2:RPS).toFixed(2)}</label>  <p> RPS</p></div>

		<div style="border:1px solid white;height:60px;color:white;display:flex;justify-content:center;align-items:center;font-weight:bold;font-size:larger;background-color:${Q3:Latency > 100 ? (Q3:Latency > 200 ? '#eb364b' : '#ffbf00') :'#41c464'}">
<label style="font-size: 15px;">${(Q3:Latency).toFixed(2)}</label> <p> ms</p></div>
</div></div><div>
<div>
`,
	})

	htmlWidget = append(htmlWidget, document.NRQLHTMLWidget{
		Name:  "section",
		Value: `<div class="section" style="font-size:30px !important;"></div>`,
	})

	htmlWidget = append(htmlWidget, document.NRQLHTMLWidget{
		Name:  "group",
		Value: `<div class="group" style="font-size:50px !important;"></div>`,
	})

	htmlWidget = append(htmlWidget, document.NRQLHTMLWidget{
		Name: "arrow",
		Value: `<div class="group" style="font-size:50px !important;">
			<img src="https://img.icons8.com/carbon-copy/100/000000/arrow.png"/>
		</div>`,
	})

	v.HTMLWidget = htmlWidget

	a := document.NRQLAccount{
		ID:   os.Getenv("NEW_RELIC_ACCOUNT_ID"),
		Name: "ACCOUNT",
	}
	return v, a
}
