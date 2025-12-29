# Contributing to terraform-azurerm-naming

Thank you for your interest in contributing to this project! This guide will help you understand how the project works and how to contribute effectively.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [How Code Generation Works](#how-code-generation-works)
- [Adding a New Azure Resource](#adding-a-new-azure-resource)
- [Running Locally](#running-locally)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Getting Help](#getting-help)

## Prerequisites

Before contributing, ensure you have the following installed:

| Tool | Version | Purpose |
|------|---------|---------|
| [Go](https://golang.org/dl/) | 1.23+ | Runs the code generator |
| [Terraform](https://www.terraform.io/downloads) | 1.0+ | Validates generated files |
| [Make](https://www.gnu.org/software/make/) | Any | Build automation (Linux/macOS) |
| [tflint](https://github.com/terraform-linters/tflint) | Latest | Terraform linting |

**Optional but recommended:**
- [pre-commit](https://pre-commit.com/) - Automatically runs formatting checks before commits

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/Azure/terraform-azurerm-naming.git
cd terraform-azurerm-naming

# Install dependencies (installs terraform, terraform-docs, tfsec, tflint via Go)
make install

# Optional: Set up pre-commit hooks
pip install pre-commit
pre-commit install
```

## Project Structure

```
terraform-azurerm-naming/
├── main.go                          # Go generator - reads JSON, outputs Terraform
├── resourceDefinition.json          # Primary resource definitions (documented in Azure)
├── resourceDefinition_out_of_docs.json  # Resources not in official Azure docs
├── templates/
│   ├── main.tmpl                    # Template for main.tf generation
│   └── outputs.tmpl                 # Template for outputs.tf generation
├── main.tf                          # [GENERATED] - Do not edit manually
├── outputs.tf                       # [GENERATED] - Do not edit manually
├── variables.tf                     # Module input variables (manually maintained)
├── Makefile                         # Build automation for Linux/macOS
└── docs/
    ├── missing_resources.md         # Resources that need to be added
    └── not_defined.md               # Resources without naming documentation
```

### Source Files vs Generated Files

| File | Type | Edit? |
|------|------|-------|
| `resourceDefinition.json` | Source | Yes |
| `resourceDefinition_out_of_docs.json` | Source | Yes |
| `templates/*.tmpl` | Source | Yes |
| `main.go` | Source | Yes |
| `variables.tf` | Source | Yes |
| `main.tf` | **Generated** | No |
| `outputs.tf` | **Generated** | No |

## How Code Generation Works

The project uses a Go-based code generator that transforms JSON resource definitions into Terraform code:

```
┌─────────────────────────────────┐
│  resourceDefinition.json        │──┐
│  (documented resources)         │  │
└─────────────────────────────────┘  │
                                     ▼
┌─────────────────────────────────┐  │   ┌────────────┐   ┌─────────────┐
│ resourceDefinition_out_of_docs  │──┴──▶│  main.go   │──▶│  main.tf    │
│  (undocumented resources)       │      │ (generator)│   │  outputs.tf │
└─────────────────────────────────┘      └────────────┘   └─────────────┘
                                               ▲
                                               │
                                    ┌──────────┴──────────┐
                                    │ templates/main.tmpl │
                                    │ templates/outputs.tmpl│
                                    └─────────────────────┘
```

**Process:**
1. `main.go` reads both JSON definition files
2. Merges and sorts all resources alphabetically
3. Applies Go templates to generate Terraform locals and outputs
4. Writes `main.tf` and `outputs.tf`

## Adding a New Azure Resource

### Step 1: Find the Naming Rules

Look up the resource's naming rules in the [Azure naming rules documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules).

### Step 2: Choose the Right JSON File

- **`resourceDefinition.json`** - Use for resources documented in Microsoft's official naming rules
- **`resourceDefinition_out_of_docs.json`** - Use for resources not in official documentation

### Step 3: Add the Resource Definition

Add a new entry to the appropriate JSON file:

```json
{
  "name": "my_new_resource",
  "length": {
    "min": 1,
    "max": 80
  },
  "regex": "^[a-zA-Z0-9-]+$",
  "scope": "resourceGroup",
  "slug": "mnr",
  "dashes": true
}
```

#### Field Reference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Resource name matching Terraform provider (e.g., `storage_account` for `azurerm_storage_account`) |
| `length.min` | integer | Yes | Minimum character length allowed |
| `length.max` | integer | Yes | Maximum character length allowed |
| `regex` | string | Yes | Regex pattern for valid names (note: Terraform doesn't support all regex features) |
| `scope` | string | Yes | Uniqueness scope: `global`, `subscription`, `resourceGroup`, or `parent` |
| `slug` | string | Yes | Short abbreviation used in generated names (e.g., `st` for storage, `rg` for resource group) |
| `dashes` | boolean | Yes | Whether the resource name supports dashes/hyphens |

#### Scope Values

| Scope | Meaning |
|-------|---------|
| `global` | Name must be globally unique across all Azure (e.g., storage accounts) |
| `subscription` | Name must be unique within the subscription |
| `resourceGroup` | Name must be unique within the resource group |
| `parent` | Name must be unique within the parent resource |

### Step 4: Generate and Validate

```bash
# Regenerate main.tf and outputs.tf
make generate

# Format and validate
make format
make validate

# Or run all steps at once
make all
```

### Step 5: Verify Your Changes

Check that:
- Your resource appears in `main.tf` under the `locals.az` block
- Your resource has a corresponding output in `outputs.tf`
- `terraform validate` passes
- `terraform fmt -check` passes

## Running Locally

### Using Make (Linux/macOS)

```bash
# Full build: install deps, generate, format, validate
make all

# Individual targets
make install   # Install required tools
make generate  # Run Go generator
make format    # Run terraform fmt
make validate  # Run fmt check, validate, and tflint
make build     # install + generate
```

### Manual Commands

```bash
# Generate Terraform files
go run main.go

# Format Terraform files
terraform fmt

# Validate Terraform
terraform init
terraform validate
```

## Pull Request Guidelines

### Before Submitting

1. **Run the full validation suite:**
   ```bash
   make all
   ```

2. **Ensure generated files are committed:**
   - After running `make generate`, commit both `main.tf` and `outputs.tf`
   - These files should always reflect the current JSON definitions

3. **Format your code:**
   - Go code: `go fmt main.go`
   - Terraform: `terraform fmt`
   - JSON: Ensure proper formatting

4. **Test your changes:**
   - Run `terraform validate` to ensure the generated code is valid
   - Manually verify your resource output if possible

### PR Checklist

- [ ] I've read the [Code of Conduct](CODE_OF_CONDUCT.md)
- [ ] I've run `make all` (or equivalent) successfully
- [ ] Generated files (`main.tf`, `outputs.tf`) are included in my commit
- [ ] For new resources: I've added to the correct JSON file (`resourceDefinition.json` or `resourceDefinition_out_of_docs.json`)
- [ ] For new resources: I've verified the naming rules from [Azure documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
- [ ] My changes don't break existing functionality

### Commit Message Format

Use clear, descriptive commit messages:

```
feat: add support for azure_container_app resource
fix: correct regex pattern for storage_account
docs: update contributing guidelines
refactor: improve template generation logic
```

### What Happens After Submission

1. GitHub Actions runs `terraform fmt -check`, `terraform init`, and `terraform validate`
2. A CLA bot checks if you've signed the Contributor License Agreement
3. Maintainers review your changes
4. Once approved, your PR will be merged

## Getting Help

- **Questions about existing resources?** Check [docs/missing_resources.md](docs/missing_resources.md)
- **Found a bug?** [Open an issue](https://github.com/Azure/terraform-azurerm-naming/issues/new)
- **Need clarification?** Comment on relevant issues like [#177](https://github.com/Azure/terraform-azurerm-naming/issues/177)

## Code of Conduct

This project follows the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
