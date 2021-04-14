package board


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
	Name    string   `hcl:"name,label"`
	// SLOCols []SLOColumn `hcl:"slo_column,block"`
	Cols    []Column `hcl:"column,block"`
}

type Column struct {
	Nodes []Node `hcl:"node,block"`
}

type Node struct {
	Type *string `hcl:"type,attr"`
	Name *string `hcl:"name,attr"`
	Monitor *string `hcl:"monitor,attr"`
}
