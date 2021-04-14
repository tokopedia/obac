package document

type NerdStorageWriteDocument struct {
	Collection string
	DocumentID string
	Document   Document
}

type Document struct {
	HTMLWidgets []HTMLWidget
	Widgets     []Widget
}

type HTMLWidget struct {
	Name  string
	Value string
}

type Widget struct {
	Name           string
	Chart          string
	StyleCondition []interface{}
	Sources        []Source
	Event          []interface{}
	MultiQueryMode string
	Props          interface{}
	Ms             string
	X              int
	Y              int
	Width          int
	Height         int
	WidgetType     string
	HTMLChart      string
}

type Source struct {
	NRQL    string
	Account string
}

type NRQLNerdStorageDocument struct {
	Widgets    []NRQLWidget     `json:"widgets"`
	HTMLWidget []NRQLHTMLWidget `json:"htmlWidgets"`
}

type NRQLSource struct {
	NrqlQuery string `json:"nrqlQuery"`
	Accounts  []int  `json:"accounts"`
}

type NRQLWidget struct {
	Name            string        `json:"name"`
	Chart           string        `json:"chart"`
	StyleConditions []interface{} `json:"styleConditions"`
	Sources         []NRQLSource  `json:"sources"`
	Events          []interface{} `json:"events"`
	MultiQueryMode  string        `json:"multiQueryMode"`
	Props           struct {
	} `json:"props"`
	Ms        string `json:"ms"`
	X         int    `json:"x"`
	Y         int    `json:"y"`
	W         int    `json:"w"`
	H         int    `json:"h"`
	Type      string `json:"type"`
	HTMLChart string `json:"htmlChart"`
}

type NRQLAccount struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

type NRQLHTMLWidget struct {
	Name  string `json:"name"`
	Value string `json:"value"`
}
