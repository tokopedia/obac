package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	var srcName string

	flag.StringVar(&srcName, "src", "somefile", "file")
	flag.Parse()

	data, err := ioutil.ReadFile(fmt.Sprintf("%s/terragrunt.hcl", srcName))
	if err != nil {
		if strings.Contains(err.Error(), "no such file or directory") {
			fmt.Println("the file changes is deleted the file")
			return
		}
		log.Fatalln("error read file", err)
	}

	content := string(data)

	if strings.Contains(srcName, "_executive") && // check the path is executive path
		strings.Contains(srcName, "success-rate-threshold") && // check the dir is success-rate-threshold
		!strings.Contains(content, "@webhook-Post-911-emergency") {
		log.Fatalln("file changes should be have webhook post to 911 emergency")
		panic("should be stopped file not contain post to 911 emergency")
	}

	fmt.Println("ok this changes valid")
}
