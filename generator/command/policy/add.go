package policy

import (
	"fmt"
	"os"
	"strings"

	"github.com/tokopedia/obac/generator/directorate"
)

//ChangeWithDynamicENV set dynamic env
func ChangeWithDynamicENV(path string, typeValue string) {
	paths := strings.Split(path, "/")

	if len(paths) < 5 {
		fmt.Println(os.Getenv(typeValue))
		return
	}

	directorateName := paths[3]
	accountInfo := directorate.GetListDirectorate()[directorateName]

	if typeValue == "NEW_RELIC_ACCOUNT_ID" && accountInfo.ID == "" {
		fmt.Println(os.Getenv(typeValue))
		return
	}

	if typeValue == "NEW_RELIC_API_KEY" && accountInfo.APIKey == "" {
		fmt.Println(os.Getenv(typeValue))
		return
	}

	if typeValue == "NEW_RELIC_ACCOUNT_ID" {
		fmt.Println(accountInfo.ID)
		return
	}

	if typeValue == "NEW_RELIC_API_KEY" {
		fmt.Println(accountInfo.APIKey)
		return
	}

	fmt.Println(os.Getenv(typeValue))
	return
}
