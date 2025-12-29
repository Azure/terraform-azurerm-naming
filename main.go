package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"sort"
	"strings"
	"text/template"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
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

// validateResource checks that a resource has all required fields
func validateResource(r Resource, source string) error {
	if r.Name == "" {
		return fmt.Errorf("resource missing required field 'name' in %s", source)
	}
	if r.Slug == nil || *r.Slug == "" {
		return fmt.Errorf("resource '%s' missing required field 'slug' in %s", r.Name, source)
	}
	if r.Length == nil {
		return fmt.Errorf("resource '%s' missing required field 'length' in %s", r.Name, source)
	}
	if r.Length.Min < 0 {
		return fmt.Errorf("resource '%s' has invalid min_length (%d) in %s", r.Name, r.Length.Min, source)
	}
	if r.Length.Max <= 0 {
		return fmt.Errorf("resource '%s' has invalid max_length (%d) in %s", r.Name, r.Length.Max, source)
	}
	if r.Length.Min > r.Length.Max {
		return fmt.Errorf("resource '%s' has min_length (%d) greater than max_length (%d) in %s", r.Name, r.Length.Min, r.Length.Max, source)
	}
	return nil
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
	caser := cases.Title(language.AmericanEnglish)
	parsedTemplate, err := template.New("templates").Funcs(template.FuncMap{
		// Terraform not yet support lookahead in their regex function
		"cleanRegex": func(dirtyString string) string {
			var re = regexp.MustCompile(`(?m)\(\?=.{\d+,\d+}\$\)|\(\?!\.\*--\)`)
			return re.ReplaceAllString(dirtyString, "")
		},
		"replace": strings.ReplaceAll,
		"title":   caser.String,
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

	// Validate resources from resourceDefinition.json
	for _, r := range data {
		if err := validateResource(r, "resourceDefinition.json"); err != nil {
			log.Fatal(err)
		}
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

	// Validate resources from resourceDefinition_out_of_docs.json
	for _, r := range dataUndocumented {
		if err := validateResource(r, "resourceDefinition_out_of_docs.json"); err != nil {
			log.Fatal(err)
		}
	}

	// Check for duplicate resource names before merging
	seenNames := make(map[string]string)
	for _, r := range data {
		seenNames[r.Name] = "resourceDefinition.json"
	}
	for _, r := range dataUndocumented {
		if source, exists := seenNames[r.Name]; exists {
			log.Fatalf("duplicate resource name '%s' found in both %s and resourceDefinition_out_of_docs.json", r.Name, source)
		}
		seenNames[r.Name] = "resourceDefinition_out_of_docs.json"
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
	defer mainFile.Close()

	if err := parsedTemplate.ExecuteTemplate(mainFile, "main", data); err != nil {
		log.Fatal(err)
	}

	outputsFile, err := os.OpenFile("outputs.tf", os.O_TRUNC|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	defer outputsFile.Close()

	if err := parsedTemplate.ExecuteTemplate(outputsFile, "outputs", data); err != nil {
		log.Fatal(err)
	}
}
