.POSIX:

.PHONY: all
all: build format validate

.PHONY: install
install:
	command -v terraform >/dev/null 2>&1 || GO111MODULE="on" go get github.com/hashicorp/terraform@v0.12.26
	command -v terraform-docs >/dev/null 2>&1 || GO111MODULE="on" go get github.com/segmentio/terraform-docs@v0.16.0
	command -v tfsec >/dev/null 2>&1 || GO111MODULE="on" go get github.com/liamg/tfsec/cmd/tfsec@v0.21.0
	command -v tflint >/dev/null 2>&1 || GO111MODULE="on" go get github.com/terraform-linters/tflint@v0.16.2

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