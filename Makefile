.POSIX:

.PHONY: all
all: build format validate

.PHONY: install
install:
	command -v terraform >/dev/null 2>&1 || go install github.com/hashicorp/terraform@v1.2.5
	command -v terraform-docs >/dev/null 2>&1 || go install github.com/terraform-docs/terraform-docs@v0.16.0
	command -v tfsec >/dev/null 2>&1 || go install github.com/aquasecurity/tfsec/cmd/tfsec@latest
	command -v tflint >/dev/null 2>&1 || go install github.com/terraform-linters/tflint@v0.38.1

.PHONY: build
build: install generate

.PHONY: generate
generate:
	go run main.go

.PHONY: format
format:
	terraform fmt

.PHONY: validate
validate:
	terraform fmt --check
	terraform validate -no-color
	tflint --no-color