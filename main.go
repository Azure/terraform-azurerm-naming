package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"sort"
	"text/template"
)

// Resource definition for the package
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
	parsedTemplate, err := template.New("templates").Funcs(template.FuncMap{
		// Terraform not yet support lookahead in their regex function
		"cleanRegex": func(dirtyString string) string {
			var re = regexp.MustCompile(`(?m)\(\?=.{\d+,\d+}\$\)|\(\?!\.\*--\)`)
			return re.ReplaceAllString(dirtyString, "")
		},
	}).ParseFiles(fileNames...)
	if err != nil {
		log.Fatal(err)
	}

	sourceDefinitions, err := ioutil.ReadFile("resourceDefinition.json")
	if err != nil {
		log.Fatal(err)
	}
	var data []Resource
	err = json.Unmarshal(sourceDefinitions, &data)
	if err != nil {
		log.Fatal(err)
	}

	// Undocumented resource definitions
	sourceDefinitionsUndocumented, err := ioutil.ReadFile("resourceDefinition_out_of_docs.json")
	if err != nil {
		log.Fatal(err)
	}
	var dataUndocumented []Resource
	err = json.Unmarshal(sourceDefinitionsUndocumented, &dataUndocumented)
	if err != nil {
		log.Fatal(err)
	}
	data = append(data, dataUndocumented...)

	// Sort the documented and undocumented resources alphabetically
	sort.Slice(data, func(i, j int) bool {
		return data[i].Name < data[j].Name
	})

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
