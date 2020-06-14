package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"text/template"

	"muzzammil.xyz/jsonc"
)

// Resource definityion for the package
type Resource struct {
	Name   string  `json:"name"`
	Length *Length `json:"length,omitempty"`
	Regex  *string `json:"regex,omitempty"`
	Scope  *string `json:"scope,omitempty"`
	Slug   *string `json:"slug,omitempty"`
	Dashes bool    `json:"dashes"`
}

// Length allowed for that resorce
type Length struct {
	Min int `json:"min"`
	Max int `json:"max"`
}

func main() {
	files, err := ioutil.ReadDir("templates")
	if err != nil {
		log.Fatal(err)
	}
	var fileNames = make([]string, 0)
	for _, file := range files {
		fileNames = append(fileNames, "templates/"+file.Name())
	}
	parsedTemplate, err := template.ParseFiles(fileNames...)
	if err != nil {
		log.Fatal(err)
	}

	sourceDefinitions, err := ioutil.ReadFile("resorceDefinition.jsonc")
	if err != nil {
		log.Fatal(err)
	}
	var data []Resource
	jc := jsonc.ToJSON(sourceDefinitions)
	err = json.Unmarshal(jc, &data)
	if err != nil {
		log.Fatal(err)
	}

	mainFile, err := os.OpenFile("generated_main.tf", os.O_TRUNC|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	parsedTemplate.ExecuteTemplate(mainFile, "main", data)
	outputsFile, err := os.OpenFile("generated_outputs.tf", os.O_TRUNC|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	parsedTemplate.ExecuteTemplate(outputsFile, "outputs", data)
}
