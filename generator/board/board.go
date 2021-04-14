package board

import (
	"github.com/hashicorp/hcl2/hcl"
	"github.com/zclconf/go-cty/cty"
)

type MonitorConfig struct {
	Remain hcl.Body  `hcl:",remain"`
	Inputs cty.Value `hcl:"inputs"`
}
