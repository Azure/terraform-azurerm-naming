
[CmdletBinding()]
param (
    [ValidateSet('install', 'generate', 'format', 'validate', 'build', 'all')]
    [string]$Task = 'all'
)

function install {
    $env:GO111MODULE = "on"
    if (-not (Get-Command "terraform" -CommandType Application -ea 0)) { & go get github.com/hashicorp/terraform@v0.12.26 }
    if (-not (Get-Command "terraform-docs" -CommandType Application -ea 0)) { & go get github.com/segmentio/terraform-docs@v0.9.1 }
    if (-not (Get-Command "tfsec" -CommandType Application -ea 0)) { & go get github.com/liamg/tfsec/cmd/tfsec@v0.21.0 }
    if (-not (Get-Command "tflint" -CommandType Application -ea 0)) { & go get github.com/terraform-linters/tflint@v0.16.2 }
}

function generate {
    & go run main.go
}

function format {
    & terraform fmt
}

function validate {
    & terraform fmt --check
    & terraform validate -no-color
    & tflint --no-color
}

function build {
    install
    generate
}

function all {
    build
    format
    validate
}

Invoke-Expression $Task