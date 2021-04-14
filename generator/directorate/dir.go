package directorate

import (
	"os"
	"strings"
	"sync"
)

var listDirectorateAccount map[string]AccountDirectorate
var once sync.Once

type AccountDirectorate struct {
	ID     string
	APIKey string
}

func SetDirectorate() {
	// account stored as separated value
	// acc1:accoundID:apikey|acc2:accoundID:apikey
	raw := os.Getenv("NEW_RELIC_ACCOUNT_DIRECTORATE")

	raws := strings.Split(raw, "|")

	list := make(map[string]AccountDirectorate)
	for _, accWithKey := range raws {
		arrAccWithKey := strings.Split(accWithKey, ":")

		if len(arrAccWithKey) == 3 {
			list[strings.ToLower(arrAccWithKey[0])] = AccountDirectorate{
				ID:     arrAccWithKey[1],
				APIKey: arrAccWithKey[2],
			}
		}
	}

	once.Do(func() {
		listDirectorateAccount = list
	})
}

func GetListDirectorate() map[string]AccountDirectorate {
	return listDirectorateAccount
}
