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
	var fileNames = make([]string, len(files))
	for i, file := range files {
		fileNames[i] = "templates/" + file.Name()
	}
	parsedTemplate, err := template.ParseFiles(fileNames...)
	if err != nil {
		log.Fatal(err)
	}

	sourceDefinitions, err := ioutil.ReadFile("resourceDefinition.jsonc")
	if err != nil {
		log.Fatal(err)
	}
	var data []Resource
	jc := jsonc.ToJSON(sourceDefinitions)
	err = json.Unmarshal(jc, &data)
	if err != nil {
		log.Fatal(err)
	}

	// Undocumented resource definitions
	sourceDefinitionsUndocumented, err := ioutil.ReadFile("resourceDefinition_out_of_docs.jsonc")
	if err != nil {
		log.Fatal(err)
	}
	var dataUndocumented []Resource
	jcUndoc := jsonc.ToJSON(sourceDefinitionsUndocumented)
	err = json.Unmarshal(jcUndoc, &dataUndocumented)
	if err != nil {
		log.Fatal(err)
	}
	data = append(data, dataUndocumented...)

	mainFile, err := os.OpenFile("main.tf", os.O_TRUNC|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	parsedTemplate.ExecuteTemplate(mainFile, "main", data)
	outputsFile, err := os.OpenFile("outputs.tf", os.O_TRUNC|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	parsedTemplate.ExecuteTemplate(outputsFile, "outputs", data)
}
