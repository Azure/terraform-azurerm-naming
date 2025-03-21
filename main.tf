terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }
  }
}

resource "random_string" "main" {
  length  = 60
  special = false
  upper   = false
  numeric = var.unique-include-numbers
}

resource "random_string" "first_letter" {
  length  = 1
  special = false
  upper   = false
  numeric = false
}



locals {
  // adding a first letter to guarantee that you always start with a letter
  random_safe_generation = join("", [random_string.first_letter.result, random_string.main.result])
  random                 = substr(coalesce(var.unique-seed, local.random_safe_generation), 0, var.unique-length)
  prefix                 = join("-", var.prefix)
  prefix_safe            = lower(join("", var.prefix))
  suffix                 = join("-", var.suffix)
  suffix_unique          = join("-", concat(var.suffix, [local.random]))
  suffix_safe            = lower(join("", var.suffix))
  suffix_unique_safe     = lower(join("", concat(var.suffix, [local.random])))
  suffix_padding         = (var.suffix-padding > local.max_suffix_padding) ? local.max_suffix_padding : var.suffix-padding
  max_suffix_padding     = 12

  suffix_abbrev          = join("", [for s in var.suffix : substr(s, 0, 1)])
  suffix_hash            = join("", [local.suffix_abbrev, substr(sha256(join("", compact([local.suffix_safe]))), 0, var.suffix-hash-length)])

  // Names based in the recomendations of
  // https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
  az = {
    analysis_services_server = {
      name        = substr(join("", compact([local.prefix_safe, "as", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "as", local.suffix_safe])), 0, (63 - var.unique-length)), local.random]), 0, 63)
      dashes      = false
      slug        = "as"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z][a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "as", local.suffix_safe])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "as", local.suffix_safe])), 0, (63 - local.suffix_padding - var.unique-length)), local.random]), 0, 63)
      short_name           = join("", ["as", substr(local.suffix_hash, 0, 63 - length("as"))])
      short_name_unique    = join("", ["as", substr(local.suffix_hash, 0, 63 - length("as") - var.unique-length), local.random])
    }
    api_management = {
      name        = substr(join("", compact([local.prefix_safe, "apim", local.suffix_safe])), 0, 50)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "apim", local.suffix_safe])), 0, (50 - var.unique-length)), local.random]), 0, 50)
      dashes      = false
      slug        = "apim"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "apim", local.suffix_safe])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "apim", local.suffix_safe])), 0, (50 - local.suffix_padding - var.unique-length)), local.random]), 0, 50)
      short_name           = join("", ["apim", substr(local.suffix_hash, 0, 50 - length("apim"))])
      short_name_unique    = join("", ["apim", substr(local.suffix_hash, 0, 50 - length("apim") - var.unique-length), local.random])
    }
    app_configuration = {
      name        = substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "appcg"
      min_length  = 5
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["appcg", substr(local.suffix_hash, 0, 50 - length("appcg") - 1)])
      short_name_unique    = join("-", ["appcg", substr(local.suffix_hash, 0, 50 - length("appcg") - var.unique-length - 2), local.random])
    }
    app_service = {
      name        = substr(join("-", compact([local.prefix, "app", local.suffix])), 0, 60)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "app", local.suffix])), 0, (60 - var.unique-length - 1)), local.random]), 0, 60)
      dashes      = true
      slug        = "app"
      min_length  = 2
      max_length  = 60
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "app", local.suffix])), 0, 60 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "app", local.suffix])), 0, (60 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 60)
      short_name           = join("-", ["app", substr(local.suffix_hash, 0, 60 - length("app") - 1)])
      short_name_unique    = join("-", ["app", substr(local.suffix_hash, 0, 60 - length("app") - var.unique-length - 2), local.random])
    }
    app_service_environment = {
      name        = substr(join("-", compact([local.prefix, "ase", local.suffix])), 0, 40)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ase", local.suffix])), 0, (40 - var.unique-length - 1)), local.random]), 0, 40)
      dashes      = true
      slug        = "ase"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ase", local.suffix])), 0, 40 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ase", local.suffix])), 0, (40 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 40)
      short_name           = join("-", ["ase", substr(local.suffix_hash, 0, 40 - length("ase") - 1)])
      short_name_unique    = join("-", ["ase", substr(local.suffix_hash, 0, 40 - length("ase") - var.unique-length - 2), local.random])
    }
    app_service_plan = {
      name        = substr(join("-", compact([local.prefix, "plan", local.suffix])), 0, 40)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "plan", local.suffix])), 0, (40 - var.unique-length - 1)), local.random]), 0, 40)
      dashes      = true
      slug        = "plan"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "plan", local.suffix])), 0, 40 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "plan", local.suffix])), 0, (40 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 40)
      short_name           = join("-", ["plan", substr(local.suffix_hash, 0, 40 - length("plan") - 1)])
      short_name_unique    = join("-", ["plan", substr(local.suffix_hash, 0, 40 - length("plan") - var.unique-length - 2), local.random])
    }
    application_gateway = {
      name        = substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "agw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["agw", substr(local.suffix_hash, 0, 80 - length("agw") - 1)])
      short_name_unique    = join("-", ["agw", substr(local.suffix_hash, 0, 80 - length("agw") - var.unique-length - 2), local.random])
    }
    application_insights = {
      name        = substr(join("-", compact([local.prefix, "appi", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "appi", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "appi"
      min_length  = 10
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^%\\&?/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "appi", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "appi", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["appi", substr(local.suffix_hash, 0, 260 - length("appi") - 1)])
      short_name_unique    = join("-", ["appi", substr(local.suffix_hash, 0, 260 - length("appi") - var.unique-length - 2), local.random])
    }
    application_security_group = {
      name        = substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "asg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["asg", substr(local.suffix_hash, 0, 80 - length("asg") - 1)])
      short_name_unique    = join("-", ["asg", substr(local.suffix_hash, 0, 80 - length("asg") - var.unique-length - 2), local.random])
    }
    automation_account = {
      name        = substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "aa"
      min_length  = 6
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["aa", substr(local.suffix_hash, 0, 50 - length("aa") - 1)])
      short_name_unique    = join("-", ["aa", substr(local.suffix_hash, 0, 50 - length("aa") - var.unique-length - 2), local.random])
    }
    automation_certificate = {
      name        = substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "aacert"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["aacert", substr(local.suffix_hash, 0, 128 - length("aacert") - 1)])
      short_name_unique    = join("-", ["aacert", substr(local.suffix_hash, 0, 128 - length("aacert") - var.unique-length - 2), local.random])
    }
    automation_credential = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["aacred", substr(local.suffix_hash, 0, 128 - length("aacred") - 1)])
      short_name_unique    = join("-", ["aacred", substr(local.suffix_hash, 0, 128 - length("aacred") - var.unique-length - 2), local.random])
    }
    automation_runbook = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["aacred", substr(local.suffix_hash, 0, 63 - length("aacred") - 1)])
      short_name_unique    = join("-", ["aacred", substr(local.suffix_hash, 0, 63 - length("aacred") - var.unique-length - 2), local.random])
    }
    automation_schedule = {
      name        = substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "aasched"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["aasched", substr(local.suffix_hash, 0, 128 - length("aasched") - 1)])
      short_name_unique    = join("-", ["aasched", substr(local.suffix_hash, 0, 128 - length("aasched") - var.unique-length - 2), local.random])
    }
    automation_variable = {
      name        = substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "aavar"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["aavar", substr(local.suffix_hash, 0, 128 - length("aavar") - 1)])
      short_name_unique    = join("-", ["aavar", substr(local.suffix_hash, 0, 128 - length("aavar") - var.unique-length - 2), local.random])
    }
    availability_set = {
      name        = substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "avail"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["avail", substr(local.suffix_hash, 0, 80 - length("avail") - 1)])
      short_name_unique    = join("-", ["avail", substr(local.suffix_hash, 0, 80 - length("avail") - var.unique-length - 2), local.random])
    }
    bastion_host = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["snap", substr(local.suffix_hash, 0, 80 - length("snap") - 1)])
      short_name_unique    = join("-", ["snap", substr(local.suffix_hash, 0, 80 - length("snap") - var.unique-length - 2), local.random])
    }
    batch_account = {
      name        = substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, (24 - var.unique-length)), local.random]), 0, 24)
      dashes      = false
      slug        = "ba"
      min_length  = 3
      max_length  = 24
      scope       = "region"
      regex       = "^[a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, (24 - local.suffix_padding - var.unique-length)), local.random]), 0, 24)
      short_name           = join("", ["ba", substr(local.suffix_hash, 0, 24 - length("ba"))])
      short_name_unique    = join("", ["ba", substr(local.suffix_hash, 0, 24 - length("ba") - var.unique-length), local.random])
    }
    batch_application = {
      name        = substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "baapp"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["baapp", substr(local.suffix_hash, 0, 64 - length("baapp") - 1)])
      short_name_unique    = join("-", ["baapp", substr(local.suffix_hash, 0, 64 - length("baapp") - var.unique-length - 2), local.random])
    }
    batch_certificate = {
      name        = substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, 45)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, (45 - var.unique-length - 1)), local.random]), 0, 45)
      dashes      = true
      slug        = "bacert"
      min_length  = 5
      max_length  = 45
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, 45 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, (45 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 45)
      short_name           = join("-", ["bacert", substr(local.suffix_hash, 0, 45 - length("bacert") - 1)])
      short_name_unique    = join("-", ["bacert", substr(local.suffix_hash, 0, 45 - length("bacert") - var.unique-length - 2), local.random])
    }
    batch_pool = {
      name        = substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, 24)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, (24 - var.unique-length - 1)), local.random]), 0, 24)
      dashes      = true
      slug        = "bapool"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, (24 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 24)
      short_name           = join("-", ["bapool", substr(local.suffix_hash, 0, 24 - length("bapool") - 1)])
      short_name_unique    = join("-", ["bapool", substr(local.suffix_hash, 0, 24 - length("bapool") - var.unique-length - 2), local.random])
    }
    bot_channel_directline = {
      name        = substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botline"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botline", substr(local.suffix_hash, 0, 64 - length("botline") - 1)])
      short_name_unique    = join("-", ["botline", substr(local.suffix_hash, 0, 64 - length("botline") - var.unique-length - 2), local.random])
    }
    bot_channel_email = {
      name        = substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botmail"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botmail", substr(local.suffix_hash, 0, 64 - length("botmail") - 1)])
      short_name_unique    = join("-", ["botmail", substr(local.suffix_hash, 0, 64 - length("botmail") - var.unique-length - 2), local.random])
    }
    bot_channel_ms_teams = {
      name        = substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botteams"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botteams", substr(local.suffix_hash, 0, 64 - length("botteams") - 1)])
      short_name_unique    = join("-", ["botteams", substr(local.suffix_hash, 0, 64 - length("botteams") - var.unique-length - 2), local.random])
    }
    bot_channel_slack = {
      name        = substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botslack"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botslack", substr(local.suffix_hash, 0, 64 - length("botslack") - 1)])
      short_name_unique    = join("-", ["botslack", substr(local.suffix_hash, 0, 64 - length("botslack") - var.unique-length - 2), local.random])
    }
    bot_channels_registration = {
      name        = substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botchan"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botchan", substr(local.suffix_hash, 0, 64 - length("botchan") - 1)])
      short_name_unique    = join("-", ["botchan", substr(local.suffix_hash, 0, 64 - length("botchan") - var.unique-length - 2), local.random])
    }
    bot_connection = {
      name        = substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "botcon"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["botcon", substr(local.suffix_hash, 0, 64 - length("botcon") - 1)])
      short_name_unique    = join("-", ["botcon", substr(local.suffix_hash, 0, 64 - length("botcon") - var.unique-length - 2), local.random])
    }
    bot_web_app = {
      name        = substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "bot"
      min_length  = 2
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["bot", substr(local.suffix_hash, 0, 64 - length("bot") - 1)])
      short_name_unique    = join("-", ["bot", substr(local.suffix_hash, 0, 64 - length("bot") - var.unique-length - 2), local.random])
    }
    cdn_endpoint = {
      name        = substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "cdn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["cdn", substr(local.suffix_hash, 0, 50 - length("cdn") - 1)])
      short_name_unique    = join("-", ["cdn", substr(local.suffix_hash, 0, 50 - length("cdn") - var.unique-length - 2), local.random])
    }
    cdn_profile = {
      name        = substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "cdnprof"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["cdnprof", substr(local.suffix_hash, 0, 260 - length("cdnprof") - 1)])
      short_name_unique    = join("-", ["cdnprof", substr(local.suffix_hash, 0, 260 - length("cdnprof") - var.unique-length - 2), local.random])
    }
    cognitive_account = {
      name        = substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "cog"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["cog", substr(local.suffix_hash, 0, 64 - length("cog") - 1)])
      short_name_unique    = join("-", ["cog", substr(local.suffix_hash, 0, 64 - length("cog") - var.unique-length - 2), local.random])
    }
    container_app = {
      name        = substr(join("-", compact([local.prefix, "ca", local.suffix])), 0, 32)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ca", local.suffix])), 0, (32 - var.unique-length - 1)), local.random]), 0, 32)
      dashes      = true
      slug        = "ca"
      min_length  = 1
      max_length  = 32
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ca", local.suffix])), 0, 32 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ca", local.suffix])), 0, (32 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 32)
      short_name           = join("-", ["ca", substr(local.suffix_hash, 0, 32 - length("ca") - 1)])
      short_name_unique    = join("-", ["ca", substr(local.suffix_hash, 0, 32 - length("ca") - var.unique-length - 2), local.random])
    }
    container_app_environment = {
      name        = substr(join("-", compact([local.prefix, "cae", local.suffix])), 0, 60)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cae", local.suffix])), 0, (60 - var.unique-length - 1)), local.random]), 0, 60)
      dashes      = true
      slug        = "cae"
      min_length  = 1
      max_length  = 60
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cae", local.suffix])), 0, 60 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cae", local.suffix])), 0, (60 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 60)
      short_name           = join("-", ["cae", substr(local.suffix_hash, 0, 60 - length("cae") - 1)])
      short_name_unique    = join("-", ["cae", substr(local.suffix_hash, 0, 60 - length("cae") - var.unique-length - 2), local.random])
    }
    container_group = {
      name        = substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "cg"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["cg", substr(local.suffix_hash, 0, 63 - length("cg") - 1)])
      short_name_unique    = join("-", ["cg", substr(local.suffix_hash, 0, 63 - length("cg") - var.unique-length - 2), local.random])
    }
    container_registry = {
      name        = substr(join("", compact([local.prefix_safe, "acr", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "acr", local.suffix_safe])), 0, (63 - var.unique-length)), local.random]), 0, 63)
      dashes      = false
      slug        = "acr"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "acr", local.suffix_safe])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "acr", local.suffix_safe])), 0, (63 - local.suffix_padding - var.unique-length)), local.random]), 0, 63)
      short_name           = join("", ["acr", substr(local.suffix_hash, 0, 63 - length("acr"))])
      short_name_unique    = join("", ["acr", substr(local.suffix_hash, 0, 63 - length("acr") - var.unique-length), local.random])
    }
    container_registry_webhook = {
      name        = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, 50)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, (50 - var.unique-length)), local.random]), 0, 50)
      dashes      = false
      slug        = "crwh"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, (50 - local.suffix_padding - var.unique-length)), local.random]), 0, 50)
      short_name           = join("", ["crwh", substr(local.suffix_hash, 0, 50 - length("crwh"))])
      short_name_unique    = join("", ["crwh", substr(local.suffix_hash, 0, 50 - length("crwh") - var.unique-length), local.random])
    }
    cosmosdb_account = {
      name        = substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "cosmos"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["cosmos", substr(local.suffix_hash, 0, 63 - length("cosmos") - 1)])
      short_name_unique    = join("-", ["cosmos", substr(local.suffix_hash, 0, 63 - length("cosmos") - var.unique-length - 2), local.random])
    }
    cosmosdb_cassandra_cluster = {
      name        = substr(join("-", compact([local.prefix, "mcc", local.suffix])), 0, 44)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mcc", local.suffix])), 0, (44 - var.unique-length - 1)), local.random]), 0, 44)
      dashes      = true
      slug        = "mcc"
      min_length  = 1
      max_length  = 44
      scope       = "parent"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mcc", local.suffix])), 0, 44 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mcc", local.suffix])), 0, (44 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 44)
      short_name           = join("-", ["mcc", substr(local.suffix_hash, 0, 44 - length("mcc") - 1)])
      short_name_unique    = join("-", ["mcc", substr(local.suffix_hash, 0, 44 - length("mcc") - var.unique-length - 2), local.random])
    }
    cosmosdb_cassandra_datacenter = {
      name        = substr(join("-", compact([local.prefix, "mcdc", local.suffix])), 0, 44)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mcdc", local.suffix])), 0, (44 - var.unique-length - 1)), local.random]), 0, 44)
      dashes      = true
      slug        = "mcdc"
      min_length  = 1
      max_length  = 44
      scope       = "parent"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mcdc", local.suffix])), 0, 44 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mcdc", local.suffix])), 0, (44 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 44)
      short_name           = join("-", ["mcdc", substr(local.suffix_hash, 0, 44 - length("mcdc") - 1)])
      short_name_unique    = join("-", ["mcdc", substr(local.suffix_hash, 0, 44 - length("mcdc") - var.unique-length - 2), local.random])
    }
    cosmosdb_postgres = {
      name        = substr(join("-", compact([local.prefix, "cospos", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "cospos", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "cospos"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "cospos", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "cospos", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["cospos", substr(local.suffix_hash, 0, 63 - length("cospos") - 1)])
      short_name_unique    = join("-", ["cospos", substr(local.suffix_hash, 0, 63 - length("cospos") - var.unique-length - 2), local.random])
    }
    custom_provider = {
      name        = substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "prov"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^&%?\\/]+[^&%.?\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["prov", substr(local.suffix_hash, 0, 64 - length("prov") - 1)])
      short_name_unique    = join("-", ["prov", substr(local.suffix_hash, 0, 64 - length("prov") - var.unique-length - 2), local.random])
    }
    dashboard = {
      name        = substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, 160)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, (160 - var.unique-length - 1)), local.random]), 0, 160)
      dashes      = true
      slug        = "dsb"
      min_length  = 3
      max_length  = 160
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, 160 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, (160 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 160)
      short_name           = join("-", ["dsb", substr(local.suffix_hash, 0, 160 - length("dsb") - 1)])
      short_name_unique    = join("-", ["dsb", substr(local.suffix_hash, 0, 160 - length("dsb") - var.unique-length - 2), local.random])
    }
    data_factory = {
      name        = substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "adf"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["adf", substr(local.suffix_hash, 0, 63 - length("adf") - 1)])
      short_name_unique    = join("-", ["adf", substr(local.suffix_hash, 0, 63 - length("adf") - var.unique-length - 2), local.random])
    }
    data_factory_dataset_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfmysql", substr(local.suffix_hash, 0, 260 - length("adfmysql") - 1)])
      short_name_unique    = join("-", ["adfmysql", substr(local.suffix_hash, 0, 260 - length("adfmysql") - var.unique-length - 2), local.random])
    }
    data_factory_dataset_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfpsql", substr(local.suffix_hash, 0, 260 - length("adfpsql") - 1)])
      short_name_unique    = join("-", ["adfpsql", substr(local.suffix_hash, 0, 260 - length("adfpsql") - var.unique-length - 2), local.random])
    }
    data_factory_dataset_sql_server_table = {
      name        = substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfmssql", substr(local.suffix_hash, 0, 260 - length("adfmssql") - 1)])
      short_name_unique    = join("-", ["adfmssql", substr(local.suffix_hash, 0, 260 - length("adfmssql") - var.unique-length - 2), local.random])
    }
    data_factory_integration_runtime_managed = {
      name        = substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "adfir"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["adfir", substr(local.suffix_hash, 0, 63 - length("adfir") - 1)])
      short_name_unique    = join("-", ["adfir", substr(local.suffix_hash, 0, 63 - length("adfir") - var.unique-length - 2), local.random])
    }
    data_factory_linked_service_data_lake_storage_gen2 = {
      name        = substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfsvst"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfsvst", substr(local.suffix_hash, 0, 260 - length("adfsvst") - 1)])
      short_name_unique    = join("-", ["adfsvst", substr(local.suffix_hash, 0, 260 - length("adfsvst") - var.unique-length - 2), local.random])
    }
    data_factory_linked_service_key_vault = {
      name        = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfsvkv"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfsvkv", substr(local.suffix_hash, 0, 260 - length("adfsvkv") - 1)])
      short_name_unique    = join("-", ["adfsvkv", substr(local.suffix_hash, 0, 260 - length("adfsvkv") - var.unique-length - 2), local.random])
    }
    data_factory_linked_service_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfsvmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfsvmysql", substr(local.suffix_hash, 0, 260 - length("adfsvmysql") - 1)])
      short_name_unique    = join("-", ["adfsvmysql", substr(local.suffix_hash, 0, 260 - length("adfsvmysql") - var.unique-length - 2), local.random])
    }
    data_factory_linked_service_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfsvpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfsvpsql", substr(local.suffix_hash, 0, 260 - length("adfsvpsql") - 1)])
      short_name_unique    = join("-", ["adfsvpsql", substr(local.suffix_hash, 0, 260 - length("adfsvpsql") - var.unique-length - 2), local.random])
    }
    data_factory_linked_service_sql_server = {
      name        = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfsvmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfsvmssql", substr(local.suffix_hash, 0, 260 - length("adfsvmssql") - 1)])
      short_name_unique    = join("-", ["adfsvmssql", substr(local.suffix_hash, 0, 260 - length("adfsvmssql") - var.unique-length - 2), local.random])
    }
    data_factory_pipeline = {
      name        = substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adfpl"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adfpl", substr(local.suffix_hash, 0, 260 - length("adfpl") - 1)])
      short_name_unique    = join("-", ["adfpl", substr(local.suffix_hash, 0, 260 - length("adfpl") - var.unique-length - 2), local.random])
    }
    data_factory_trigger_schedule = {
      name        = substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "adftg"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["adftg", substr(local.suffix_hash, 0, 260 - length("adftg") - 1)])
      short_name_unique    = join("-", ["adftg", substr(local.suffix_hash, 0, 260 - length("adftg") - var.unique-length - 2), local.random])
    }
    data_lake_analytics_account = {
      name        = substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, (24 - var.unique-length)), local.random]), 0, 24)
      dashes      = false
      slug        = "dla"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, (24 - local.suffix_padding - var.unique-length)), local.random]), 0, 24)
      short_name           = join("", ["dla", substr(local.suffix_hash, 0, 24 - length("dla"))])
      short_name_unique    = join("", ["dla", substr(local.suffix_hash, 0, 24 - length("dla") - var.unique-length), local.random])
    }
    data_lake_analytics_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "dlfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["dlfw", substr(local.suffix_hash, 0, 50 - length("dlfw") - 1)])
      short_name_unique    = join("-", ["dlfw", substr(local.suffix_hash, 0, 50 - length("dlfw") - var.unique-length - 2), local.random])
    }
    data_lake_store = {
      name        = substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, (24 - var.unique-length)), local.random]), 0, 24)
      dashes      = false
      slug        = "dls"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "^[a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, (24 - local.suffix_padding - var.unique-length)), local.random]), 0, 24)
      short_name           = join("", ["dls", substr(local.suffix_hash, 0, 24 - length("dls"))])
      short_name_unique    = join("", ["dls", substr(local.suffix_hash, 0, 24 - length("dls") - var.unique-length), local.random])
    }
    data_lake_store_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "dlsfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["dlsfw", substr(local.suffix_hash, 0, 50 - length("dlsfw") - 1)])
      short_name_unique    = join("-", ["dlsfw", substr(local.suffix_hash, 0, 50 - length("dlsfw") - var.unique-length - 2), local.random])
    }
    database_migration_project = {
      name        = substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, 57)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, (57 - var.unique-length - 1)), local.random]), 0, 57)
      dashes      = true
      slug        = "migr"
      min_length  = 2
      max_length  = 57
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, 57 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, (57 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 57)
      short_name           = join("-", ["migr", substr(local.suffix_hash, 0, 57 - length("migr") - 1)])
      short_name_unique    = join("-", ["migr", substr(local.suffix_hash, 0, 57 - length("migr") - var.unique-length - 2), local.random])
    }
    database_migration_service = {
      name        = substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, 62)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, (62 - var.unique-length - 1)), local.random]), 0, 62)
      dashes      = true
      slug        = "dms"
      min_length  = 2
      max_length  = 62
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, 62 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, (62 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 62)
      short_name           = join("-", ["dms", substr(local.suffix_hash, 0, 62 - length("dms") - 1)])
      short_name_unique    = join("-", ["dms", substr(local.suffix_hash, 0, 62 - length("dms") - var.unique-length - 2), local.random])
    }
    databricks_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbc", local.suffix])), 0, 30)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dbc", local.suffix])), 0, (30 - var.unique-length - 1)), local.random]), 0, 30)
      dashes      = true
      slug        = "dbc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dbc", local.suffix])), 0, 30 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dbc", local.suffix])), 0, (30 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 30)
      short_name           = join("-", ["dbc", substr(local.suffix_hash, 0, 30 - length("dbc") - 1)])
      short_name_unique    = join("-", ["dbc", substr(local.suffix_hash, 0, 30 - length("dbc") - var.unique-length - 2), local.random])
    }
    databricks_high_concurrency_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbhcc", local.suffix])), 0, 30)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dbhcc", local.suffix])), 0, (30 - var.unique-length - 1)), local.random]), 0, 30)
      dashes      = true
      slug        = "dbhcc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dbhcc", local.suffix])), 0, 30 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dbhcc", local.suffix])), 0, (30 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 30)
      short_name           = join("-", ["dbhcc", substr(local.suffix_hash, 0, 30 - length("dbhcc") - 1)])
      short_name_unique    = join("-", ["dbhcc", substr(local.suffix_hash, 0, 30 - length("dbhcc") - var.unique-length - 2), local.random])
    }
    databricks_standard_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbsc", local.suffix])), 0, 30)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dbsc", local.suffix])), 0, (30 - var.unique-length - 1)), local.random]), 0, 30)
      dashes      = true
      slug        = "dbsc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dbsc", local.suffix])), 0, 30 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dbsc", local.suffix])), 0, (30 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 30)
      short_name           = join("-", ["dbsc", substr(local.suffix_hash, 0, 30 - length("dbsc") - 1)])
      short_name_unique    = join("-", ["dbsc", substr(local.suffix_hash, 0, 30 - length("dbsc") - var.unique-length - 2), local.random])
    }
    databricks_workspace = {
      name        = substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, 30)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, (30 - var.unique-length - 1)), local.random]), 0, 30)
      dashes      = true
      slug        = "dbw"
      min_length  = 3
      max_length  = 30
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, 30 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, (30 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 30)
      short_name           = join("-", ["dbw", substr(local.suffix_hash, 0, 30 - length("dbw") - 1)])
      short_name_unique    = join("-", ["dbw", substr(local.suffix_hash, 0, 30 - length("dbw") - var.unique-length - 2), local.random])
    }
    dev_test_lab = {
      name        = substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "lab"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["lab", substr(local.suffix_hash, 0, 50 - length("lab") - 1)])
      short_name_unique    = join("-", ["lab", substr(local.suffix_hash, 0, 50 - length("lab") - var.unique-length - 2), local.random])
    }
    dev_test_linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["labvm", substr(local.suffix_hash, 0, 64 - length("labvm") - 1)])
      short_name_unique    = join("-", ["labvm", substr(local.suffix_hash, 0, 64 - length("labvm") - var.unique-length - 2), local.random])
    }
    dev_test_windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 15)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, (15 - var.unique-length - 1)), local.random]), 0, 15)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 15
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 15 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, (15 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 15)
      short_name           = join("-", ["labvm", substr(local.suffix_hash, 0, 15 - length("labvm") - 1)])
      short_name_unique    = join("-", ["labvm", substr(local.suffix_hash, 0, 15 - length("labvm") - var.unique-length - 2), local.random])
    }
    disk_encryption_set = {
      name        = substr(join("-", compact([local.prefix, "des", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "des", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "des"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "des", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "des", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["des", substr(local.suffix_hash, 0, 80 - length("des") - 1)])
      short_name_unique    = join("-", ["des", substr(local.suffix_hash, 0, 80 - length("des") - var.unique-length - 2), local.random])
    }
    dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_caa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_ns_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 80 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    dns_zone = {
      name        = substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "dns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["dns", substr(local.suffix_hash, 0, 63 - length("dns") - 1)])
      short_name_unique    = join("-", ["dns", substr(local.suffix_hash, 0, 63 - length("dns") - var.unique-length - 2), local.random])
    }
    eventgrid_domain = {
      name        = substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "egd"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["egd", substr(local.suffix_hash, 0, 50 - length("egd") - 1)])
      short_name_unique    = join("-", ["egd", substr(local.suffix_hash, 0, 50 - length("egd") - var.unique-length - 2), local.random])
    }
    eventgrid_domain_topic = {
      name        = substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "egdt"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["egdt", substr(local.suffix_hash, 0, 50 - length("egdt") - 1)])
      short_name_unique    = join("-", ["egdt", substr(local.suffix_hash, 0, 50 - length("egdt") - var.unique-length - 2), local.random])
    }
    eventgrid_event_subscription = {
      name        = substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "egs"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["egs", substr(local.suffix_hash, 0, 64 - length("egs") - 1)])
      short_name_unique    = join("-", ["egs", substr(local.suffix_hash, 0, 64 - length("egs") - var.unique-length - 2), local.random])
    }
    eventgrid_topic = {
      name        = substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "egt"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["egt", substr(local.suffix_hash, 0, 50 - length("egt") - 1)])
      short_name_unique    = join("-", ["egt", substr(local.suffix_hash, 0, 50 - length("egt") - var.unique-length - 2), local.random])
    }
    eventhub = {
      name        = substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "evh"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["evh", substr(local.suffix_hash, 0, 50 - length("evh") - 1)])
      short_name_unique    = join("-", ["evh", substr(local.suffix_hash, 0, 50 - length("evh") - var.unique-length - 2), local.random])
    }
    eventhub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "ehar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["ehar", substr(local.suffix_hash, 0, 50 - length("ehar") - 1)])
      short_name_unique    = join("-", ["ehar", substr(local.suffix_hash, 0, 50 - length("ehar") - var.unique-length - 2), local.random])
    }
    eventhub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "ehcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["ehcg", substr(local.suffix_hash, 0, 50 - length("ehcg") - 1)])
      short_name_unique    = join("-", ["ehcg", substr(local.suffix_hash, 0, 50 - length("ehcg") - var.unique-length - 2), local.random])
    }
    eventhub_namespace = {
      name        = substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "ehn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["ehn", substr(local.suffix_hash, 0, 50 - length("ehn") - 1)])
      short_name_unique    = join("-", ["ehn", substr(local.suffix_hash, 0, 50 - length("ehn") - var.unique-length - 2), local.random])
    }
    eventhub_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "ehnar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["ehnar", substr(local.suffix_hash, 0, 50 - length("ehnar") - 1)])
      short_name_unique    = join("-", ["ehnar", substr(local.suffix_hash, 0, 50 - length("ehnar") - var.unique-length - 2), local.random])
    }
    eventhub_namespace_disaster_recovery_config = {
      name        = substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "ehdr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["ehdr", substr(local.suffix_hash, 0, 50 - length("ehdr") - 1)])
      short_name_unique    = join("-", ["ehdr", substr(local.suffix_hash, 0, 50 - length("ehdr") - var.unique-length - 2), local.random])
    }
    express_route_circuit = {
      name        = substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "erc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["erc", substr(local.suffix_hash, 0, 80 - length("erc") - 1)])
      short_name_unique    = join("-", ["erc", substr(local.suffix_hash, 0, 80 - length("erc") - var.unique-length - 2), local.random])
    }
    express_route_gateway = {
      name        = substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "ergw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["ergw", substr(local.suffix_hash, 0, 80 - length("ergw") - 1)])
      short_name_unique    = join("-", ["ergw", substr(local.suffix_hash, 0, 80 - length("ergw") - var.unique-length - 2), local.random])
    }
    firewall = {
      name        = substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fw", substr(local.suffix_hash, 0, 80 - length("fw") - 1)])
      short_name_unique    = join("-", ["fw", substr(local.suffix_hash, 0, 80 - length("fw") - var.unique-length - 2), local.random])
    }
    firewall_application_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fwapp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fwapp", substr(local.suffix_hash, 0, 80 - length("fwapp") - 1)])
      short_name_unique    = join("-", ["fwapp", substr(local.suffix_hash, 0, 80 - length("fwapp") - var.unique-length - 2), local.random])
    }
    firewall_ip_configuration = {
      name        = substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fwipconf"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fwipconf", substr(local.suffix_hash, 0, 80 - length("fwipconf") - 1)])
      short_name_unique    = join("-", ["fwipconf", substr(local.suffix_hash, 0, 80 - length("fwipconf") - var.unique-length - 2), local.random])
    }
    firewall_nat_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fwnatrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fwnatrc", substr(local.suffix_hash, 0, 80 - length("fwnatrc") - 1)])
      short_name_unique    = join("-", ["fwnatrc", substr(local.suffix_hash, 0, 80 - length("fwnatrc") - var.unique-length - 2), local.random])
    }
    firewall_network_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fwnetrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fwnetrc", substr(local.suffix_hash, 0, 80 - length("fwnetrc") - 1)])
      short_name_unique    = join("-", ["fwnetrc", substr(local.suffix_hash, 0, 80 - length("fwnetrc") - var.unique-length - 2), local.random])
    }
    firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "afwp", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "afwp", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "afwp"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "afwp", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "afwp", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["afwp", substr(local.suffix_hash, 0, 80 - length("afwp") - 1)])
      short_name_unique    = join("-", ["afwp", substr(local.suffix_hash, 0, 80 - length("afwp") - var.unique-length - 2), local.random])
    }
    firewall_policy_rule_collection_group = {
      name        = substr(join("-", compact([local.prefix, "fwprcg", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fwprcg", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fwprcg"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fwprcg", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fwprcg", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fwprcg", substr(local.suffix_hash, 0, 80 - length("fwprcg") - 1)])
      short_name_unique    = join("-", ["fwprcg", substr(local.suffix_hash, 0, 80 - length("fwprcg") - var.unique-length - 2), local.random])
    }
    frontdoor = {
      name        = substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "fd"
      min_length  = 5
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["fd", substr(local.suffix_hash, 0, 64 - length("fd") - 1)])
      short_name_unique    = join("-", ["fd", substr(local.suffix_hash, 0, 64 - length("fd") - var.unique-length - 2), local.random])
    }
    frontdoor_firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "fdfw"
      min_length  = 1
      max_length  = 80
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["fdfw", substr(local.suffix_hash, 0, 80 - length("fdfw") - 1)])
      short_name_unique    = join("-", ["fdfw", substr(local.suffix_hash, 0, 80 - length("fdfw") - var.unique-length - 2), local.random])
    }
    function_app = {
      name        = substr(join("-", compact([local.prefix, "func", local.suffix])), 0, 60)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "func", local.suffix])), 0, (60 - var.unique-length - 1)), local.random]), 0, 60)
      dashes      = true
      slug        = "func"
      min_length  = 2
      max_length  = 60
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "func", local.suffix])), 0, 60 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "func", local.suffix])), 0, (60 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 60)
      short_name           = join("-", ["func", substr(local.suffix_hash, 0, 60 - length("func") - 1)])
      short_name_unique    = join("-", ["func", substr(local.suffix_hash, 0, 60 - length("func") - var.unique-length - 2), local.random])
    }
    hdinsight_hadoop_cluster = {
      name        = substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "hadoop"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["hadoop", substr(local.suffix_hash, 0, 59 - length("hadoop") - 1)])
      short_name_unique    = join("-", ["hadoop", substr(local.suffix_hash, 0, 59 - length("hadoop") - var.unique-length - 2), local.random])
    }
    hdinsight_hbase_cluster = {
      name        = substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "hbase"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["hbase", substr(local.suffix_hash, 0, 59 - length("hbase") - 1)])
      short_name_unique    = join("-", ["hbase", substr(local.suffix_hash, 0, 59 - length("hbase") - var.unique-length - 2), local.random])
    }
    hdinsight_interactive_query_cluster = {
      name        = substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "iqr"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["iqr", substr(local.suffix_hash, 0, 59 - length("iqr") - 1)])
      short_name_unique    = join("-", ["iqr", substr(local.suffix_hash, 0, 59 - length("iqr") - var.unique-length - 2), local.random])
    }
    hdinsight_kafka_cluster = {
      name        = substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "kafka"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["kafka", substr(local.suffix_hash, 0, 59 - length("kafka") - 1)])
      short_name_unique    = join("-", ["kafka", substr(local.suffix_hash, 0, 59 - length("kafka") - var.unique-length - 2), local.random])
    }
    hdinsight_ml_services_cluster = {
      name        = substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "mls"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["mls", substr(local.suffix_hash, 0, 59 - length("mls") - 1)])
      short_name_unique    = join("-", ["mls", substr(local.suffix_hash, 0, 59 - length("mls") - var.unique-length - 2), local.random])
    }
    hdinsight_rserver_cluster = {
      name        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "rsv"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["rsv", substr(local.suffix_hash, 0, 59 - length("rsv") - 1)])
      short_name_unique    = join("-", ["rsv", substr(local.suffix_hash, 0, 59 - length("rsv") - var.unique-length - 2), local.random])
    }
    hdinsight_spark_cluster = {
      name        = substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "spark"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["spark", substr(local.suffix_hash, 0, 59 - length("spark") - 1)])
      short_name_unique    = join("-", ["spark", substr(local.suffix_hash, 0, 59 - length("spark") - var.unique-length - 2), local.random])
    }
    hdinsight_storm_cluster = {
      name        = substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, 59)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, (59 - var.unique-length - 1)), local.random]), 0, 59)
      dashes      = true
      slug        = "storm"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, 59 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, (59 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 59)
      short_name           = join("-", ["storm", substr(local.suffix_hash, 0, 59 - length("storm") - 1)])
      short_name_unique    = join("-", ["storm", substr(local.suffix_hash, 0, 59 - length("storm") - var.unique-length - 2), local.random])
    }
    image = {
      name        = substr(join("-", compact([local.prefix, "img", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "img", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "img"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "img", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "img", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["img", substr(local.suffix_hash, 0, 80 - length("img") - 1)])
      short_name_unique    = join("-", ["img", substr(local.suffix_hash, 0, 80 - length("img") - var.unique-length - 2), local.random])
    }
    iotcentral_application = {
      name        = substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "iotapp"
      min_length  = 2
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["iotapp", substr(local.suffix_hash, 0, 63 - length("iotapp") - 1)])
      short_name_unique    = join("-", ["iotapp", substr(local.suffix_hash, 0, 63 - length("iotapp") - var.unique-length - 2), local.random])
    }
    iothub = {
      name        = substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "iot"
      min_length  = 3
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["iot", substr(local.suffix_hash, 0, 50 - length("iot") - 1)])
      short_name_unique    = join("-", ["iot", substr(local.suffix_hash, 0, 50 - length("iot") - var.unique-length - 2), local.random])
    }
    iothub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "iotcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-._]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["iotcg", substr(local.suffix_hash, 0, 50 - length("iotcg") - 1)])
      short_name_unique    = join("-", ["iotcg", substr(local.suffix_hash, 0, 50 - length("iotcg") - var.unique-length - 2), local.random])
    }
    iothub_dps = {
      name        = substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "dps"
      min_length  = 3
      max_length  = 64
      scope       = "resoureceGroup"
      regex       = "^[a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["dps", substr(local.suffix_hash, 0, 64 - length("dps") - 1)])
      short_name_unique    = join("-", ["dps", substr(local.suffix_hash, 0, 64 - length("dps") - var.unique-length - 2), local.random])
    }
    iothub_dps_certificate = {
      name        = substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "dpscert"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-._]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["dpscert", substr(local.suffix_hash, 0, 64 - length("dpscert") - 1)])
      short_name_unique    = join("-", ["dpscert", substr(local.suffix_hash, 0, 64 - length("dpscert") - var.unique-length - 2), local.random])
    }
    key_vault = {
      name        = substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, 24)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, (24 - var.unique-length - 1)), local.random]), 0, 24)
      dashes      = true
      slug        = "kv"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, (24 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 24)
      short_name           = join("-", ["kv", substr(local.suffix_hash, 0, 24 - length("kv") - 1)])
      short_name_unique    = join("-", ["kv", substr(local.suffix_hash, 0, 24 - length("kv") - var.unique-length - 2), local.random])
    }
    key_vault_certificate = {
      name        = substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, 127)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, (127 - var.unique-length - 1)), local.random]), 0, 127)
      dashes      = true
      slug        = "kvc"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, 127 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, (127 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 127)
      short_name           = join("-", ["kvc", substr(local.suffix_hash, 0, 127 - length("kvc") - 1)])
      short_name_unique    = join("-", ["kvc", substr(local.suffix_hash, 0, 127 - length("kvc") - var.unique-length - 2), local.random])
    }
    key_vault_key = {
      name        = substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, 127)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, (127 - var.unique-length - 1)), local.random]), 0, 127)
      dashes      = true
      slug        = "kvk"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, 127 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, (127 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 127)
      short_name           = join("-", ["kvk", substr(local.suffix_hash, 0, 127 - length("kvk") - 1)])
      short_name_unique    = join("-", ["kvk", substr(local.suffix_hash, 0, 127 - length("kvk") - var.unique-length - 2), local.random])
    }
    key_vault_secret = {
      name        = substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, 127)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, (127 - var.unique-length - 1)), local.random]), 0, 127)
      dashes      = true
      slug        = "kvs"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, 127 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, (127 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 127)
      short_name           = join("-", ["kvs", substr(local.suffix_hash, 0, 127 - length("kvs") - 1)])
      short_name_unique    = join("-", ["kvs", substr(local.suffix_hash, 0, 127 - length("kvs") - var.unique-length - 2), local.random])
    }
    kubernetes_cluster = {
      name        = substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "aks"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["aks", substr(local.suffix_hash, 0, 63 - length("aks") - 1)])
      short_name_unique    = join("-", ["aks", substr(local.suffix_hash, 0, 63 - length("aks") - var.unique-length - 2), local.random])
    }
    kusto_cluster = {
      name        = substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, 22)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, (22 - var.unique-length)), local.random]), 0, 22)
      dashes      = false
      slug        = "kc"
      min_length  = 4
      max_length  = 22
      scope       = "global"
      regex       = "^[a-z][a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, 22 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, (22 - local.suffix_padding - var.unique-length)), local.random]), 0, 22)
      short_name           = join("", ["kc", substr(local.suffix_hash, 0, 22 - length("kc"))])
      short_name_unique    = join("", ["kc", substr(local.suffix_hash, 0, 22 - length("kc") - var.unique-length), local.random])
    }
    kusto_database = {
      name        = substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "kdb"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9- .]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["kdb", substr(local.suffix_hash, 0, 260 - length("kdb") - 1)])
      short_name_unique    = join("-", ["kdb", substr(local.suffix_hash, 0, 260 - length("kdb") - var.unique-length - 2), local.random])
    }
    kusto_eventhub_data_connection = {
      name        = substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, 40)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, (40 - var.unique-length - 1)), local.random]), 0, 40)
      dashes      = true
      slug        = "kehc"
      min_length  = 1
      max_length  = 40
      scope       = "parent"
      regex       = "^[a-zA-Z0-9- .]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, 40 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, (40 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 40)
      short_name           = join("-", ["kehc", substr(local.suffix_hash, 0, 40 - length("kehc") - 1)])
      short_name_unique    = join("-", ["kehc", substr(local.suffix_hash, 0, 40 - length("kehc") - var.unique-length - 2), local.random])
    }
    lb = {
      name        = substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "lb"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["lb", substr(local.suffix_hash, 0, 80 - length("lb") - 1)])
      short_name_unique    = join("-", ["lb", substr(local.suffix_hash, 0, 80 - length("lb") - var.unique-length - 2), local.random])
    }
    lb_nat_rule = {
      name        = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "lbnatrl"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["lbnatrl", substr(local.suffix_hash, 0, 80 - length("lbnatrl") - 1)])
      short_name_unique    = join("-", ["lbnatrl", substr(local.suffix_hash, 0, 80 - length("lbnatrl") - var.unique-length - 2), local.random])
    }
    linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["vm", substr(local.suffix_hash, 0, 64 - length("vm") - 1)])
      short_name_unique    = join("-", ["vm", substr(local.suffix_hash, 0, 64 - length("vm") - var.unique-length - 2), local.random])
    }
    linux_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["vmss", substr(local.suffix_hash, 0, 64 - length("vmss") - 1)])
      short_name_unique    = join("-", ["vmss", substr(local.suffix_hash, 0, 64 - length("vmss") - var.unique-length - 2), local.random])
    }
    load_test = {
      name        = substr(join("-", compact([local.prefix, "lt", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "lt", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "lt"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9|]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "lt", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "lt", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["lt", substr(local.suffix_hash, 0, 64 - length("lt") - 1)])
      short_name_unique    = join("-", ["lt", substr(local.suffix_hash, 0, 64 - length("lt") - var.unique-length - 2), local.random])
    }
    local_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "lgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["lgw", substr(local.suffix_hash, 0, 80 - length("lgw") - 1)])
      short_name_unique    = join("-", ["lgw", substr(local.suffix_hash, 0, 80 - length("lgw") - var.unique-length - 2), local.random])
    }
    log_analytics_workspace = {
      name        = substr(join("-", compact([local.prefix, "log", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "log", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "log"
      min_length  = 4
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "log", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "log", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["log", substr(local.suffix_hash, 0, 63 - length("log") - 1)])
      short_name_unique    = join("-", ["log", substr(local.suffix_hash, 0, 63 - length("log") - var.unique-length - 2), local.random])
    }
    logic_app_workflow = {
      name        = substr(join("-", compact([local.prefix, "logic", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "logic", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "logic"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "logic", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "logic", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["logic", substr(local.suffix_hash, 0, 80 - length("logic") - 1)])
      short_name_unique    = join("-", ["logic", substr(local.suffix_hash, 0, 80 - length("logic") - var.unique-length - 2), local.random])
    }
    machine_learning_workspace = {
      name        = substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "mlw"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["mlw", substr(local.suffix_hash, 0, 260 - length("mlw") - 1)])
      short_name_unique    = join("-", ["mlw", substr(local.suffix_hash, 0, 260 - length("mlw") - var.unique-length - 2), local.random])
    }
    managed_disk = {
      name        = substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "dsk"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["dsk", substr(local.suffix_hash, 0, 80 - length("dsk") - 1)])
      short_name_unique    = join("-", ["dsk", substr(local.suffix_hash, 0, 80 - length("dsk") - var.unique-length - 2), local.random])
    }
    maps_account = {
      name        = substr(join("-", compact([local.prefix, "map", local.suffix])), 0, 98)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "map", local.suffix])), 0, (98 - var.unique-length - 1)), local.random]), 0, 98)
      dashes      = true
      slug        = "map"
      min_length  = 1
      max_length  = 98
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "map", local.suffix])), 0, 98 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "map", local.suffix])), 0, (98 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 98)
      short_name           = join("-", ["map", substr(local.suffix_hash, 0, 98 - length("map") - 1)])
      short_name_unique    = join("-", ["map", substr(local.suffix_hash, 0, 98 - length("map") - var.unique-length - 2), local.random])
    }
    mariadb_database = {
      name        = substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "mariadb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["mariadb", substr(local.suffix_hash, 0, 63 - length("mariadb") - 1)])
      short_name_unique    = join("-", ["mariadb", substr(local.suffix_hash, 0, 63 - length("mariadb") - var.unique-length - 2), local.random])
    }
    mariadb_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "mariafw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["mariafw", substr(local.suffix_hash, 0, 128 - length("mariafw") - 1)])
      short_name_unique    = join("-", ["mariafw", substr(local.suffix_hash, 0, 128 - length("mariafw") - var.unique-length - 2), local.random])
    }
    mariadb_server = {
      name        = substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "maria"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["maria", substr(local.suffix_hash, 0, 63 - length("maria") - 1)])
      short_name_unique    = join("-", ["maria", substr(local.suffix_hash, 0, 63 - length("maria") - var.unique-length - 2), local.random])
    }
    mariadb_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "mariavn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["mariavn", substr(local.suffix_hash, 0, 128 - length("mariavn") - 1)])
      short_name_unique    = join("-", ["mariavn", substr(local.suffix_hash, 0, 128 - length("mariavn") - var.unique-length - 2), local.random])
    }
    monitor_action_group = {
      name        = substr(join("-", compact([local.prefix, "mag", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mag", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "mag"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^%&?\\+\\/]+[^^%&?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mag", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mag", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["mag", substr(local.suffix_hash, 0, 260 - length("mag") - 1)])
      short_name_unique    = join("-", ["mag", substr(local.suffix_hash, 0, 260 - length("mag") - var.unique-length - 2), local.random])
    }
    monitor_autoscale_setting = {
      name        = substr(join("-", compact([local.prefix, "mas", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mas", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "mas"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^<>%&#.,?\\+\\/]+[^<>%&#.,?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mas", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mas", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["mas", substr(local.suffix_hash, 0, 260 - length("mas") - 1)])
      short_name_unique    = join("-", ["mas", substr(local.suffix_hash, 0, 260 - length("mas") - var.unique-length - 2), local.random])
    }
    monitor_diagnostic_setting = {
      name        = substr(join("-", compact([local.prefix, "mds", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mds", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "mds"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^*<>%:&?\\+\\/]+[^*<>%:&?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mds", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mds", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["mds", substr(local.suffix_hash, 0, 260 - length("mds") - 1)])
      short_name_unique    = join("-", ["mds", substr(local.suffix_hash, 0, 260 - length("mds") - var.unique-length - 2), local.random])
    }
    monitor_scheduled_query_rules_alert = {
      name        = substr(join("-", compact([local.prefix, "msqa", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "msqa", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "msqa"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^*<>%:{}&#.,?\\+\\/]+[^*<>%:{}&#.,?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "msqa", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "msqa", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["msqa", substr(local.suffix_hash, 0, 260 - length("msqa") - 1)])
      short_name_unique    = join("-", ["msqa", substr(local.suffix_hash, 0, 260 - length("msqa") - var.unique-length - 2), local.random])
    }
    mssql_database = {
      name        = substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "sqldb"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["sqldb", substr(local.suffix_hash, 0, 128 - length("sqldb") - 1)])
      short_name_unique    = join("-", ["sqldb", substr(local.suffix_hash, 0, 128 - length("sqldb") - var.unique-length - 2), local.random])
    }
    mssql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["sqlep", substr(local.suffix_hash, 0, 128 - length("sqlep") - 1)])
      short_name_unique    = join("-", ["sqlep", substr(local.suffix_hash, 0, 128 - length("sqlep") - var.unique-length - 2), local.random])
    }
    mssql_managed_instance = {
      name        = substr(join("-", compact([local.prefix, "sqlmi", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqlmi", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sqlmi"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqlmi", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqlmi", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sqlmi", substr(local.suffix_hash, 0, 63 - length("sqlmi") - 1)])
      short_name_unique    = join("-", ["sqlmi", substr(local.suffix_hash, 0, 63 - length("sqlmi") - var.unique-length - 2), local.random])
    }
    mssql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sql", substr(local.suffix_hash, 0, 63 - length("sql") - 1)])
      short_name_unique    = join("-", ["sql", substr(local.suffix_hash, 0, 63 - length("sql") - var.unique-length - 2), local.random])
    }
    mysql_database = {
      name        = substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "mysqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["mysqldb", substr(local.suffix_hash, 0, 63 - length("mysqldb") - 1)])
      short_name_unique    = join("-", ["mysqldb", substr(local.suffix_hash, 0, 63 - length("mysqldb") - var.unique-length - 2), local.random])
    }
    mysql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "mysqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["mysqlfw", substr(local.suffix_hash, 0, 128 - length("mysqlfw") - 1)])
      short_name_unique    = join("-", ["mysqlfw", substr(local.suffix_hash, 0, 128 - length("mysqlfw") - var.unique-length - 2), local.random])
    }
    mysql_server = {
      name        = substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "mysql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["mysql", substr(local.suffix_hash, 0, 63 - length("mysql") - 1)])
      short_name_unique    = join("-", ["mysql", substr(local.suffix_hash, 0, 63 - length("mysql") - var.unique-length - 2), local.random])
    }
    mysql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "mysqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["mysqlvn", substr(local.suffix_hash, 0, 128 - length("mysqlvn") - 1)])
      short_name_unique    = join("-", ["mysqlvn", substr(local.suffix_hash, 0, 128 - length("mysqlvn") - var.unique-length - 2), local.random])
    }
    nat_gateway = {
      name        = substr(join("-", compact([local.prefix, "ng", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ng", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "ng"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ng", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ng", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["ng", substr(local.suffix_hash, 0, 80 - length("ng") - 1)])
      short_name_unique    = join("-", ["ng", substr(local.suffix_hash, 0, 80 - length("ng") - var.unique-length - 2), local.random])
    }
    network_ddos_protection_plan = {
      name        = substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "ddospp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["ddospp", substr(local.suffix_hash, 0, 80 - length("ddospp") - 1)])
      short_name_unique    = join("-", ["ddospp", substr(local.suffix_hash, 0, 80 - length("ddospp") - var.unique-length - 2), local.random])
    }
    network_interface = {
      name        = substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "nic"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["nic", substr(local.suffix_hash, 0, 80 - length("nic") - 1)])
      short_name_unique    = join("-", ["nic", substr(local.suffix_hash, 0, 80 - length("nic") - var.unique-length - 2), local.random])
    }
    network_security_group = {
      name        = substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "nsg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["nsg", substr(local.suffix_hash, 0, 80 - length("nsg") - 1)])
      short_name_unique    = join("-", ["nsg", substr(local.suffix_hash, 0, 80 - length("nsg") - var.unique-length - 2), local.random])
    }
    network_security_group_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["nsgr", substr(local.suffix_hash, 0, 80 - length("nsgr") - 1)])
      short_name_unique    = join("-", ["nsgr", substr(local.suffix_hash, 0, 80 - length("nsgr") - var.unique-length - 2), local.random])
    }
    network_security_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["nsgr", substr(local.suffix_hash, 0, 80 - length("nsgr") - 1)])
      short_name_unique    = join("-", ["nsgr", substr(local.suffix_hash, 0, 80 - length("nsgr") - var.unique-length - 2), local.random])
    }
    network_watcher = {
      name        = substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "nw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["nw", substr(local.suffix_hash, 0, 80 - length("nw") - 1)])
      short_name_unique    = join("-", ["nw", substr(local.suffix_hash, 0, 80 - length("nw") - var.unique-length - 2), local.random])
    }
    notification_hub = {
      name        = substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "nh"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["nh", substr(local.suffix_hash, 0, 260 - length("nh") - 1)])
      short_name_unique    = join("-", ["nh", substr(local.suffix_hash, 0, 260 - length("nh") - var.unique-length - 2), local.random])
    }
    notification_hub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 256)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (256 - var.unique-length - 1)), local.random]), 0, 256)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 256 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (256 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 256)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 256 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 256 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    notification_hub_namespace = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 50 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 50 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    point_to_site_vpn_gateway = {
      name        = substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vpngw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vpngw", substr(local.suffix_hash, 0, 80 - length("vpngw") - 1)])
      short_name_unique    = join("-", ["vpngw", substr(local.suffix_hash, 0, 80 - length("vpngw") - var.unique-length - 2), local.random])
    }
    postgresql_database = {
      name        = substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "psqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["psqldb", substr(local.suffix_hash, 0, 63 - length("psqldb") - 1)])
      short_name_unique    = join("-", ["psqldb", substr(local.suffix_hash, 0, 63 - length("psqldb") - var.unique-length - 2), local.random])
    }
    postgresql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "psqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["psqlfw", substr(local.suffix_hash, 0, 128 - length("psqlfw") - 1)])
      short_name_unique    = join("-", ["psqlfw", substr(local.suffix_hash, 0, 128 - length("psqlfw") - var.unique-length - 2), local.random])
    }
    postgresql_server = {
      name        = substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["psql", substr(local.suffix_hash, 0, 63 - length("psql") - 1)])
      short_name_unique    = join("-", ["psql", substr(local.suffix_hash, 0, 63 - length("psql") - var.unique-length - 2), local.random])
    }
    postgresql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "psqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["psqlvn", substr(local.suffix_hash, 0, 128 - length("psqlvn") - 1)])
      short_name_unique    = join("-", ["psqlvn", substr(local.suffix_hash, 0, 128 - length("psqlvn") - var.unique-length - 2), local.random])
    }
    powerbi_embedded = {
      name        = substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "pbi"
      min_length  = 3
      max_length  = 63
      scope       = "region"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["pbi", substr(local.suffix_hash, 0, 63 - length("pbi") - 1)])
      short_name_unique    = join("-", ["pbi", substr(local.suffix_hash, 0, 63 - length("pbi") - var.unique-length - 2), local.random])
    }
    private_dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_srv_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - 1)])
      short_name_unique    = join("-", ["pdnsrec", substr(local.suffix_hash, 0, 80 - length("pdnsrec") - var.unique-length - 2), local.random])
    }
    private_dns_zone = {
      name        = substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "pdns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["pdns", substr(local.suffix_hash, 0, 63 - length("pdns") - 1)])
      short_name_unique    = join("-", ["pdns", substr(local.suffix_hash, 0, 63 - length("pdns") - var.unique-length - 2), local.random])
    }
    private_dns_zone_group = {
      name        = substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pdnszg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pdnszg", substr(local.suffix_hash, 0, 80 - length("pdnszg") - 1)])
      short_name_unique    = join("-", ["pdnszg", substr(local.suffix_hash, 0, 80 - length("pdnszg") - var.unique-length - 2), local.random])
    }
    private_endpoint = {
      name        = substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pe"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pe", substr(local.suffix_hash, 0, 80 - length("pe") - 1)])
      short_name_unique    = join("-", ["pe", substr(local.suffix_hash, 0, 80 - length("pe") - var.unique-length - 2), local.random])
    }
    private_link_service = {
      name        = substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pls"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pls", substr(local.suffix_hash, 0, 80 - length("pls") - 1)])
      short_name_unique    = join("-", ["pls", substr(local.suffix_hash, 0, 80 - length("pls") - var.unique-length - 2), local.random])
    }
    private_service_connection = {
      name        = substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "psc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["psc", substr(local.suffix_hash, 0, 80 - length("psc") - 1)])
      short_name_unique    = join("-", ["psc", substr(local.suffix_hash, 0, 80 - length("psc") - var.unique-length - 2), local.random])
    }
    proximity_placement_group = {
      name        = substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "ppg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["ppg", substr(local.suffix_hash, 0, 80 - length("ppg") - 1)])
      short_name_unique    = join("-", ["ppg", substr(local.suffix_hash, 0, 80 - length("ppg") - var.unique-length - 2), local.random])
    }
    public_ip = {
      name        = substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pip"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pip", substr(local.suffix_hash, 0, 80 - length("pip") - 1)])
      short_name_unique    = join("-", ["pip", substr(local.suffix_hash, 0, 80 - length("pip") - var.unique-length - 2), local.random])
    }
    public_ip_prefix = {
      name        = substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "pippf"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["pippf", substr(local.suffix_hash, 0, 80 - length("pippf") - 1)])
      short_name_unique    = join("-", ["pippf", substr(local.suffix_hash, 0, 80 - length("pippf") - var.unique-length - 2), local.random])
    }
    recovery_services_vault = {
      name        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "rsv"
      min_length  = 2
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["rsv", substr(local.suffix_hash, 0, 50 - length("rsv") - 1)])
      short_name_unique    = join("-", ["rsv", substr(local.suffix_hash, 0, 50 - length("rsv") - var.unique-length - 2), local.random])
    }
    redis_cache = {
      name        = substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "redis"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["redis", substr(local.suffix_hash, 0, 63 - length("redis") - 1)])
      short_name_unique    = join("-", ["redis", substr(local.suffix_hash, 0, 63 - length("redis") - var.unique-length - 2), local.random])
    }
    redis_firewall_rule = {
      name        = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, 256)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, (256 - var.unique-length)), local.random]), 0, 256)
      dashes      = false
      slug        = "redisfw"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "^[a-zA-Z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, 256 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, (256 - local.suffix_padding - var.unique-length)), local.random]), 0, 256)
      short_name           = join("", ["redisfw", substr(local.suffix_hash, 0, 256 - length("redisfw"))])
      short_name_unique    = join("", ["redisfw", substr(local.suffix_hash, 0, 256 - length("redisfw") - var.unique-length), local.random])
    }
    relay_hybrid_connection = {
      name        = substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "rlhc"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["rlhc", substr(local.suffix_hash, 0, 260 - length("rlhc") - 1)])
      short_name_unique    = join("-", ["rlhc", substr(local.suffix_hash, 0, 260 - length("rlhc") - var.unique-length - 2), local.random])
    }
    relay_namespace = {
      name        = substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "rln"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["rln", substr(local.suffix_hash, 0, 50 - length("rln") - 1)])
      short_name_unique    = join("-", ["rln", substr(local.suffix_hash, 0, 50 - length("rln") - var.unique-length - 2), local.random])
    }
    resource_group = {
      name        = substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, 90)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, (90 - var.unique-length - 1)), local.random]), 0, 90)
      dashes      = true
      slug        = "rg"
      min_length  = 1
      max_length  = 90
      scope       = "subscription"
      regex       = "^[a-zA-Z0-9-._\\(\\)]+[a-zA-Z0-9-_\\(\\)]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, 90 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, (90 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 90)
      short_name           = join("-", ["rg", substr(local.suffix_hash, 0, 90 - length("rg") - 1)])
      short_name_unique    = join("-", ["rg", substr(local.suffix_hash, 0, 90 - length("rg") - var.unique-length - 2), local.random])
    }
    role_assignment = {
      name        = substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "ra"
      min_length  = 1
      max_length  = 64
      scope       = "assignment"
      regex       = "^[^%]+[^ %.]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["ra", substr(local.suffix_hash, 0, 64 - length("ra") - 1)])
      short_name_unique    = join("-", ["ra", substr(local.suffix_hash, 0, 64 - length("ra") - var.unique-length - 2), local.random])
    }
    role_definition = {
      name        = substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "rd"
      min_length  = 1
      max_length  = 64
      scope       = "definition"
      regex       = "^[^%]+[^ %.]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["rd", substr(local.suffix_hash, 0, 64 - length("rd") - 1)])
      short_name_unique    = join("-", ["rd", substr(local.suffix_hash, 0, 64 - length("rd") - var.unique-length - 2), local.random])
    }
    route = {
      name        = substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "rt"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["rt", substr(local.suffix_hash, 0, 80 - length("rt") - 1)])
      short_name_unique    = join("-", ["rt", substr(local.suffix_hash, 0, 80 - length("rt") - var.unique-length - 2), local.random])
    }
    route_table = {
      name        = substr(join("-", compact([local.prefix, "route", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "route", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "route"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "route", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "route", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["route", substr(local.suffix_hash, 0, 80 - length("route") - 1)])
      short_name_unique    = join("-", ["route", substr(local.suffix_hash, 0, 80 - length("route") - var.unique-length - 2), local.random])
    }
    search_service = {
      name        = substr(join("-", compact([local.prefix, "srch", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "srch", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "srch"
      min_length  = 2
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "srch", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "srch", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["srch", substr(local.suffix_hash, 0, 64 - length("srch") - 1)])
      short_name_unique    = join("-", ["srch", substr(local.suffix_hash, 0, 64 - length("srch") - var.unique-length - 2), local.random])
    }
    service_fabric_cluster = {
      name        = substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, 23)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, (23 - var.unique-length - 1)), local.random]), 0, 23)
      dashes      = true
      slug        = "sf"
      min_length  = 4
      max_length  = 23
      scope       = "region"
      regex       = "^[a-z][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, 23 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, (23 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 23)
      short_name           = join("-", ["sf", substr(local.suffix_hash, 0, 23 - length("sf") - 1)])
      short_name_unique    = join("-", ["sf", substr(local.suffix_hash, 0, 23 - length("sf") - var.unique-length - 2), local.random])
    }
    servicebus_namespace = {
      name        = substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "sb"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["sb", substr(local.suffix_hash, 0, 50 - length("sb") - 1)])
      short_name_unique    = join("-", ["sb", substr(local.suffix_hash, 0, 50 - length("sb") - var.unique-length - 2), local.random])
    }
    servicebus_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "sbar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["sbar", substr(local.suffix_hash, 0, 50 - length("sbar") - 1)])
      short_name_unique    = join("-", ["sbar", substr(local.suffix_hash, 0, 50 - length("sbar") - var.unique-length - 2), local.random])
    }
    servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "sbq"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["sbq", substr(local.suffix_hash, 0, 260 - length("sbq") - 1)])
      short_name_unique    = join("-", ["sbq", substr(local.suffix_hash, 0, 260 - length("sbq") - var.unique-length - 2), local.random])
    }
    servicebus_queue_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "sbqar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["sbqar", substr(local.suffix_hash, 0, 50 - length("sbqar") - 1)])
      short_name_unique    = join("-", ["sbqar", substr(local.suffix_hash, 0, 50 - length("sbqar") - var.unique-length - 2), local.random])
    }
    servicebus_subscription = {
      name        = substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "sbs"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["sbs", substr(local.suffix_hash, 0, 50 - length("sbs") - 1)])
      short_name_unique    = join("-", ["sbs", substr(local.suffix_hash, 0, 50 - length("sbs") - var.unique-length - 2), local.random])
    }
    servicebus_subscription_rule = {
      name        = substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "sbsr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["sbsr", substr(local.suffix_hash, 0, 50 - length("sbsr") - 1)])
      short_name_unique    = join("-", ["sbsr", substr(local.suffix_hash, 0, 50 - length("sbsr") - var.unique-length - 2), local.random])
    }
    servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, 260)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, (260 - var.unique-length - 1)), local.random]), 0, 260)
      dashes      = true
      slug        = "sbt"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, 260 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, (260 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 260)
      short_name           = join("-", ["sbt", substr(local.suffix_hash, 0, 260 - length("sbt") - 1)])
      short_name_unique    = join("-", ["sbt", substr(local.suffix_hash, 0, 260 - length("sbt") - var.unique-length - 2), local.random])
    }
    servicebus_topic_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (50 - var.unique-length - 1)), local.random]), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, (50 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 50)
      short_name           = join("-", ["dnsrec", substr(local.suffix_hash, 0, 50 - length("dnsrec") - 1)])
      short_name_unique    = join("-", ["dnsrec", substr(local.suffix_hash, 0, 50 - length("dnsrec") - var.unique-length - 2), local.random])
    }
    shared_image = {
      name        = substr(join("-", compact([local.prefix, "si", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "si", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "si"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "si", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "si", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["si", substr(local.suffix_hash, 0, 80 - length("si") - 1)])
      short_name_unique    = join("-", ["si", substr(local.suffix_hash, 0, 80 - length("si") - var.unique-length - 2), local.random])
    }
    shared_image_gallery = {
      name        = substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, 80)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, (80 - var.unique-length)), local.random]), 0, 80)
      dashes      = false
      slug        = "sig"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9.]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, (80 - local.suffix_padding - var.unique-length)), local.random]), 0, 80)
      short_name           = join("", ["sig", substr(local.suffix_hash, 0, 80 - length("sig"))])
      short_name_unique    = join("", ["sig", substr(local.suffix_hash, 0, 80 - length("sig") - var.unique-length), local.random])
    }
    signalr_service = {
      name        = substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sgnlr"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sgnlr", substr(local.suffix_hash, 0, 63 - length("sgnlr") - 1)])
      short_name_unique    = join("-", ["sgnlr", substr(local.suffix_hash, 0, 63 - length("sgnlr") - var.unique-length - 2), local.random])
    }
    snapshots = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["snap", substr(local.suffix_hash, 0, 80 - length("snap") - 1)])
      short_name_unique    = join("-", ["snap", substr(local.suffix_hash, 0, 80 - length("snap") - var.unique-length - 2), local.random])
    }
    sql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["sqlep", substr(local.suffix_hash, 0, 128 - length("sqlep") - 1)])
      short_name_unique    = join("-", ["sqlep", substr(local.suffix_hash, 0, 128 - length("sqlep") - var.unique-length - 2), local.random])
    }
    sql_failover_group = {
      name        = substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sqlfg"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sqlfg", substr(local.suffix_hash, 0, 63 - length("sqlfg") - 1)])
      short_name_unique    = join("-", ["sqlfg", substr(local.suffix_hash, 0, 63 - length("sqlfg") - var.unique-length - 2), local.random])
    }
    sql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "sqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:?\\+\\/]+[^<>*%:.?\\+\\/]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["sqlfw", substr(local.suffix_hash, 0, 128 - length("sqlfw") - 1)])
      short_name_unique    = join("-", ["sqlfw", substr(local.suffix_hash, 0, 128 - length("sqlfw") - var.unique-length - 2), local.random])
    }
    sql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sql", substr(local.suffix_hash, 0, 63 - length("sql") - 1)])
      short_name_unique    = join("-", ["sql", substr(local.suffix_hash, 0, 63 - length("sql") - var.unique-length - 2), local.random])
    }
    static_web_app = {
      name        = substr(join("-", compact([local.prefix, "stapp", local.suffix])), 0, 40)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "stapp", local.suffix])), 0, (40 - var.unique-length - 1)), local.random]), 0, 40)
      dashes      = true
      slug        = "stapp"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "stapp", local.suffix])), 0, 40 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "stapp", local.suffix])), 0, (40 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 40)
      short_name           = join("-", ["stapp", substr(local.suffix_hash, 0, 40 - length("stapp") - 1)])
      short_name_unique    = join("-", ["stapp", substr(local.suffix_hash, 0, 40 - length("stapp") - var.unique-length - 2), local.random])
    }
    storage_account = {
      name        = substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", [substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, (24 - var.unique-length)), local.random]), 0, 24)
      dashes      = false
      slug        = "st"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-z0-9]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, 24 - local.suffix_padding)
      name_unique_with_pad = substr(join("", [substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, (24 - local.suffix_padding - var.unique-length)), local.random]), 0, 24)
      short_name           = join("", ["st", substr(local.suffix_hash, 0, 24 - length("st"))])
      short_name_unique    = join("", ["st", substr(local.suffix_hash, 0, 24 - length("st") - var.unique-length), local.random])
    }
    storage_blob = {
      name        = substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, 1024)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, (1024 - var.unique-length - 1)), local.random]), 0, 1024)
      dashes      = true
      slug        = "blob"
      min_length  = 1
      max_length  = 1024
      scope       = "parent"
      regex       = "^[^\\s\\/$#&]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, 1024 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, (1024 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 1024)
      short_name           = join("-", ["blob", substr(local.suffix_hash, 0, 1024 - length("blob") - 1)])
      short_name_unique    = join("-", ["blob", substr(local.suffix_hash, 0, 1024 - length("blob") - var.unique-length - 2), local.random])
    }
    storage_container = {
      name        = substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "stct"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["stct", substr(local.suffix_hash, 0, 63 - length("stct") - 1)])
      short_name_unique    = join("-", ["stct", substr(local.suffix_hash, 0, 63 - length("stct") - var.unique-length - 2), local.random])
    }
    storage_data_lake_gen2_filesystem = {
      name        = substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "stdl"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["stdl", substr(local.suffix_hash, 0, 63 - length("stdl") - 1)])
      short_name_unique    = join("-", ["stdl", substr(local.suffix_hash, 0, 63 - length("stdl") - var.unique-length - 2), local.random])
    }
    storage_queue = {
      name        = substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "stq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["stq", substr(local.suffix_hash, 0, 63 - length("stq") - 1)])
      short_name_unique    = join("-", ["stq", substr(local.suffix_hash, 0, 63 - length("stq") - var.unique-length - 2), local.random])
    }
    storage_share = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sts", substr(local.suffix_hash, 0, 63 - length("sts") - 1)])
      short_name_unique    = join("-", ["sts", substr(local.suffix_hash, 0, 63 - length("sts") - var.unique-length - 2), local.random])
    }
    storage_share_directory = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["sts", substr(local.suffix_hash, 0, 63 - length("sts") - 1)])
      short_name_unique    = join("-", ["sts", substr(local.suffix_hash, 0, 63 - length("sts") - var.unique-length - 2), local.random])
    }
    storage_table = {
      name        = substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "stt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["stt", substr(local.suffix_hash, 0, 63 - length("stt") - 1)])
      short_name_unique    = join("-", ["stt", substr(local.suffix_hash, 0, 63 - length("stt") - var.unique-length - 2), local.random])
    }
    stream_analytics_function_javascript_udf = {
      name        = substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asafunc"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asafunc", substr(local.suffix_hash, 0, 63 - length("asafunc") - 1)])
      short_name_unique    = join("-", ["asafunc", substr(local.suffix_hash, 0, 63 - length("asafunc") - var.unique-length - 2), local.random])
    }
    stream_analytics_job = {
      name        = substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asa"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asa", substr(local.suffix_hash, 0, 63 - length("asa") - 1)])
      short_name_unique    = join("-", ["asa", substr(local.suffix_hash, 0, 63 - length("asa") - var.unique-length - 2), local.random])
    }
    stream_analytics_output_blob = {
      name        = substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaoblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaoblob", substr(local.suffix_hash, 0, 63 - length("asaoblob") - 1)])
      short_name_unique    = join("-", ["asaoblob", substr(local.suffix_hash, 0, 63 - length("asaoblob") - var.unique-length - 2), local.random])
    }
    stream_analytics_output_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaoeh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaoeh", substr(local.suffix_hash, 0, 63 - length("asaoeh") - 1)])
      short_name_unique    = join("-", ["asaoeh", substr(local.suffix_hash, 0, 63 - length("asaoeh") - var.unique-length - 2), local.random])
    }
    stream_analytics_output_mssql = {
      name        = substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaomssql"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaomssql", substr(local.suffix_hash, 0, 63 - length("asaomssql") - 1)])
      short_name_unique    = join("-", ["asaomssql", substr(local.suffix_hash, 0, 63 - length("asaomssql") - var.unique-length - 2), local.random])
    }
    stream_analytics_output_servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaosbq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaosbq", substr(local.suffix_hash, 0, 63 - length("asaosbq") - 1)])
      short_name_unique    = join("-", ["asaosbq", substr(local.suffix_hash, 0, 63 - length("asaosbq") - var.unique-length - 2), local.random])
    }
    stream_analytics_output_servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaosbt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaosbt", substr(local.suffix_hash, 0, 63 - length("asaosbt") - 1)])
      short_name_unique    = join("-", ["asaosbt", substr(local.suffix_hash, 0, 63 - length("asaosbt") - var.unique-length - 2), local.random])
    }
    stream_analytics_reference_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asarblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asarblob", substr(local.suffix_hash, 0, 63 - length("asarblob") - 1)])
      short_name_unique    = join("-", ["asarblob", substr(local.suffix_hash, 0, 63 - length("asarblob") - var.unique-length - 2), local.random])
    }
    stream_analytics_stream_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaiblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaiblob", substr(local.suffix_hash, 0, 63 - length("asaiblob") - 1)])
      short_name_unique    = join("-", ["asaiblob", substr(local.suffix_hash, 0, 63 - length("asaiblob") - var.unique-length - 2), local.random])
    }
    stream_analytics_stream_input_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaieh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaieh", substr(local.suffix_hash, 0, 63 - length("asaieh") - 1)])
      short_name_unique    = join("-", ["asaieh", substr(local.suffix_hash, 0, 63 - length("asaieh") - var.unique-length - 2), local.random])
    }
    stream_analytics_stream_input_iothub = {
      name        = substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "asaiiot"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["asaiiot", substr(local.suffix_hash, 0, 63 - length("asaiiot") - 1)])
      short_name_unique    = join("-", ["asaiiot", substr(local.suffix_hash, 0, 63 - length("asaiiot") - var.unique-length - 2), local.random])
    }
    subnet = {
      name        = substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "snet"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["snet", substr(local.suffix_hash, 0, 80 - length("snet") - 1)])
      short_name_unique    = join("-", ["snet", substr(local.suffix_hash, 0, 80 - length("snet") - var.unique-length - 2), local.random])
    }
    template_deployment = {
      name        = substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "deploy"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-._\\(\\)]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["deploy", substr(local.suffix_hash, 0, 64 - length("deploy") - 1)])
      short_name_unique    = join("-", ["deploy", substr(local.suffix_hash, 0, 64 - length("deploy") - var.unique-length - 2), local.random])
    }
    traffic_manager_profile = {
      name        = substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "traf"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["traf", substr(local.suffix_hash, 0, 63 - length("traf") - 1)])
      short_name_unique    = join("-", ["traf", substr(local.suffix_hash, 0, 63 - length("traf") - var.unique-length - 2), local.random])
    }
    user_assigned_identity = {
      name        = substr(join("-", compact([local.prefix, "uai", local.suffix])), 0, 128)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "uai", local.suffix])), 0, (128 - var.unique-length - 1)), local.random]), 0, 128)
      dashes      = true
      slug        = "uai"
      min_length  = 3
      max_length  = 128
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "uai", local.suffix])), 0, 128 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "uai", local.suffix])), 0, (128 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 128)
      short_name           = join("-", ["uai", substr(local.suffix_hash, 0, 128 - length("uai") - 1)])
      short_name_unique    = join("-", ["uai", substr(local.suffix_hash, 0, 128 - length("uai") - var.unique-length - 2), local.random])
    }
    virtual_desktop_application_group = {
      name        = substr(join("-", compact([local.prefix, "vdag", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vdag", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "vdag"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vdag", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vdag", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["vdag", substr(local.suffix_hash, 0, 63 - length("vdag") - 1)])
      short_name_unique    = join("-", ["vdag", substr(local.suffix_hash, 0, 63 - length("vdag") - var.unique-length - 2), local.random])
    }
    virtual_desktop_host_pool = {
      name        = substr(join("-", compact([local.prefix, "vdpool", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vdpool", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "vdpool"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vdpool", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vdpool", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["vdpool", substr(local.suffix_hash, 0, 63 - length("vdpool") - 1)])
      short_name_unique    = join("-", ["vdpool", substr(local.suffix_hash, 0, 63 - length("vdpool") - var.unique-length - 2), local.random])
    }
    virtual_desktop_scaling_plan = {
      name        = substr(join("-", compact([local.prefix, "vdscaling", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vdscaling", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "vdscaling"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vdscaling", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vdscaling", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["vdscaling", substr(local.suffix_hash, 0, 63 - length("vdscaling") - 1)])
      short_name_unique    = join("-", ["vdscaling", substr(local.suffix_hash, 0, 63 - length("vdscaling") - var.unique-length - 2), local.random])
    }
    virtual_desktop_workspace = {
      name        = substr(join("-", compact([local.prefix, "vdws", local.suffix])), 0, 63)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vdws", local.suffix])), 0, (63 - var.unique-length - 1)), local.random]), 0, 63)
      dashes      = true
      slug        = "vdws"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vdws", local.suffix])), 0, 63 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vdws", local.suffix])), 0, (63 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 63)
      short_name           = join("-", ["vdws", substr(local.suffix_hash, 0, 63 - length("vdws") - 1)])
      short_name_unique    = join("-", ["vdws", substr(local.suffix_hash, 0, 63 - length("vdws") - var.unique-length - 2), local.random])
    }
    virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (15 - var.unique-length - 1)), local.random]), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (15 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 15)
      short_name           = join("-", ["vm", substr(local.suffix_hash, 0, 15 - length("vm") - 1)])
      short_name_unique    = join("-", ["vm", substr(local.suffix_hash, 0, 15 - length("vm") - var.unique-length - 2), local.random])
    }
    virtual_machine_extension = {
      name        = substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vmx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vmx", substr(local.suffix_hash, 0, 80 - length("vmx") - 1)])
      short_name_unique    = join("-", ["vmx", substr(local.suffix_hash, 0, 80 - length("vmx") - var.unique-length - 2), local.random])
    }
    virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (15 - var.unique-length - 1)), local.random]), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (15 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 15)
      short_name           = join("-", ["vmss", substr(local.suffix_hash, 0, 15 - length("vmss") - 1)])
      short_name_unique    = join("-", ["vmss", substr(local.suffix_hash, 0, 15 - length("vmss") - var.unique-length - 2), local.random])
    }
    virtual_machine_scale_set_extension = {
      name        = substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vmssx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vmssx", substr(local.suffix_hash, 0, 80 - length("vmssx") - 1)])
      short_name_unique    = join("-", ["vmssx", substr(local.suffix_hash, 0, 80 - length("vmssx") - var.unique-length - 2), local.random])
    }
    virtual_network = {
      name        = substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, 64)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, (64 - var.unique-length - 1)), local.random]), 0, 64)
      dashes      = true
      slug        = "vnet"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, 64 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, (64 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 64)
      short_name           = join("-", ["vnet", substr(local.suffix_hash, 0, 64 - length("vnet") - 1)])
      short_name_unique    = join("-", ["vnet", substr(local.suffix_hash, 0, 64 - length("vnet") - var.unique-length - 2), local.random])
    }
    virtual_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vgw", substr(local.suffix_hash, 0, 80 - length("vgw") - 1)])
      short_name_unique    = join("-", ["vgw", substr(local.suffix_hash, 0, 80 - length("vgw") - var.unique-length - 2), local.random])
    }
    virtual_network_gateway_connection = {
      name        = substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vcn"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vcn", substr(local.suffix_hash, 0, 80 - length("vcn") - 1)])
      short_name_unique    = join("-", ["vcn", substr(local.suffix_hash, 0, 80 - length("vcn") - var.unique-length - 2), local.random])
    }
    virtual_network_peering = {
      name        = substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vpeer"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vpeer", substr(local.suffix_hash, 0, 80 - length("vpeer") - 1)])
      short_name_unique    = join("-", ["vpeer", substr(local.suffix_hash, 0, 80 - length("vpeer") - var.unique-length - 2), local.random])
    }
    virtual_wan = {
      name        = substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, 80)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, (80 - var.unique-length - 1)), local.random]), 0, 80)
      dashes      = true
      slug        = "vwan"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, 80 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, (80 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 80)
      short_name           = join("-", ["vwan", substr(local.suffix_hash, 0, 80 - length("vwan") - 1)])
      short_name_unique    = join("-", ["vwan", substr(local.suffix_hash, 0, 80 - length("vwan") - var.unique-length - 2), local.random])
    }
    windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (15 - var.unique-length - 1)), local.random]), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, (15 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 15)
      short_name           = join("-", ["vm", substr(local.suffix_hash, 0, 15 - length("vm") - 1)])
      short_name_unique    = join("-", ["vm", substr(local.suffix_hash, 0, 15 - length("vm") - var.unique-length - 2), local.random])
    }
    windows_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (15 - var.unique-length - 1)), local.random]), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"

      suffix_padding       = local.suffix_padding
      name_with_pad        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15 - local.suffix_padding)
      name_unique_with_pad = substr(join("-", [substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, (15 - local.suffix_padding - var.unique-length - 1)), local.random]), 0, 15)
      short_name           = join("-", ["vmss", substr(local.suffix_hash, 0, 15 - length("vmss") - 1)])
      short_name_unique    = join("-", ["vmss", substr(local.suffix_hash, 0, 15 - length("vmss") - var.unique-length - 2), local.random])
    }
  }
  validation = {
    analysis_services_server = {
      valid_name        = length(regexall(local.az.analysis_services_server.regex, local.az.analysis_services_server.name)) > 0 && length(local.az.analysis_services_server.name) > local.az.analysis_services_server.min_length
      valid_name_unique = length(regexall(local.az.analysis_services_server.regex, local.az.analysis_services_server.name_unique)) > 0
    }
    api_management = {
      valid_name        = length(regexall(local.az.api_management.regex, local.az.api_management.name)) > 0 && length(local.az.api_management.name) > local.az.api_management.min_length
      valid_name_unique = length(regexall(local.az.api_management.regex, local.az.api_management.name_unique)) > 0
    }
    app_configuration = {
      valid_name        = length(regexall(local.az.app_configuration.regex, local.az.app_configuration.name)) > 0 && length(local.az.app_configuration.name) > local.az.app_configuration.min_length
      valid_name_unique = length(regexall(local.az.app_configuration.regex, local.az.app_configuration.name_unique)) > 0
    }
    app_service = {
      valid_name        = length(regexall(local.az.app_service.regex, local.az.app_service.name)) > 0 && length(local.az.app_service.name) > local.az.app_service.min_length
      valid_name_unique = length(regexall(local.az.app_service.regex, local.az.app_service.name_unique)) > 0
    }
    app_service_environment = {
      valid_name        = length(regexall(local.az.app_service_environment.regex, local.az.app_service_environment.name)) > 0 && length(local.az.app_service_environment.name) > local.az.app_service_environment.min_length
      valid_name_unique = length(regexall(local.az.app_service_environment.regex, local.az.app_service_environment.name_unique)) > 0
    }
    app_service_plan = {
      valid_name        = length(regexall(local.az.app_service_plan.regex, local.az.app_service_plan.name)) > 0 && length(local.az.app_service_plan.name) > local.az.app_service_plan.min_length
      valid_name_unique = length(regexall(local.az.app_service_plan.regex, local.az.app_service_plan.name_unique)) > 0
    }
    application_gateway = {
      valid_name        = length(regexall(local.az.application_gateway.regex, local.az.application_gateway.name)) > 0 && length(local.az.application_gateway.name) > local.az.application_gateway.min_length
      valid_name_unique = length(regexall(local.az.application_gateway.regex, local.az.application_gateway.name_unique)) > 0
    }
    application_insights = {
      valid_name        = length(regexall(local.az.application_insights.regex, local.az.application_insights.name)) > 0 && length(local.az.application_insights.name) > local.az.application_insights.min_length
      valid_name_unique = length(regexall(local.az.application_insights.regex, local.az.application_insights.name_unique)) > 0
    }
    application_security_group = {
      valid_name        = length(regexall(local.az.application_security_group.regex, local.az.application_security_group.name)) > 0 && length(local.az.application_security_group.name) > local.az.application_security_group.min_length
      valid_name_unique = length(regexall(local.az.application_security_group.regex, local.az.application_security_group.name_unique)) > 0
    }
    automation_account = {
      valid_name        = length(regexall(local.az.automation_account.regex, local.az.automation_account.name)) > 0 && length(local.az.automation_account.name) > local.az.automation_account.min_length
      valid_name_unique = length(regexall(local.az.automation_account.regex, local.az.automation_account.name_unique)) > 0
    }
    automation_certificate = {
      valid_name        = length(regexall(local.az.automation_certificate.regex, local.az.automation_certificate.name)) > 0 && length(local.az.automation_certificate.name) > local.az.automation_certificate.min_length
      valid_name_unique = length(regexall(local.az.automation_certificate.regex, local.az.automation_certificate.name_unique)) > 0
    }
    automation_credential = {
      valid_name        = length(regexall(local.az.automation_credential.regex, local.az.automation_credential.name)) > 0 && length(local.az.automation_credential.name) > local.az.automation_credential.min_length
      valid_name_unique = length(regexall(local.az.automation_credential.regex, local.az.automation_credential.name_unique)) > 0
    }
    automation_runbook = {
      valid_name        = length(regexall(local.az.automation_runbook.regex, local.az.automation_runbook.name)) > 0 && length(local.az.automation_runbook.name) > local.az.automation_runbook.min_length
      valid_name_unique = length(regexall(local.az.automation_runbook.regex, local.az.automation_runbook.name_unique)) > 0
    }
    automation_schedule = {
      valid_name        = length(regexall(local.az.automation_schedule.regex, local.az.automation_schedule.name)) > 0 && length(local.az.automation_schedule.name) > local.az.automation_schedule.min_length
      valid_name_unique = length(regexall(local.az.automation_schedule.regex, local.az.automation_schedule.name_unique)) > 0
    }
    automation_variable = {
      valid_name        = length(regexall(local.az.automation_variable.regex, local.az.automation_variable.name)) > 0 && length(local.az.automation_variable.name) > local.az.automation_variable.min_length
      valid_name_unique = length(regexall(local.az.automation_variable.regex, local.az.automation_variable.name_unique)) > 0
    }
    availability_set = {
      valid_name        = length(regexall(local.az.availability_set.regex, local.az.availability_set.name)) > 0 && length(local.az.availability_set.name) > local.az.availability_set.min_length
      valid_name_unique = length(regexall(local.az.availability_set.regex, local.az.availability_set.name_unique)) > 0
    }
    bastion_host = {
      valid_name        = length(regexall(local.az.bastion_host.regex, local.az.bastion_host.name)) > 0 && length(local.az.bastion_host.name) > local.az.bastion_host.min_length
      valid_name_unique = length(regexall(local.az.bastion_host.regex, local.az.bastion_host.name_unique)) > 0
    }
    batch_account = {
      valid_name        = length(regexall(local.az.batch_account.regex, local.az.batch_account.name)) > 0 && length(local.az.batch_account.name) > local.az.batch_account.min_length
      valid_name_unique = length(regexall(local.az.batch_account.regex, local.az.batch_account.name_unique)) > 0
    }
    batch_application = {
      valid_name        = length(regexall(local.az.batch_application.regex, local.az.batch_application.name)) > 0 && length(local.az.batch_application.name) > local.az.batch_application.min_length
      valid_name_unique = length(regexall(local.az.batch_application.regex, local.az.batch_application.name_unique)) > 0
    }
    batch_certificate = {
      valid_name        = length(regexall(local.az.batch_certificate.regex, local.az.batch_certificate.name)) > 0 && length(local.az.batch_certificate.name) > local.az.batch_certificate.min_length
      valid_name_unique = length(regexall(local.az.batch_certificate.regex, local.az.batch_certificate.name_unique)) > 0
    }
    batch_pool = {
      valid_name        = length(regexall(local.az.batch_pool.regex, local.az.batch_pool.name)) > 0 && length(local.az.batch_pool.name) > local.az.batch_pool.min_length
      valid_name_unique = length(regexall(local.az.batch_pool.regex, local.az.batch_pool.name_unique)) > 0
    }
    bot_channel_directline = {
      valid_name        = length(regexall(local.az.bot_channel_directline.regex, local.az.bot_channel_directline.name)) > 0 && length(local.az.bot_channel_directline.name) > local.az.bot_channel_directline.min_length
      valid_name_unique = length(regexall(local.az.bot_channel_directline.regex, local.az.bot_channel_directline.name_unique)) > 0
    }
    bot_channel_email = {
      valid_name        = length(regexall(local.az.bot_channel_email.regex, local.az.bot_channel_email.name)) > 0 && length(local.az.bot_channel_email.name) > local.az.bot_channel_email.min_length
      valid_name_unique = length(regexall(local.az.bot_channel_email.regex, local.az.bot_channel_email.name_unique)) > 0
    }
    bot_channel_ms_teams = {
      valid_name        = length(regexall(local.az.bot_channel_ms_teams.regex, local.az.bot_channel_ms_teams.name)) > 0 && length(local.az.bot_channel_ms_teams.name) > local.az.bot_channel_ms_teams.min_length
      valid_name_unique = length(regexall(local.az.bot_channel_ms_teams.regex, local.az.bot_channel_ms_teams.name_unique)) > 0
    }
    bot_channel_slack = {
      valid_name        = length(regexall(local.az.bot_channel_slack.regex, local.az.bot_channel_slack.name)) > 0 && length(local.az.bot_channel_slack.name) > local.az.bot_channel_slack.min_length
      valid_name_unique = length(regexall(local.az.bot_channel_slack.regex, local.az.bot_channel_slack.name_unique)) > 0
    }
    bot_channels_registration = {
      valid_name        = length(regexall(local.az.bot_channels_registration.regex, local.az.bot_channels_registration.name)) > 0 && length(local.az.bot_channels_registration.name) > local.az.bot_channels_registration.min_length
      valid_name_unique = length(regexall(local.az.bot_channels_registration.regex, local.az.bot_channels_registration.name_unique)) > 0
    }
    bot_connection = {
      valid_name        = length(regexall(local.az.bot_connection.regex, local.az.bot_connection.name)) > 0 && length(local.az.bot_connection.name) > local.az.bot_connection.min_length
      valid_name_unique = length(regexall(local.az.bot_connection.regex, local.az.bot_connection.name_unique)) > 0
    }
    bot_web_app = {
      valid_name        = length(regexall(local.az.bot_web_app.regex, local.az.bot_web_app.name)) > 0 && length(local.az.bot_web_app.name) > local.az.bot_web_app.min_length
      valid_name_unique = length(regexall(local.az.bot_web_app.regex, local.az.bot_web_app.name_unique)) > 0
    }
    cdn_endpoint = {
      valid_name        = length(regexall(local.az.cdn_endpoint.regex, local.az.cdn_endpoint.name)) > 0 && length(local.az.cdn_endpoint.name) > local.az.cdn_endpoint.min_length
      valid_name_unique = length(regexall(local.az.cdn_endpoint.regex, local.az.cdn_endpoint.name_unique)) > 0
    }
    cdn_profile = {
      valid_name        = length(regexall(local.az.cdn_profile.regex, local.az.cdn_profile.name)) > 0 && length(local.az.cdn_profile.name) > local.az.cdn_profile.min_length
      valid_name_unique = length(regexall(local.az.cdn_profile.regex, local.az.cdn_profile.name_unique)) > 0
    }
    cognitive_account = {
      valid_name        = length(regexall(local.az.cognitive_account.regex, local.az.cognitive_account.name)) > 0 && length(local.az.cognitive_account.name) > local.az.cognitive_account.min_length
      valid_name_unique = length(regexall(local.az.cognitive_account.regex, local.az.cognitive_account.name_unique)) > 0
    }
    container_app = {
      valid_name        = length(regexall(local.az.container_app.regex, local.az.container_app.name)) > 0 && length(local.az.container_app.name) > local.az.container_app.min_length
      valid_name_unique = length(regexall(local.az.container_app.regex, local.az.container_app.name_unique)) > 0
    }
    container_app_environment = {
      valid_name        = length(regexall(local.az.container_app_environment.regex, local.az.container_app_environment.name)) > 0 && length(local.az.container_app_environment.name) > local.az.container_app_environment.min_length
      valid_name_unique = length(regexall(local.az.container_app_environment.regex, local.az.container_app_environment.name_unique)) > 0
    }
    container_group = {
      valid_name        = length(regexall(local.az.container_group.regex, local.az.container_group.name)) > 0 && length(local.az.container_group.name) > local.az.container_group.min_length
      valid_name_unique = length(regexall(local.az.container_group.regex, local.az.container_group.name_unique)) > 0
    }
    container_registry = {
      valid_name        = length(regexall(local.az.container_registry.regex, local.az.container_registry.name)) > 0 && length(local.az.container_registry.name) > local.az.container_registry.min_length
      valid_name_unique = length(regexall(local.az.container_registry.regex, local.az.container_registry.name_unique)) > 0
    }
    container_registry_webhook = {
      valid_name        = length(regexall(local.az.container_registry_webhook.regex, local.az.container_registry_webhook.name)) > 0 && length(local.az.container_registry_webhook.name) > local.az.container_registry_webhook.min_length
      valid_name_unique = length(regexall(local.az.container_registry_webhook.regex, local.az.container_registry_webhook.name_unique)) > 0
    }
    cosmosdb_account = {
      valid_name        = length(regexall(local.az.cosmosdb_account.regex, local.az.cosmosdb_account.name)) > 0 && length(local.az.cosmosdb_account.name) > local.az.cosmosdb_account.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_account.regex, local.az.cosmosdb_account.name_unique)) > 0
    }
    cosmosdb_cassandra_cluster = {
      valid_name        = length(regexall(local.az.cosmosdb_cassandra_cluster.regex, local.az.cosmosdb_cassandra_cluster.name)) > 0 && length(local.az.cosmosdb_cassandra_cluster.name) > local.az.cosmosdb_cassandra_cluster.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_cassandra_cluster.regex, local.az.cosmosdb_cassandra_cluster.name_unique)) > 0
    }
    cosmosdb_cassandra_datacenter = {
      valid_name        = length(regexall(local.az.cosmosdb_cassandra_datacenter.regex, local.az.cosmosdb_cassandra_datacenter.name)) > 0 && length(local.az.cosmosdb_cassandra_datacenter.name) > local.az.cosmosdb_cassandra_datacenter.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_cassandra_datacenter.regex, local.az.cosmosdb_cassandra_datacenter.name_unique)) > 0
    }
    cosmosdb_postgres = {
      valid_name        = length(regexall(local.az.cosmosdb_postgres.regex, local.az.cosmosdb_postgres.name)) > 0 && length(local.az.cosmosdb_postgres.name) > local.az.cosmosdb_postgres.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_postgres.regex, local.az.cosmosdb_postgres.name_unique)) > 0
    }
    custom_provider = {
      valid_name        = length(regexall(local.az.custom_provider.regex, local.az.custom_provider.name)) > 0 && length(local.az.custom_provider.name) > local.az.custom_provider.min_length
      valid_name_unique = length(regexall(local.az.custom_provider.regex, local.az.custom_provider.name_unique)) > 0
    }
    dashboard = {
      valid_name        = length(regexall(local.az.dashboard.regex, local.az.dashboard.name)) > 0 && length(local.az.dashboard.name) > local.az.dashboard.min_length
      valid_name_unique = length(regexall(local.az.dashboard.regex, local.az.dashboard.name_unique)) > 0
    }
    data_factory = {
      valid_name        = length(regexall(local.az.data_factory.regex, local.az.data_factory.name)) > 0 && length(local.az.data_factory.name) > local.az.data_factory.min_length
      valid_name_unique = length(regexall(local.az.data_factory.regex, local.az.data_factory.name_unique)) > 0
    }
    data_factory_dataset_mysql = {
      valid_name        = length(regexall(local.az.data_factory_dataset_mysql.regex, local.az.data_factory_dataset_mysql.name)) > 0 && length(local.az.data_factory_dataset_mysql.name) > local.az.data_factory_dataset_mysql.min_length
      valid_name_unique = length(regexall(local.az.data_factory_dataset_mysql.regex, local.az.data_factory_dataset_mysql.name_unique)) > 0
    }
    data_factory_dataset_postgresql = {
      valid_name        = length(regexall(local.az.data_factory_dataset_postgresql.regex, local.az.data_factory_dataset_postgresql.name)) > 0 && length(local.az.data_factory_dataset_postgresql.name) > local.az.data_factory_dataset_postgresql.min_length
      valid_name_unique = length(regexall(local.az.data_factory_dataset_postgresql.regex, local.az.data_factory_dataset_postgresql.name_unique)) > 0
    }
    data_factory_dataset_sql_server_table = {
      valid_name        = length(regexall(local.az.data_factory_dataset_sql_server_table.regex, local.az.data_factory_dataset_sql_server_table.name)) > 0 && length(local.az.data_factory_dataset_sql_server_table.name) > local.az.data_factory_dataset_sql_server_table.min_length
      valid_name_unique = length(regexall(local.az.data_factory_dataset_sql_server_table.regex, local.az.data_factory_dataset_sql_server_table.name_unique)) > 0
    }
    data_factory_integration_runtime_managed = {
      valid_name        = length(regexall(local.az.data_factory_integration_runtime_managed.regex, local.az.data_factory_integration_runtime_managed.name)) > 0 && length(local.az.data_factory_integration_runtime_managed.name) > local.az.data_factory_integration_runtime_managed.min_length
      valid_name_unique = length(regexall(local.az.data_factory_integration_runtime_managed.regex, local.az.data_factory_integration_runtime_managed.name_unique)) > 0
    }
    data_factory_linked_service_data_lake_storage_gen2 = {
      valid_name        = length(regexall(local.az.data_factory_linked_service_data_lake_storage_gen2.regex, local.az.data_factory_linked_service_data_lake_storage_gen2.name)) > 0 && length(local.az.data_factory_linked_service_data_lake_storage_gen2.name) > local.az.data_factory_linked_service_data_lake_storage_gen2.min_length
      valid_name_unique = length(regexall(local.az.data_factory_linked_service_data_lake_storage_gen2.regex, local.az.data_factory_linked_service_data_lake_storage_gen2.name_unique)) > 0
    }
    data_factory_linked_service_key_vault = {
      valid_name        = length(regexall(local.az.data_factory_linked_service_key_vault.regex, local.az.data_factory_linked_service_key_vault.name)) > 0 && length(local.az.data_factory_linked_service_key_vault.name) > local.az.data_factory_linked_service_key_vault.min_length
      valid_name_unique = length(regexall(local.az.data_factory_linked_service_key_vault.regex, local.az.data_factory_linked_service_key_vault.name_unique)) > 0
    }
    data_factory_linked_service_mysql = {
      valid_name        = length(regexall(local.az.data_factory_linked_service_mysql.regex, local.az.data_factory_linked_service_mysql.name)) > 0 && length(local.az.data_factory_linked_service_mysql.name) > local.az.data_factory_linked_service_mysql.min_length
      valid_name_unique = length(regexall(local.az.data_factory_linked_service_mysql.regex, local.az.data_factory_linked_service_mysql.name_unique)) > 0
    }
    data_factory_linked_service_postgresql = {
      valid_name        = length(regexall(local.az.data_factory_linked_service_postgresql.regex, local.az.data_factory_linked_service_postgresql.name)) > 0 && length(local.az.data_factory_linked_service_postgresql.name) > local.az.data_factory_linked_service_postgresql.min_length
      valid_name_unique = length(regexall(local.az.data_factory_linked_service_postgresql.regex, local.az.data_factory_linked_service_postgresql.name_unique)) > 0
    }
    data_factory_linked_service_sql_server = {
      valid_name        = length(regexall(local.az.data_factory_linked_service_sql_server.regex, local.az.data_factory_linked_service_sql_server.name)) > 0 && length(local.az.data_factory_linked_service_sql_server.name) > local.az.data_factory_linked_service_sql_server.min_length
      valid_name_unique = length(regexall(local.az.data_factory_linked_service_sql_server.regex, local.az.data_factory_linked_service_sql_server.name_unique)) > 0
    }
    data_factory_pipeline = {
      valid_name        = length(regexall(local.az.data_factory_pipeline.regex, local.az.data_factory_pipeline.name)) > 0 && length(local.az.data_factory_pipeline.name) > local.az.data_factory_pipeline.min_length
      valid_name_unique = length(regexall(local.az.data_factory_pipeline.regex, local.az.data_factory_pipeline.name_unique)) > 0
    }
    data_factory_trigger_schedule = {
      valid_name        = length(regexall(local.az.data_factory_trigger_schedule.regex, local.az.data_factory_trigger_schedule.name)) > 0 && length(local.az.data_factory_trigger_schedule.name) > local.az.data_factory_trigger_schedule.min_length
      valid_name_unique = length(regexall(local.az.data_factory_trigger_schedule.regex, local.az.data_factory_trigger_schedule.name_unique)) > 0
    }
    data_lake_analytics_account = {
      valid_name        = length(regexall(local.az.data_lake_analytics_account.regex, local.az.data_lake_analytics_account.name)) > 0 && length(local.az.data_lake_analytics_account.name) > local.az.data_lake_analytics_account.min_length
      valid_name_unique = length(regexall(local.az.data_lake_analytics_account.regex, local.az.data_lake_analytics_account.name_unique)) > 0
    }
    data_lake_analytics_firewall_rule = {
      valid_name        = length(regexall(local.az.data_lake_analytics_firewall_rule.regex, local.az.data_lake_analytics_firewall_rule.name)) > 0 && length(local.az.data_lake_analytics_firewall_rule.name) > local.az.data_lake_analytics_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.data_lake_analytics_firewall_rule.regex, local.az.data_lake_analytics_firewall_rule.name_unique)) > 0
    }
    data_lake_store = {
      valid_name        = length(regexall(local.az.data_lake_store.regex, local.az.data_lake_store.name)) > 0 && length(local.az.data_lake_store.name) > local.az.data_lake_store.min_length
      valid_name_unique = length(regexall(local.az.data_lake_store.regex, local.az.data_lake_store.name_unique)) > 0
    }
    data_lake_store_firewall_rule = {
      valid_name        = length(regexall(local.az.data_lake_store_firewall_rule.regex, local.az.data_lake_store_firewall_rule.name)) > 0 && length(local.az.data_lake_store_firewall_rule.name) > local.az.data_lake_store_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.data_lake_store_firewall_rule.regex, local.az.data_lake_store_firewall_rule.name_unique)) > 0
    }
    database_migration_project = {
      valid_name        = length(regexall(local.az.database_migration_project.regex, local.az.database_migration_project.name)) > 0 && length(local.az.database_migration_project.name) > local.az.database_migration_project.min_length
      valid_name_unique = length(regexall(local.az.database_migration_project.regex, local.az.database_migration_project.name_unique)) > 0
    }
    database_migration_service = {
      valid_name        = length(regexall(local.az.database_migration_service.regex, local.az.database_migration_service.name)) > 0 && length(local.az.database_migration_service.name) > local.az.database_migration_service.min_length
      valid_name_unique = length(regexall(local.az.database_migration_service.regex, local.az.database_migration_service.name_unique)) > 0
    }
    databricks_cluster = {
      valid_name        = length(regexall(local.az.databricks_cluster.regex, local.az.databricks_cluster.name)) > 0 && length(local.az.databricks_cluster.name) > local.az.databricks_cluster.min_length
      valid_name_unique = length(regexall(local.az.databricks_cluster.regex, local.az.databricks_cluster.name_unique)) > 0
    }
    databricks_high_concurrency_cluster = {
      valid_name        = length(regexall(local.az.databricks_high_concurrency_cluster.regex, local.az.databricks_high_concurrency_cluster.name)) > 0 && length(local.az.databricks_high_concurrency_cluster.name) > local.az.databricks_high_concurrency_cluster.min_length
      valid_name_unique = length(regexall(local.az.databricks_high_concurrency_cluster.regex, local.az.databricks_high_concurrency_cluster.name_unique)) > 0
    }
    databricks_standard_cluster = {
      valid_name        = length(regexall(local.az.databricks_standard_cluster.regex, local.az.databricks_standard_cluster.name)) > 0 && length(local.az.databricks_standard_cluster.name) > local.az.databricks_standard_cluster.min_length
      valid_name_unique = length(regexall(local.az.databricks_standard_cluster.regex, local.az.databricks_standard_cluster.name_unique)) > 0
    }
    databricks_workspace = {
      valid_name        = length(regexall(local.az.databricks_workspace.regex, local.az.databricks_workspace.name)) > 0 && length(local.az.databricks_workspace.name) > local.az.databricks_workspace.min_length
      valid_name_unique = length(regexall(local.az.databricks_workspace.regex, local.az.databricks_workspace.name_unique)) > 0
    }
    dev_test_lab = {
      valid_name        = length(regexall(local.az.dev_test_lab.regex, local.az.dev_test_lab.name)) > 0 && length(local.az.dev_test_lab.name) > local.az.dev_test_lab.min_length
      valid_name_unique = length(regexall(local.az.dev_test_lab.regex, local.az.dev_test_lab.name_unique)) > 0
    }
    dev_test_linux_virtual_machine = {
      valid_name        = length(regexall(local.az.dev_test_linux_virtual_machine.regex, local.az.dev_test_linux_virtual_machine.name)) > 0 && length(local.az.dev_test_linux_virtual_machine.name) > local.az.dev_test_linux_virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.dev_test_linux_virtual_machine.regex, local.az.dev_test_linux_virtual_machine.name_unique)) > 0
    }
    dev_test_windows_virtual_machine = {
      valid_name        = length(regexall(local.az.dev_test_windows_virtual_machine.regex, local.az.dev_test_windows_virtual_machine.name)) > 0 && length(local.az.dev_test_windows_virtual_machine.name) > local.az.dev_test_windows_virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.dev_test_windows_virtual_machine.regex, local.az.dev_test_windows_virtual_machine.name_unique)) > 0
    }
    disk_encryption_set = {
      valid_name        = length(regexall(local.az.disk_encryption_set.regex, local.az.disk_encryption_set.name)) > 0 && length(local.az.disk_encryption_set.name) > local.az.disk_encryption_set.min_length
      valid_name_unique = length(regexall(local.az.disk_encryption_set.regex, local.az.disk_encryption_set.name_unique)) > 0
    }
    dns_a_record = {
      valid_name        = length(regexall(local.az.dns_a_record.regex, local.az.dns_a_record.name)) > 0 && length(local.az.dns_a_record.name) > local.az.dns_a_record.min_length
      valid_name_unique = length(regexall(local.az.dns_a_record.regex, local.az.dns_a_record.name_unique)) > 0
    }
    dns_aaaa_record = {
      valid_name        = length(regexall(local.az.dns_aaaa_record.regex, local.az.dns_aaaa_record.name)) > 0 && length(local.az.dns_aaaa_record.name) > local.az.dns_aaaa_record.min_length
      valid_name_unique = length(regexall(local.az.dns_aaaa_record.regex, local.az.dns_aaaa_record.name_unique)) > 0
    }
    dns_caa_record = {
      valid_name        = length(regexall(local.az.dns_caa_record.regex, local.az.dns_caa_record.name)) > 0 && length(local.az.dns_caa_record.name) > local.az.dns_caa_record.min_length
      valid_name_unique = length(regexall(local.az.dns_caa_record.regex, local.az.dns_caa_record.name_unique)) > 0
    }
    dns_cname_record = {
      valid_name        = length(regexall(local.az.dns_cname_record.regex, local.az.dns_cname_record.name)) > 0 && length(local.az.dns_cname_record.name) > local.az.dns_cname_record.min_length
      valid_name_unique = length(regexall(local.az.dns_cname_record.regex, local.az.dns_cname_record.name_unique)) > 0
    }
    dns_mx_record = {
      valid_name        = length(regexall(local.az.dns_mx_record.regex, local.az.dns_mx_record.name)) > 0 && length(local.az.dns_mx_record.name) > local.az.dns_mx_record.min_length
      valid_name_unique = length(regexall(local.az.dns_mx_record.regex, local.az.dns_mx_record.name_unique)) > 0
    }
    dns_ns_record = {
      valid_name        = length(regexall(local.az.dns_ns_record.regex, local.az.dns_ns_record.name)) > 0 && length(local.az.dns_ns_record.name) > local.az.dns_ns_record.min_length
      valid_name_unique = length(regexall(local.az.dns_ns_record.regex, local.az.dns_ns_record.name_unique)) > 0
    }
    dns_ptr_record = {
      valid_name        = length(regexall(local.az.dns_ptr_record.regex, local.az.dns_ptr_record.name)) > 0 && length(local.az.dns_ptr_record.name) > local.az.dns_ptr_record.min_length
      valid_name_unique = length(regexall(local.az.dns_ptr_record.regex, local.az.dns_ptr_record.name_unique)) > 0
    }
    dns_txt_record = {
      valid_name        = length(regexall(local.az.dns_txt_record.regex, local.az.dns_txt_record.name)) > 0 && length(local.az.dns_txt_record.name) > local.az.dns_txt_record.min_length
      valid_name_unique = length(regexall(local.az.dns_txt_record.regex, local.az.dns_txt_record.name_unique)) > 0
    }
    dns_zone = {
      valid_name        = length(regexall(local.az.dns_zone.regex, local.az.dns_zone.name)) > 0 && length(local.az.dns_zone.name) > local.az.dns_zone.min_length
      valid_name_unique = length(regexall(local.az.dns_zone.regex, local.az.dns_zone.name_unique)) > 0
    }
    eventgrid_domain = {
      valid_name        = length(regexall(local.az.eventgrid_domain.regex, local.az.eventgrid_domain.name)) > 0 && length(local.az.eventgrid_domain.name) > local.az.eventgrid_domain.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_domain.regex, local.az.eventgrid_domain.name_unique)) > 0
    }
    eventgrid_domain_topic = {
      valid_name        = length(regexall(local.az.eventgrid_domain_topic.regex, local.az.eventgrid_domain_topic.name)) > 0 && length(local.az.eventgrid_domain_topic.name) > local.az.eventgrid_domain_topic.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_domain_topic.regex, local.az.eventgrid_domain_topic.name_unique)) > 0
    }
    eventgrid_event_subscription = {
      valid_name        = length(regexall(local.az.eventgrid_event_subscription.regex, local.az.eventgrid_event_subscription.name)) > 0 && length(local.az.eventgrid_event_subscription.name) > local.az.eventgrid_event_subscription.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_event_subscription.regex, local.az.eventgrid_event_subscription.name_unique)) > 0
    }
    eventgrid_topic = {
      valid_name        = length(regexall(local.az.eventgrid_topic.regex, local.az.eventgrid_topic.name)) > 0 && length(local.az.eventgrid_topic.name) > local.az.eventgrid_topic.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_topic.regex, local.az.eventgrid_topic.name_unique)) > 0
    }
    eventhub = {
      valid_name        = length(regexall(local.az.eventhub.regex, local.az.eventhub.name)) > 0 && length(local.az.eventhub.name) > local.az.eventhub.min_length
      valid_name_unique = length(regexall(local.az.eventhub.regex, local.az.eventhub.name_unique)) > 0
    }
    eventhub_authorization_rule = {
      valid_name        = length(regexall(local.az.eventhub_authorization_rule.regex, local.az.eventhub_authorization_rule.name)) > 0 && length(local.az.eventhub_authorization_rule.name) > local.az.eventhub_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.eventhub_authorization_rule.regex, local.az.eventhub_authorization_rule.name_unique)) > 0
    }
    eventhub_consumer_group = {
      valid_name        = length(regexall(local.az.eventhub_consumer_group.regex, local.az.eventhub_consumer_group.name)) > 0 && length(local.az.eventhub_consumer_group.name) > local.az.eventhub_consumer_group.min_length
      valid_name_unique = length(regexall(local.az.eventhub_consumer_group.regex, local.az.eventhub_consumer_group.name_unique)) > 0
    }
    eventhub_namespace = {
      valid_name        = length(regexall(local.az.eventhub_namespace.regex, local.az.eventhub_namespace.name)) > 0 && length(local.az.eventhub_namespace.name) > local.az.eventhub_namespace.min_length
      valid_name_unique = length(regexall(local.az.eventhub_namespace.regex, local.az.eventhub_namespace.name_unique)) > 0
    }
    eventhub_namespace_authorization_rule = {
      valid_name        = length(regexall(local.az.eventhub_namespace_authorization_rule.regex, local.az.eventhub_namespace_authorization_rule.name)) > 0 && length(local.az.eventhub_namespace_authorization_rule.name) > local.az.eventhub_namespace_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.eventhub_namespace_authorization_rule.regex, local.az.eventhub_namespace_authorization_rule.name_unique)) > 0
    }
    eventhub_namespace_disaster_recovery_config = {
      valid_name        = length(regexall(local.az.eventhub_namespace_disaster_recovery_config.regex, local.az.eventhub_namespace_disaster_recovery_config.name)) > 0 && length(local.az.eventhub_namespace_disaster_recovery_config.name) > local.az.eventhub_namespace_disaster_recovery_config.min_length
      valid_name_unique = length(regexall(local.az.eventhub_namespace_disaster_recovery_config.regex, local.az.eventhub_namespace_disaster_recovery_config.name_unique)) > 0
    }
    express_route_circuit = {
      valid_name        = length(regexall(local.az.express_route_circuit.regex, local.az.express_route_circuit.name)) > 0 && length(local.az.express_route_circuit.name) > local.az.express_route_circuit.min_length
      valid_name_unique = length(regexall(local.az.express_route_circuit.regex, local.az.express_route_circuit.name_unique)) > 0
    }
    express_route_gateway = {
      valid_name        = length(regexall(local.az.express_route_gateway.regex, local.az.express_route_gateway.name)) > 0 && length(local.az.express_route_gateway.name) > local.az.express_route_gateway.min_length
      valid_name_unique = length(regexall(local.az.express_route_gateway.regex, local.az.express_route_gateway.name_unique)) > 0
    }
    firewall = {
      valid_name        = length(regexall(local.az.firewall.regex, local.az.firewall.name)) > 0 && length(local.az.firewall.name) > local.az.firewall.min_length
      valid_name_unique = length(regexall(local.az.firewall.regex, local.az.firewall.name_unique)) > 0
    }
    firewall_application_rule_collection = {
      valid_name        = length(regexall(local.az.firewall_application_rule_collection.regex, local.az.firewall_application_rule_collection.name)) > 0 && length(local.az.firewall_application_rule_collection.name) > local.az.firewall_application_rule_collection.min_length
      valid_name_unique = length(regexall(local.az.firewall_application_rule_collection.regex, local.az.firewall_application_rule_collection.name_unique)) > 0
    }
    firewall_ip_configuration = {
      valid_name        = length(regexall(local.az.firewall_ip_configuration.regex, local.az.firewall_ip_configuration.name)) > 0 && length(local.az.firewall_ip_configuration.name) > local.az.firewall_ip_configuration.min_length
      valid_name_unique = length(regexall(local.az.firewall_ip_configuration.regex, local.az.firewall_ip_configuration.name_unique)) > 0
    }
    firewall_nat_rule_collection = {
      valid_name        = length(regexall(local.az.firewall_nat_rule_collection.regex, local.az.firewall_nat_rule_collection.name)) > 0 && length(local.az.firewall_nat_rule_collection.name) > local.az.firewall_nat_rule_collection.min_length
      valid_name_unique = length(regexall(local.az.firewall_nat_rule_collection.regex, local.az.firewall_nat_rule_collection.name_unique)) > 0
    }
    firewall_network_rule_collection = {
      valid_name        = length(regexall(local.az.firewall_network_rule_collection.regex, local.az.firewall_network_rule_collection.name)) > 0 && length(local.az.firewall_network_rule_collection.name) > local.az.firewall_network_rule_collection.min_length
      valid_name_unique = length(regexall(local.az.firewall_network_rule_collection.regex, local.az.firewall_network_rule_collection.name_unique)) > 0
    }
    firewall_policy = {
      valid_name        = length(regexall(local.az.firewall_policy.regex, local.az.firewall_policy.name)) > 0 && length(local.az.firewall_policy.name) > local.az.firewall_policy.min_length
      valid_name_unique = length(regexall(local.az.firewall_policy.regex, local.az.firewall_policy.name_unique)) > 0
    }
    firewall_policy_rule_collection_group = {
      valid_name        = length(regexall(local.az.firewall_policy_rule_collection_group.regex, local.az.firewall_policy_rule_collection_group.name)) > 0 && length(local.az.firewall_policy_rule_collection_group.name) > local.az.firewall_policy_rule_collection_group.min_length
      valid_name_unique = length(regexall(local.az.firewall_policy_rule_collection_group.regex, local.az.firewall_policy_rule_collection_group.name_unique)) > 0
    }
    frontdoor = {
      valid_name        = length(regexall(local.az.frontdoor.regex, local.az.frontdoor.name)) > 0 && length(local.az.frontdoor.name) > local.az.frontdoor.min_length
      valid_name_unique = length(regexall(local.az.frontdoor.regex, local.az.frontdoor.name_unique)) > 0
    }
    frontdoor_firewall_policy = {
      valid_name        = length(regexall(local.az.frontdoor_firewall_policy.regex, local.az.frontdoor_firewall_policy.name)) > 0 && length(local.az.frontdoor_firewall_policy.name) > local.az.frontdoor_firewall_policy.min_length
      valid_name_unique = length(regexall(local.az.frontdoor_firewall_policy.regex, local.az.frontdoor_firewall_policy.name_unique)) > 0
    }
    function_app = {
      valid_name        = length(regexall(local.az.function_app.regex, local.az.function_app.name)) > 0 && length(local.az.function_app.name) > local.az.function_app.min_length
      valid_name_unique = length(regexall(local.az.function_app.regex, local.az.function_app.name_unique)) > 0
    }
    hdinsight_hadoop_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_hadoop_cluster.regex, local.az.hdinsight_hadoop_cluster.name)) > 0 && length(local.az.hdinsight_hadoop_cluster.name) > local.az.hdinsight_hadoop_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_hadoop_cluster.regex, local.az.hdinsight_hadoop_cluster.name_unique)) > 0
    }
    hdinsight_hbase_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_hbase_cluster.regex, local.az.hdinsight_hbase_cluster.name)) > 0 && length(local.az.hdinsight_hbase_cluster.name) > local.az.hdinsight_hbase_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_hbase_cluster.regex, local.az.hdinsight_hbase_cluster.name_unique)) > 0
    }
    hdinsight_interactive_query_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_interactive_query_cluster.regex, local.az.hdinsight_interactive_query_cluster.name)) > 0 && length(local.az.hdinsight_interactive_query_cluster.name) > local.az.hdinsight_interactive_query_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_interactive_query_cluster.regex, local.az.hdinsight_interactive_query_cluster.name_unique)) > 0
    }
    hdinsight_kafka_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_kafka_cluster.regex, local.az.hdinsight_kafka_cluster.name)) > 0 && length(local.az.hdinsight_kafka_cluster.name) > local.az.hdinsight_kafka_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_kafka_cluster.regex, local.az.hdinsight_kafka_cluster.name_unique)) > 0
    }
    hdinsight_ml_services_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_ml_services_cluster.regex, local.az.hdinsight_ml_services_cluster.name)) > 0 && length(local.az.hdinsight_ml_services_cluster.name) > local.az.hdinsight_ml_services_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_ml_services_cluster.regex, local.az.hdinsight_ml_services_cluster.name_unique)) > 0
    }
    hdinsight_rserver_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_rserver_cluster.regex, local.az.hdinsight_rserver_cluster.name)) > 0 && length(local.az.hdinsight_rserver_cluster.name) > local.az.hdinsight_rserver_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_rserver_cluster.regex, local.az.hdinsight_rserver_cluster.name_unique)) > 0
    }
    hdinsight_spark_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_spark_cluster.regex, local.az.hdinsight_spark_cluster.name)) > 0 && length(local.az.hdinsight_spark_cluster.name) > local.az.hdinsight_spark_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_spark_cluster.regex, local.az.hdinsight_spark_cluster.name_unique)) > 0
    }
    hdinsight_storm_cluster = {
      valid_name        = length(regexall(local.az.hdinsight_storm_cluster.regex, local.az.hdinsight_storm_cluster.name)) > 0 && length(local.az.hdinsight_storm_cluster.name) > local.az.hdinsight_storm_cluster.min_length
      valid_name_unique = length(regexall(local.az.hdinsight_storm_cluster.regex, local.az.hdinsight_storm_cluster.name_unique)) > 0
    }
    image = {
      valid_name        = length(regexall(local.az.image.regex, local.az.image.name)) > 0 && length(local.az.image.name) > local.az.image.min_length
      valid_name_unique = length(regexall(local.az.image.regex, local.az.image.name_unique)) > 0
    }
    iotcentral_application = {
      valid_name        = length(regexall(local.az.iotcentral_application.regex, local.az.iotcentral_application.name)) > 0 && length(local.az.iotcentral_application.name) > local.az.iotcentral_application.min_length
      valid_name_unique = length(regexall(local.az.iotcentral_application.regex, local.az.iotcentral_application.name_unique)) > 0
    }
    iothub = {
      valid_name        = length(regexall(local.az.iothub.regex, local.az.iothub.name)) > 0 && length(local.az.iothub.name) > local.az.iothub.min_length
      valid_name_unique = length(regexall(local.az.iothub.regex, local.az.iothub.name_unique)) > 0
    }
    iothub_consumer_group = {
      valid_name        = length(regexall(local.az.iothub_consumer_group.regex, local.az.iothub_consumer_group.name)) > 0 && length(local.az.iothub_consumer_group.name) > local.az.iothub_consumer_group.min_length
      valid_name_unique = length(regexall(local.az.iothub_consumer_group.regex, local.az.iothub_consumer_group.name_unique)) > 0
    }
    iothub_dps = {
      valid_name        = length(regexall(local.az.iothub_dps.regex, local.az.iothub_dps.name)) > 0 && length(local.az.iothub_dps.name) > local.az.iothub_dps.min_length
      valid_name_unique = length(regexall(local.az.iothub_dps.regex, local.az.iothub_dps.name_unique)) > 0
    }
    iothub_dps_certificate = {
      valid_name        = length(regexall(local.az.iothub_dps_certificate.regex, local.az.iothub_dps_certificate.name)) > 0 && length(local.az.iothub_dps_certificate.name) > local.az.iothub_dps_certificate.min_length
      valid_name_unique = length(regexall(local.az.iothub_dps_certificate.regex, local.az.iothub_dps_certificate.name_unique)) > 0
    }
    key_vault = {
      valid_name        = length(regexall(local.az.key_vault.regex, local.az.key_vault.name)) > 0 && length(local.az.key_vault.name) > local.az.key_vault.min_length
      valid_name_unique = length(regexall(local.az.key_vault.regex, local.az.key_vault.name_unique)) > 0
    }
    key_vault_certificate = {
      valid_name        = length(regexall(local.az.key_vault_certificate.regex, local.az.key_vault_certificate.name)) > 0 && length(local.az.key_vault_certificate.name) > local.az.key_vault_certificate.min_length
      valid_name_unique = length(regexall(local.az.key_vault_certificate.regex, local.az.key_vault_certificate.name_unique)) > 0
    }
    key_vault_key = {
      valid_name        = length(regexall(local.az.key_vault_key.regex, local.az.key_vault_key.name)) > 0 && length(local.az.key_vault_key.name) > local.az.key_vault_key.min_length
      valid_name_unique = length(regexall(local.az.key_vault_key.regex, local.az.key_vault_key.name_unique)) > 0
    }
    key_vault_secret = {
      valid_name        = length(regexall(local.az.key_vault_secret.regex, local.az.key_vault_secret.name)) > 0 && length(local.az.key_vault_secret.name) > local.az.key_vault_secret.min_length
      valid_name_unique = length(regexall(local.az.key_vault_secret.regex, local.az.key_vault_secret.name_unique)) > 0
    }
    kubernetes_cluster = {
      valid_name        = length(regexall(local.az.kubernetes_cluster.regex, local.az.kubernetes_cluster.name)) > 0 && length(local.az.kubernetes_cluster.name) > local.az.kubernetes_cluster.min_length
      valid_name_unique = length(regexall(local.az.kubernetes_cluster.regex, local.az.kubernetes_cluster.name_unique)) > 0
    }
    kusto_cluster = {
      valid_name        = length(regexall(local.az.kusto_cluster.regex, local.az.kusto_cluster.name)) > 0 && length(local.az.kusto_cluster.name) > local.az.kusto_cluster.min_length
      valid_name_unique = length(regexall(local.az.kusto_cluster.regex, local.az.kusto_cluster.name_unique)) > 0
    }
    kusto_database = {
      valid_name        = length(regexall(local.az.kusto_database.regex, local.az.kusto_database.name)) > 0 && length(local.az.kusto_database.name) > local.az.kusto_database.min_length
      valid_name_unique = length(regexall(local.az.kusto_database.regex, local.az.kusto_database.name_unique)) > 0
    }
    kusto_eventhub_data_connection = {
      valid_name        = length(regexall(local.az.kusto_eventhub_data_connection.regex, local.az.kusto_eventhub_data_connection.name)) > 0 && length(local.az.kusto_eventhub_data_connection.name) > local.az.kusto_eventhub_data_connection.min_length
      valid_name_unique = length(regexall(local.az.kusto_eventhub_data_connection.regex, local.az.kusto_eventhub_data_connection.name_unique)) > 0
    }
    lb = {
      valid_name        = length(regexall(local.az.lb.regex, local.az.lb.name)) > 0 && length(local.az.lb.name) > local.az.lb.min_length
      valid_name_unique = length(regexall(local.az.lb.regex, local.az.lb.name_unique)) > 0
    }
    lb_nat_rule = {
      valid_name        = length(regexall(local.az.lb_nat_rule.regex, local.az.lb_nat_rule.name)) > 0 && length(local.az.lb_nat_rule.name) > local.az.lb_nat_rule.min_length
      valid_name_unique = length(regexall(local.az.lb_nat_rule.regex, local.az.lb_nat_rule.name_unique)) > 0
    }
    linux_virtual_machine = {
      valid_name        = length(regexall(local.az.linux_virtual_machine.regex, local.az.linux_virtual_machine.name)) > 0 && length(local.az.linux_virtual_machine.name) > local.az.linux_virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.linux_virtual_machine.regex, local.az.linux_virtual_machine.name_unique)) > 0
    }
    linux_virtual_machine_scale_set = {
      valid_name        = length(regexall(local.az.linux_virtual_machine_scale_set.regex, local.az.linux_virtual_machine_scale_set.name)) > 0 && length(local.az.linux_virtual_machine_scale_set.name) > local.az.linux_virtual_machine_scale_set.min_length
      valid_name_unique = length(regexall(local.az.linux_virtual_machine_scale_set.regex, local.az.linux_virtual_machine_scale_set.name_unique)) > 0
    }
    load_test = {
      valid_name        = length(regexall(local.az.load_test.regex, local.az.load_test.name)) > 0 && length(local.az.load_test.name) > local.az.load_test.min_length
      valid_name_unique = length(regexall(local.az.load_test.regex, local.az.load_test.name_unique)) > 0
    }
    local_network_gateway = {
      valid_name        = length(regexall(local.az.local_network_gateway.regex, local.az.local_network_gateway.name)) > 0 && length(local.az.local_network_gateway.name) > local.az.local_network_gateway.min_length
      valid_name_unique = length(regexall(local.az.local_network_gateway.regex, local.az.local_network_gateway.name_unique)) > 0
    }
    log_analytics_workspace = {
      valid_name        = length(regexall(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name)) > 0 && length(local.az.log_analytics_workspace.name) > local.az.log_analytics_workspace.min_length
      valid_name_unique = length(regexall(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name_unique)) > 0
    }
    logic_app_workflow = {
      valid_name        = length(regexall(local.az.logic_app_workflow.regex, local.az.logic_app_workflow.name)) > 0 && length(local.az.logic_app_workflow.name) > local.az.logic_app_workflow.min_length
      valid_name_unique = length(regexall(local.az.logic_app_workflow.regex, local.az.logic_app_workflow.name_unique)) > 0
    }
    machine_learning_workspace = {
      valid_name        = length(regexall(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name)) > 0 && length(local.az.machine_learning_workspace.name) > local.az.machine_learning_workspace.min_length
      valid_name_unique = length(regexall(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name_unique)) > 0
    }
    managed_disk = {
      valid_name        = length(regexall(local.az.managed_disk.regex, local.az.managed_disk.name)) > 0 && length(local.az.managed_disk.name) > local.az.managed_disk.min_length
      valid_name_unique = length(regexall(local.az.managed_disk.regex, local.az.managed_disk.name_unique)) > 0
    }
    maps_account = {
      valid_name        = length(regexall(local.az.maps_account.regex, local.az.maps_account.name)) > 0 && length(local.az.maps_account.name) > local.az.maps_account.min_length
      valid_name_unique = length(regexall(local.az.maps_account.regex, local.az.maps_account.name_unique)) > 0
    }
    mariadb_database = {
      valid_name        = length(regexall(local.az.mariadb_database.regex, local.az.mariadb_database.name)) > 0 && length(local.az.mariadb_database.name) > local.az.mariadb_database.min_length
      valid_name_unique = length(regexall(local.az.mariadb_database.regex, local.az.mariadb_database.name_unique)) > 0
    }
    mariadb_firewall_rule = {
      valid_name        = length(regexall(local.az.mariadb_firewall_rule.regex, local.az.mariadb_firewall_rule.name)) > 0 && length(local.az.mariadb_firewall_rule.name) > local.az.mariadb_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.mariadb_firewall_rule.regex, local.az.mariadb_firewall_rule.name_unique)) > 0
    }
    mariadb_server = {
      valid_name        = length(regexall(local.az.mariadb_server.regex, local.az.mariadb_server.name)) > 0 && length(local.az.mariadb_server.name) > local.az.mariadb_server.min_length
      valid_name_unique = length(regexall(local.az.mariadb_server.regex, local.az.mariadb_server.name_unique)) > 0
    }
    mariadb_virtual_network_rule = {
      valid_name        = length(regexall(local.az.mariadb_virtual_network_rule.regex, local.az.mariadb_virtual_network_rule.name)) > 0 && length(local.az.mariadb_virtual_network_rule.name) > local.az.mariadb_virtual_network_rule.min_length
      valid_name_unique = length(regexall(local.az.mariadb_virtual_network_rule.regex, local.az.mariadb_virtual_network_rule.name_unique)) > 0
    }
    monitor_action_group = {
      valid_name        = length(regexall(local.az.monitor_action_group.regex, local.az.monitor_action_group.name)) > 0 && length(local.az.monitor_action_group.name) > local.az.monitor_action_group.min_length
      valid_name_unique = length(regexall(local.az.monitor_action_group.regex, local.az.monitor_action_group.name_unique)) > 0
    }
    monitor_autoscale_setting = {
      valid_name        = length(regexall(local.az.monitor_autoscale_setting.regex, local.az.monitor_autoscale_setting.name)) > 0 && length(local.az.monitor_autoscale_setting.name) > local.az.monitor_autoscale_setting.min_length
      valid_name_unique = length(regexall(local.az.monitor_autoscale_setting.regex, local.az.monitor_autoscale_setting.name_unique)) > 0
    }
    monitor_diagnostic_setting = {
      valid_name        = length(regexall(local.az.monitor_diagnostic_setting.regex, local.az.monitor_diagnostic_setting.name)) > 0 && length(local.az.monitor_diagnostic_setting.name) > local.az.monitor_diagnostic_setting.min_length
      valid_name_unique = length(regexall(local.az.monitor_diagnostic_setting.regex, local.az.monitor_diagnostic_setting.name_unique)) > 0
    }
    monitor_scheduled_query_rules_alert = {
      valid_name        = length(regexall(local.az.monitor_scheduled_query_rules_alert.regex, local.az.monitor_scheduled_query_rules_alert.name)) > 0 && length(local.az.monitor_scheduled_query_rules_alert.name) > local.az.monitor_scheduled_query_rules_alert.min_length
      valid_name_unique = length(regexall(local.az.monitor_scheduled_query_rules_alert.regex, local.az.monitor_scheduled_query_rules_alert.name_unique)) > 0
    }
    mssql_database = {
      valid_name        = length(regexall(local.az.mssql_database.regex, local.az.mssql_database.name)) > 0 && length(local.az.mssql_database.name) > local.az.mssql_database.min_length
      valid_name_unique = length(regexall(local.az.mssql_database.regex, local.az.mssql_database.name_unique)) > 0
    }
    mssql_elasticpool = {
      valid_name        = length(regexall(local.az.mssql_elasticpool.regex, local.az.mssql_elasticpool.name)) > 0 && length(local.az.mssql_elasticpool.name) > local.az.mssql_elasticpool.min_length
      valid_name_unique = length(regexall(local.az.mssql_elasticpool.regex, local.az.mssql_elasticpool.name_unique)) > 0
    }
    mssql_managed_instance = {
      valid_name        = length(regexall(local.az.mssql_managed_instance.regex, local.az.mssql_managed_instance.name)) > 0 && length(local.az.mssql_managed_instance.name) > local.az.mssql_managed_instance.min_length
      valid_name_unique = length(regexall(local.az.mssql_managed_instance.regex, local.az.mssql_managed_instance.name_unique)) > 0
    }
    mssql_server = {
      valid_name        = length(regexall(local.az.mssql_server.regex, local.az.mssql_server.name)) > 0 && length(local.az.mssql_server.name) > local.az.mssql_server.min_length
      valid_name_unique = length(regexall(local.az.mssql_server.regex, local.az.mssql_server.name_unique)) > 0
    }
    mysql_database = {
      valid_name        = length(regexall(local.az.mysql_database.regex, local.az.mysql_database.name)) > 0 && length(local.az.mysql_database.name) > local.az.mysql_database.min_length
      valid_name_unique = length(regexall(local.az.mysql_database.regex, local.az.mysql_database.name_unique)) > 0
    }
    mysql_firewall_rule = {
      valid_name        = length(regexall(local.az.mysql_firewall_rule.regex, local.az.mysql_firewall_rule.name)) > 0 && length(local.az.mysql_firewall_rule.name) > local.az.mysql_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.mysql_firewall_rule.regex, local.az.mysql_firewall_rule.name_unique)) > 0
    }
    mysql_server = {
      valid_name        = length(regexall(local.az.mysql_server.regex, local.az.mysql_server.name)) > 0 && length(local.az.mysql_server.name) > local.az.mysql_server.min_length
      valid_name_unique = length(regexall(local.az.mysql_server.regex, local.az.mysql_server.name_unique)) > 0
    }
    mysql_virtual_network_rule = {
      valid_name        = length(regexall(local.az.mysql_virtual_network_rule.regex, local.az.mysql_virtual_network_rule.name)) > 0 && length(local.az.mysql_virtual_network_rule.name) > local.az.mysql_virtual_network_rule.min_length
      valid_name_unique = length(regexall(local.az.mysql_virtual_network_rule.regex, local.az.mysql_virtual_network_rule.name_unique)) > 0
    }
    nat_gateway = {
      valid_name        = length(regexall(local.az.nat_gateway.regex, local.az.nat_gateway.name)) > 0 && length(local.az.nat_gateway.name) > local.az.nat_gateway.min_length
      valid_name_unique = length(regexall(local.az.nat_gateway.regex, local.az.nat_gateway.name_unique)) > 0
    }
    network_ddos_protection_plan = {
      valid_name        = length(regexall(local.az.network_ddos_protection_plan.regex, local.az.network_ddos_protection_plan.name)) > 0 && length(local.az.network_ddos_protection_plan.name) > local.az.network_ddos_protection_plan.min_length
      valid_name_unique = length(regexall(local.az.network_ddos_protection_plan.regex, local.az.network_ddos_protection_plan.name_unique)) > 0
    }
    network_interface = {
      valid_name        = length(regexall(local.az.network_interface.regex, local.az.network_interface.name)) > 0 && length(local.az.network_interface.name) > local.az.network_interface.min_length
      valid_name_unique = length(regexall(local.az.network_interface.regex, local.az.network_interface.name_unique)) > 0
    }
    network_security_group = {
      valid_name        = length(regexall(local.az.network_security_group.regex, local.az.network_security_group.name)) > 0 && length(local.az.network_security_group.name) > local.az.network_security_group.min_length
      valid_name_unique = length(regexall(local.az.network_security_group.regex, local.az.network_security_group.name_unique)) > 0
    }
    network_security_group_rule = {
      valid_name        = length(regexall(local.az.network_security_group_rule.regex, local.az.network_security_group_rule.name)) > 0 && length(local.az.network_security_group_rule.name) > local.az.network_security_group_rule.min_length
      valid_name_unique = length(regexall(local.az.network_security_group_rule.regex, local.az.network_security_group_rule.name_unique)) > 0
    }
    network_security_rule = {
      valid_name        = length(regexall(local.az.network_security_rule.regex, local.az.network_security_rule.name)) > 0 && length(local.az.network_security_rule.name) > local.az.network_security_rule.min_length
      valid_name_unique = length(regexall(local.az.network_security_rule.regex, local.az.network_security_rule.name_unique)) > 0
    }
    network_watcher = {
      valid_name        = length(regexall(local.az.network_watcher.regex, local.az.network_watcher.name)) > 0 && length(local.az.network_watcher.name) > local.az.network_watcher.min_length
      valid_name_unique = length(regexall(local.az.network_watcher.regex, local.az.network_watcher.name_unique)) > 0
    }
    notification_hub = {
      valid_name        = length(regexall(local.az.notification_hub.regex, local.az.notification_hub.name)) > 0 && length(local.az.notification_hub.name) > local.az.notification_hub.min_length
      valid_name_unique = length(regexall(local.az.notification_hub.regex, local.az.notification_hub.name_unique)) > 0
    }
    notification_hub_authorization_rule = {
      valid_name        = length(regexall(local.az.notification_hub_authorization_rule.regex, local.az.notification_hub_authorization_rule.name)) > 0 && length(local.az.notification_hub_authorization_rule.name) > local.az.notification_hub_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.notification_hub_authorization_rule.regex, local.az.notification_hub_authorization_rule.name_unique)) > 0
    }
    notification_hub_namespace = {
      valid_name        = length(regexall(local.az.notification_hub_namespace.regex, local.az.notification_hub_namespace.name)) > 0 && length(local.az.notification_hub_namespace.name) > local.az.notification_hub_namespace.min_length
      valid_name_unique = length(regexall(local.az.notification_hub_namespace.regex, local.az.notification_hub_namespace.name_unique)) > 0
    }
    point_to_site_vpn_gateway = {
      valid_name        = length(regexall(local.az.point_to_site_vpn_gateway.regex, local.az.point_to_site_vpn_gateway.name)) > 0 && length(local.az.point_to_site_vpn_gateway.name) > local.az.point_to_site_vpn_gateway.min_length
      valid_name_unique = length(regexall(local.az.point_to_site_vpn_gateway.regex, local.az.point_to_site_vpn_gateway.name_unique)) > 0
    }
    postgresql_database = {
      valid_name        = length(regexall(local.az.postgresql_database.regex, local.az.postgresql_database.name)) > 0 && length(local.az.postgresql_database.name) > local.az.postgresql_database.min_length
      valid_name_unique = length(regexall(local.az.postgresql_database.regex, local.az.postgresql_database.name_unique)) > 0
    }
    postgresql_firewall_rule = {
      valid_name        = length(regexall(local.az.postgresql_firewall_rule.regex, local.az.postgresql_firewall_rule.name)) > 0 && length(local.az.postgresql_firewall_rule.name) > local.az.postgresql_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.postgresql_firewall_rule.regex, local.az.postgresql_firewall_rule.name_unique)) > 0
    }
    postgresql_server = {
      valid_name        = length(regexall(local.az.postgresql_server.regex, local.az.postgresql_server.name)) > 0 && length(local.az.postgresql_server.name) > local.az.postgresql_server.min_length
      valid_name_unique = length(regexall(local.az.postgresql_server.regex, local.az.postgresql_server.name_unique)) > 0
    }
    postgresql_virtual_network_rule = {
      valid_name        = length(regexall(local.az.postgresql_virtual_network_rule.regex, local.az.postgresql_virtual_network_rule.name)) > 0 && length(local.az.postgresql_virtual_network_rule.name) > local.az.postgresql_virtual_network_rule.min_length
      valid_name_unique = length(regexall(local.az.postgresql_virtual_network_rule.regex, local.az.postgresql_virtual_network_rule.name_unique)) > 0
    }
    powerbi_embedded = {
      valid_name        = length(regexall(local.az.powerbi_embedded.regex, local.az.powerbi_embedded.name)) > 0 && length(local.az.powerbi_embedded.name) > local.az.powerbi_embedded.min_length
      valid_name_unique = length(regexall(local.az.powerbi_embedded.regex, local.az.powerbi_embedded.name_unique)) > 0
    }
    private_dns_a_record = {
      valid_name        = length(regexall(local.az.private_dns_a_record.regex, local.az.private_dns_a_record.name)) > 0 && length(local.az.private_dns_a_record.name) > local.az.private_dns_a_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_a_record.regex, local.az.private_dns_a_record.name_unique)) > 0
    }
    private_dns_aaaa_record = {
      valid_name        = length(regexall(local.az.private_dns_aaaa_record.regex, local.az.private_dns_aaaa_record.name)) > 0 && length(local.az.private_dns_aaaa_record.name) > local.az.private_dns_aaaa_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_aaaa_record.regex, local.az.private_dns_aaaa_record.name_unique)) > 0
    }
    private_dns_cname_record = {
      valid_name        = length(regexall(local.az.private_dns_cname_record.regex, local.az.private_dns_cname_record.name)) > 0 && length(local.az.private_dns_cname_record.name) > local.az.private_dns_cname_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_cname_record.regex, local.az.private_dns_cname_record.name_unique)) > 0
    }
    private_dns_mx_record = {
      valid_name        = length(regexall(local.az.private_dns_mx_record.regex, local.az.private_dns_mx_record.name)) > 0 && length(local.az.private_dns_mx_record.name) > local.az.private_dns_mx_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_mx_record.regex, local.az.private_dns_mx_record.name_unique)) > 0
    }
    private_dns_ptr_record = {
      valid_name        = length(regexall(local.az.private_dns_ptr_record.regex, local.az.private_dns_ptr_record.name)) > 0 && length(local.az.private_dns_ptr_record.name) > local.az.private_dns_ptr_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_ptr_record.regex, local.az.private_dns_ptr_record.name_unique)) > 0
    }
    private_dns_srv_record = {
      valid_name        = length(regexall(local.az.private_dns_srv_record.regex, local.az.private_dns_srv_record.name)) > 0 && length(local.az.private_dns_srv_record.name) > local.az.private_dns_srv_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_srv_record.regex, local.az.private_dns_srv_record.name_unique)) > 0
    }
    private_dns_txt_record = {
      valid_name        = length(regexall(local.az.private_dns_txt_record.regex, local.az.private_dns_txt_record.name)) > 0 && length(local.az.private_dns_txt_record.name) > local.az.private_dns_txt_record.min_length
      valid_name_unique = length(regexall(local.az.private_dns_txt_record.regex, local.az.private_dns_txt_record.name_unique)) > 0
    }
    private_dns_zone = {
      valid_name        = length(regexall(local.az.private_dns_zone.regex, local.az.private_dns_zone.name)) > 0 && length(local.az.private_dns_zone.name) > local.az.private_dns_zone.min_length
      valid_name_unique = length(regexall(local.az.private_dns_zone.regex, local.az.private_dns_zone.name_unique)) > 0
    }
    private_dns_zone_group = {
      valid_name        = length(regexall(local.az.private_dns_zone_group.regex, local.az.private_dns_zone_group.name)) > 0 && length(local.az.private_dns_zone_group.name) > local.az.private_dns_zone_group.min_length
      valid_name_unique = length(regexall(local.az.private_dns_zone_group.regex, local.az.private_dns_zone_group.name_unique)) > 0
    }
    private_endpoint = {
      valid_name        = length(regexall(local.az.private_endpoint.regex, local.az.private_endpoint.name)) > 0 && length(local.az.private_endpoint.name) > local.az.private_endpoint.min_length
      valid_name_unique = length(regexall(local.az.private_endpoint.regex, local.az.private_endpoint.name_unique)) > 0
    }
    private_link_service = {
      valid_name        = length(regexall(local.az.private_link_service.regex, local.az.private_link_service.name)) > 0 && length(local.az.private_link_service.name) > local.az.private_link_service.min_length
      valid_name_unique = length(regexall(local.az.private_link_service.regex, local.az.private_link_service.name_unique)) > 0
    }
    private_service_connection = {
      valid_name        = length(regexall(local.az.private_service_connection.regex, local.az.private_service_connection.name)) > 0 && length(local.az.private_service_connection.name) > local.az.private_service_connection.min_length
      valid_name_unique = length(regexall(local.az.private_service_connection.regex, local.az.private_service_connection.name_unique)) > 0
    }
    proximity_placement_group = {
      valid_name        = length(regexall(local.az.proximity_placement_group.regex, local.az.proximity_placement_group.name)) > 0 && length(local.az.proximity_placement_group.name) > local.az.proximity_placement_group.min_length
      valid_name_unique = length(regexall(local.az.proximity_placement_group.regex, local.az.proximity_placement_group.name_unique)) > 0
    }
    public_ip = {
      valid_name        = length(regexall(local.az.public_ip.regex, local.az.public_ip.name)) > 0 && length(local.az.public_ip.name) > local.az.public_ip.min_length
      valid_name_unique = length(regexall(local.az.public_ip.regex, local.az.public_ip.name_unique)) > 0
    }
    public_ip_prefix = {
      valid_name        = length(regexall(local.az.public_ip_prefix.regex, local.az.public_ip_prefix.name)) > 0 && length(local.az.public_ip_prefix.name) > local.az.public_ip_prefix.min_length
      valid_name_unique = length(regexall(local.az.public_ip_prefix.regex, local.az.public_ip_prefix.name_unique)) > 0
    }
    recovery_services_vault = {
      valid_name        = length(regexall(local.az.recovery_services_vault.regex, local.az.recovery_services_vault.name)) > 0 && length(local.az.recovery_services_vault.name) > local.az.recovery_services_vault.min_length
      valid_name_unique = length(regexall(local.az.recovery_services_vault.regex, local.az.recovery_services_vault.name_unique)) > 0
    }
    redis_cache = {
      valid_name        = length(regexall(local.az.redis_cache.regex, local.az.redis_cache.name)) > 0 && length(local.az.redis_cache.name) > local.az.redis_cache.min_length
      valid_name_unique = length(regexall(local.az.redis_cache.regex, local.az.redis_cache.name_unique)) > 0
    }
    redis_firewall_rule = {
      valid_name        = length(regexall(local.az.redis_firewall_rule.regex, local.az.redis_firewall_rule.name)) > 0 && length(local.az.redis_firewall_rule.name) > local.az.redis_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.redis_firewall_rule.regex, local.az.redis_firewall_rule.name_unique)) > 0
    }
    relay_hybrid_connection = {
      valid_name        = length(regexall(local.az.relay_hybrid_connection.regex, local.az.relay_hybrid_connection.name)) > 0 && length(local.az.relay_hybrid_connection.name) > local.az.relay_hybrid_connection.min_length
      valid_name_unique = length(regexall(local.az.relay_hybrid_connection.regex, local.az.relay_hybrid_connection.name_unique)) > 0
    }
    relay_namespace = {
      valid_name        = length(regexall(local.az.relay_namespace.regex, local.az.relay_namespace.name)) > 0 && length(local.az.relay_namespace.name) > local.az.relay_namespace.min_length
      valid_name_unique = length(regexall(local.az.relay_namespace.regex, local.az.relay_namespace.name_unique)) > 0
    }
    resource_group = {
      valid_name        = length(regexall(local.az.resource_group.regex, local.az.resource_group.name)) > 0 && length(local.az.resource_group.name) > local.az.resource_group.min_length
      valid_name_unique = length(regexall(local.az.resource_group.regex, local.az.resource_group.name_unique)) > 0
    }
    role_assignment = {
      valid_name        = length(regexall(local.az.role_assignment.regex, local.az.role_assignment.name)) > 0 && length(local.az.role_assignment.name) > local.az.role_assignment.min_length
      valid_name_unique = length(regexall(local.az.role_assignment.regex, local.az.role_assignment.name_unique)) > 0
    }
    role_definition = {
      valid_name        = length(regexall(local.az.role_definition.regex, local.az.role_definition.name)) > 0 && length(local.az.role_definition.name) > local.az.role_definition.min_length
      valid_name_unique = length(regexall(local.az.role_definition.regex, local.az.role_definition.name_unique)) > 0
    }
    route = {
      valid_name        = length(regexall(local.az.route.regex, local.az.route.name)) > 0 && length(local.az.route.name) > local.az.route.min_length
      valid_name_unique = length(regexall(local.az.route.regex, local.az.route.name_unique)) > 0
    }
    route_table = {
      valid_name        = length(regexall(local.az.route_table.regex, local.az.route_table.name)) > 0 && length(local.az.route_table.name) > local.az.route_table.min_length
      valid_name_unique = length(regexall(local.az.route_table.regex, local.az.route_table.name_unique)) > 0
    }
    search_service = {
      valid_name        = length(regexall(local.az.search_service.regex, local.az.search_service.name)) > 0 && length(local.az.search_service.name) > local.az.search_service.min_length
      valid_name_unique = length(regexall(local.az.search_service.regex, local.az.search_service.name_unique)) > 0
    }
    service_fabric_cluster = {
      valid_name        = length(regexall(local.az.service_fabric_cluster.regex, local.az.service_fabric_cluster.name)) > 0 && length(local.az.service_fabric_cluster.name) > local.az.service_fabric_cluster.min_length
      valid_name_unique = length(regexall(local.az.service_fabric_cluster.regex, local.az.service_fabric_cluster.name_unique)) > 0
    }
    servicebus_namespace = {
      valid_name        = length(regexall(local.az.servicebus_namespace.regex, local.az.servicebus_namespace.name)) > 0 && length(local.az.servicebus_namespace.name) > local.az.servicebus_namespace.min_length
      valid_name_unique = length(regexall(local.az.servicebus_namespace.regex, local.az.servicebus_namespace.name_unique)) > 0
    }
    servicebus_namespace_authorization_rule = {
      valid_name        = length(regexall(local.az.servicebus_namespace_authorization_rule.regex, local.az.servicebus_namespace_authorization_rule.name)) > 0 && length(local.az.servicebus_namespace_authorization_rule.name) > local.az.servicebus_namespace_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.servicebus_namespace_authorization_rule.regex, local.az.servicebus_namespace_authorization_rule.name_unique)) > 0
    }
    servicebus_queue = {
      valid_name        = length(regexall(local.az.servicebus_queue.regex, local.az.servicebus_queue.name)) > 0 && length(local.az.servicebus_queue.name) > local.az.servicebus_queue.min_length
      valid_name_unique = length(regexall(local.az.servicebus_queue.regex, local.az.servicebus_queue.name_unique)) > 0
    }
    servicebus_queue_authorization_rule = {
      valid_name        = length(regexall(local.az.servicebus_queue_authorization_rule.regex, local.az.servicebus_queue_authorization_rule.name)) > 0 && length(local.az.servicebus_queue_authorization_rule.name) > local.az.servicebus_queue_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.servicebus_queue_authorization_rule.regex, local.az.servicebus_queue_authorization_rule.name_unique)) > 0
    }
    servicebus_subscription = {
      valid_name        = length(regexall(local.az.servicebus_subscription.regex, local.az.servicebus_subscription.name)) > 0 && length(local.az.servicebus_subscription.name) > local.az.servicebus_subscription.min_length
      valid_name_unique = length(regexall(local.az.servicebus_subscription.regex, local.az.servicebus_subscription.name_unique)) > 0
    }
    servicebus_subscription_rule = {
      valid_name        = length(regexall(local.az.servicebus_subscription_rule.regex, local.az.servicebus_subscription_rule.name)) > 0 && length(local.az.servicebus_subscription_rule.name) > local.az.servicebus_subscription_rule.min_length
      valid_name_unique = length(regexall(local.az.servicebus_subscription_rule.regex, local.az.servicebus_subscription_rule.name_unique)) > 0
    }
    servicebus_topic = {
      valid_name        = length(regexall(local.az.servicebus_topic.regex, local.az.servicebus_topic.name)) > 0 && length(local.az.servicebus_topic.name) > local.az.servicebus_topic.min_length
      valid_name_unique = length(regexall(local.az.servicebus_topic.regex, local.az.servicebus_topic.name_unique)) > 0
    }
    servicebus_topic_authorization_rule = {
      valid_name        = length(regexall(local.az.servicebus_topic_authorization_rule.regex, local.az.servicebus_topic_authorization_rule.name)) > 0 && length(local.az.servicebus_topic_authorization_rule.name) > local.az.servicebus_topic_authorization_rule.min_length
      valid_name_unique = length(regexall(local.az.servicebus_topic_authorization_rule.regex, local.az.servicebus_topic_authorization_rule.name_unique)) > 0
    }
    shared_image = {
      valid_name        = length(regexall(local.az.shared_image.regex, local.az.shared_image.name)) > 0 && length(local.az.shared_image.name) > local.az.shared_image.min_length
      valid_name_unique = length(regexall(local.az.shared_image.regex, local.az.shared_image.name_unique)) > 0
    }
    shared_image_gallery = {
      valid_name        = length(regexall(local.az.shared_image_gallery.regex, local.az.shared_image_gallery.name)) > 0 && length(local.az.shared_image_gallery.name) > local.az.shared_image_gallery.min_length
      valid_name_unique = length(regexall(local.az.shared_image_gallery.regex, local.az.shared_image_gallery.name_unique)) > 0
    }
    signalr_service = {
      valid_name        = length(regexall(local.az.signalr_service.regex, local.az.signalr_service.name)) > 0 && length(local.az.signalr_service.name) > local.az.signalr_service.min_length
      valid_name_unique = length(regexall(local.az.signalr_service.regex, local.az.signalr_service.name_unique)) > 0
    }
    snapshots = {
      valid_name        = length(regexall(local.az.snapshots.regex, local.az.snapshots.name)) > 0 && length(local.az.snapshots.name) > local.az.snapshots.min_length
      valid_name_unique = length(regexall(local.az.snapshots.regex, local.az.snapshots.name_unique)) > 0
    }
    sql_elasticpool = {
      valid_name        = length(regexall(local.az.sql_elasticpool.regex, local.az.sql_elasticpool.name)) > 0 && length(local.az.sql_elasticpool.name) > local.az.sql_elasticpool.min_length
      valid_name_unique = length(regexall(local.az.sql_elasticpool.regex, local.az.sql_elasticpool.name_unique)) > 0
    }
    sql_failover_group = {
      valid_name        = length(regexall(local.az.sql_failover_group.regex, local.az.sql_failover_group.name)) > 0 && length(local.az.sql_failover_group.name) > local.az.sql_failover_group.min_length
      valid_name_unique = length(regexall(local.az.sql_failover_group.regex, local.az.sql_failover_group.name_unique)) > 0
    }
    sql_firewall_rule = {
      valid_name        = length(regexall(local.az.sql_firewall_rule.regex, local.az.sql_firewall_rule.name)) > 0 && length(local.az.sql_firewall_rule.name) > local.az.sql_firewall_rule.min_length
      valid_name_unique = length(regexall(local.az.sql_firewall_rule.regex, local.az.sql_firewall_rule.name_unique)) > 0
    }
    sql_server = {
      valid_name        = length(regexall(local.az.sql_server.regex, local.az.sql_server.name)) > 0 && length(local.az.sql_server.name) > local.az.sql_server.min_length
      valid_name_unique = length(regexall(local.az.sql_server.regex, local.az.sql_server.name_unique)) > 0
    }
    static_web_app = {
      valid_name        = length(regexall(local.az.static_web_app.regex, local.az.static_web_app.name)) > 0 && length(local.az.static_web_app.name) > local.az.static_web_app.min_length
      valid_name_unique = length(regexall(local.az.static_web_app.regex, local.az.static_web_app.name_unique)) > 0
    }
    storage_account = {
      valid_name        = length(regexall(local.az.storage_account.regex, local.az.storage_account.name)) > 0 && length(local.az.storage_account.name) > local.az.storage_account.min_length
      valid_name_unique = length(regexall(local.az.storage_account.regex, local.az.storage_account.name_unique)) > 0
    }
    storage_blob = {
      valid_name        = length(regexall(local.az.storage_blob.regex, local.az.storage_blob.name)) > 0 && length(local.az.storage_blob.name) > local.az.storage_blob.min_length
      valid_name_unique = length(regexall(local.az.storage_blob.regex, local.az.storage_blob.name_unique)) > 0
    }
    storage_container = {
      valid_name        = length(regexall(local.az.storage_container.regex, local.az.storage_container.name)) > 0 && length(local.az.storage_container.name) > local.az.storage_container.min_length
      valid_name_unique = length(regexall(local.az.storage_container.regex, local.az.storage_container.name_unique)) > 0
    }
    storage_data_lake_gen2_filesystem = {
      valid_name        = length(regexall(local.az.storage_data_lake_gen2_filesystem.regex, local.az.storage_data_lake_gen2_filesystem.name)) > 0 && length(local.az.storage_data_lake_gen2_filesystem.name) > local.az.storage_data_lake_gen2_filesystem.min_length
      valid_name_unique = length(regexall(local.az.storage_data_lake_gen2_filesystem.regex, local.az.storage_data_lake_gen2_filesystem.name_unique)) > 0
    }
    storage_queue = {
      valid_name        = length(regexall(local.az.storage_queue.regex, local.az.storage_queue.name)) > 0 && length(local.az.storage_queue.name) > local.az.storage_queue.min_length
      valid_name_unique = length(regexall(local.az.storage_queue.regex, local.az.storage_queue.name_unique)) > 0
    }
    storage_share = {
      valid_name        = length(regexall(local.az.storage_share.regex, local.az.storage_share.name)) > 0 && length(local.az.storage_share.name) > local.az.storage_share.min_length
      valid_name_unique = length(regexall(local.az.storage_share.regex, local.az.storage_share.name_unique)) > 0
    }
    storage_share_directory = {
      valid_name        = length(regexall(local.az.storage_share_directory.regex, local.az.storage_share_directory.name)) > 0 && length(local.az.storage_share_directory.name) > local.az.storage_share_directory.min_length
      valid_name_unique = length(regexall(local.az.storage_share_directory.regex, local.az.storage_share_directory.name_unique)) > 0
    }
    storage_table = {
      valid_name        = length(regexall(local.az.storage_table.regex, local.az.storage_table.name)) > 0 && length(local.az.storage_table.name) > local.az.storage_table.min_length
      valid_name_unique = length(regexall(local.az.storage_table.regex, local.az.storage_table.name_unique)) > 0
    }
    stream_analytics_function_javascript_udf = {
      valid_name        = length(regexall(local.az.stream_analytics_function_javascript_udf.regex, local.az.stream_analytics_function_javascript_udf.name)) > 0 && length(local.az.stream_analytics_function_javascript_udf.name) > local.az.stream_analytics_function_javascript_udf.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_function_javascript_udf.regex, local.az.stream_analytics_function_javascript_udf.name_unique)) > 0
    }
    stream_analytics_job = {
      valid_name        = length(regexall(local.az.stream_analytics_job.regex, local.az.stream_analytics_job.name)) > 0 && length(local.az.stream_analytics_job.name) > local.az.stream_analytics_job.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_job.regex, local.az.stream_analytics_job.name_unique)) > 0
    }
    stream_analytics_output_blob = {
      valid_name        = length(regexall(local.az.stream_analytics_output_blob.regex, local.az.stream_analytics_output_blob.name)) > 0 && length(local.az.stream_analytics_output_blob.name) > local.az.stream_analytics_output_blob.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_output_blob.regex, local.az.stream_analytics_output_blob.name_unique)) > 0
    }
    stream_analytics_output_eventhub = {
      valid_name        = length(regexall(local.az.stream_analytics_output_eventhub.regex, local.az.stream_analytics_output_eventhub.name)) > 0 && length(local.az.stream_analytics_output_eventhub.name) > local.az.stream_analytics_output_eventhub.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_output_eventhub.regex, local.az.stream_analytics_output_eventhub.name_unique)) > 0
    }
    stream_analytics_output_mssql = {
      valid_name        = length(regexall(local.az.stream_analytics_output_mssql.regex, local.az.stream_analytics_output_mssql.name)) > 0 && length(local.az.stream_analytics_output_mssql.name) > local.az.stream_analytics_output_mssql.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_output_mssql.regex, local.az.stream_analytics_output_mssql.name_unique)) > 0
    }
    stream_analytics_output_servicebus_queue = {
      valid_name        = length(regexall(local.az.stream_analytics_output_servicebus_queue.regex, local.az.stream_analytics_output_servicebus_queue.name)) > 0 && length(local.az.stream_analytics_output_servicebus_queue.name) > local.az.stream_analytics_output_servicebus_queue.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_output_servicebus_queue.regex, local.az.stream_analytics_output_servicebus_queue.name_unique)) > 0
    }
    stream_analytics_output_servicebus_topic = {
      valid_name        = length(regexall(local.az.stream_analytics_output_servicebus_topic.regex, local.az.stream_analytics_output_servicebus_topic.name)) > 0 && length(local.az.stream_analytics_output_servicebus_topic.name) > local.az.stream_analytics_output_servicebus_topic.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_output_servicebus_topic.regex, local.az.stream_analytics_output_servicebus_topic.name_unique)) > 0
    }
    stream_analytics_reference_input_blob = {
      valid_name        = length(regexall(local.az.stream_analytics_reference_input_blob.regex, local.az.stream_analytics_reference_input_blob.name)) > 0 && length(local.az.stream_analytics_reference_input_blob.name) > local.az.stream_analytics_reference_input_blob.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_reference_input_blob.regex, local.az.stream_analytics_reference_input_blob.name_unique)) > 0
    }
    stream_analytics_stream_input_blob = {
      valid_name        = length(regexall(local.az.stream_analytics_stream_input_blob.regex, local.az.stream_analytics_stream_input_blob.name)) > 0 && length(local.az.stream_analytics_stream_input_blob.name) > local.az.stream_analytics_stream_input_blob.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_stream_input_blob.regex, local.az.stream_analytics_stream_input_blob.name_unique)) > 0
    }
    stream_analytics_stream_input_eventhub = {
      valid_name        = length(regexall(local.az.stream_analytics_stream_input_eventhub.regex, local.az.stream_analytics_stream_input_eventhub.name)) > 0 && length(local.az.stream_analytics_stream_input_eventhub.name) > local.az.stream_analytics_stream_input_eventhub.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_stream_input_eventhub.regex, local.az.stream_analytics_stream_input_eventhub.name_unique)) > 0
    }
    stream_analytics_stream_input_iothub = {
      valid_name        = length(regexall(local.az.stream_analytics_stream_input_iothub.regex, local.az.stream_analytics_stream_input_iothub.name)) > 0 && length(local.az.stream_analytics_stream_input_iothub.name) > local.az.stream_analytics_stream_input_iothub.min_length
      valid_name_unique = length(regexall(local.az.stream_analytics_stream_input_iothub.regex, local.az.stream_analytics_stream_input_iothub.name_unique)) > 0
    }
    subnet = {
      valid_name        = length(regexall(local.az.subnet.regex, local.az.subnet.name)) > 0 && length(local.az.subnet.name) > local.az.subnet.min_length
      valid_name_unique = length(regexall(local.az.subnet.regex, local.az.subnet.name_unique)) > 0
    }
    template_deployment = {
      valid_name        = length(regexall(local.az.template_deployment.regex, local.az.template_deployment.name)) > 0 && length(local.az.template_deployment.name) > local.az.template_deployment.min_length
      valid_name_unique = length(regexall(local.az.template_deployment.regex, local.az.template_deployment.name_unique)) > 0
    }
    traffic_manager_profile = {
      valid_name        = length(regexall(local.az.traffic_manager_profile.regex, local.az.traffic_manager_profile.name)) > 0 && length(local.az.traffic_manager_profile.name) > local.az.traffic_manager_profile.min_length
      valid_name_unique = length(regexall(local.az.traffic_manager_profile.regex, local.az.traffic_manager_profile.name_unique)) > 0
    }
    user_assigned_identity = {
      valid_name        = length(regexall(local.az.user_assigned_identity.regex, local.az.user_assigned_identity.name)) > 0 && length(local.az.user_assigned_identity.name) > local.az.user_assigned_identity.min_length
      valid_name_unique = length(regexall(local.az.user_assigned_identity.regex, local.az.user_assigned_identity.name_unique)) > 0
    }
    virtual_desktop_application_group = {
      valid_name        = length(regexall(local.az.virtual_desktop_application_group.regex, local.az.virtual_desktop_application_group.name)) > 0 && length(local.az.virtual_desktop_application_group.name) > local.az.virtual_desktop_application_group.min_length
      valid_name_unique = length(regexall(local.az.virtual_desktop_application_group.regex, local.az.virtual_desktop_application_group.name_unique)) > 0
    }
    virtual_desktop_host_pool = {
      valid_name        = length(regexall(local.az.virtual_desktop_host_pool.regex, local.az.virtual_desktop_host_pool.name)) > 0 && length(local.az.virtual_desktop_host_pool.name) > local.az.virtual_desktop_host_pool.min_length
      valid_name_unique = length(regexall(local.az.virtual_desktop_host_pool.regex, local.az.virtual_desktop_host_pool.name_unique)) > 0
    }
    virtual_desktop_scaling_plan = {
      valid_name        = length(regexall(local.az.virtual_desktop_scaling_plan.regex, local.az.virtual_desktop_scaling_plan.name)) > 0 && length(local.az.virtual_desktop_scaling_plan.name) > local.az.virtual_desktop_scaling_plan.min_length
      valid_name_unique = length(regexall(local.az.virtual_desktop_scaling_plan.regex, local.az.virtual_desktop_scaling_plan.name_unique)) > 0
    }
    virtual_desktop_workspace = {
      valid_name        = length(regexall(local.az.virtual_desktop_workspace.regex, local.az.virtual_desktop_workspace.name)) > 0 && length(local.az.virtual_desktop_workspace.name) > local.az.virtual_desktop_workspace.min_length
      valid_name_unique = length(regexall(local.az.virtual_desktop_workspace.regex, local.az.virtual_desktop_workspace.name_unique)) > 0
    }
    virtual_machine = {
      valid_name        = length(regexall(local.az.virtual_machine.regex, local.az.virtual_machine.name)) > 0 && length(local.az.virtual_machine.name) > local.az.virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine.regex, local.az.virtual_machine.name_unique)) > 0
    }
    virtual_machine_extension = {
      valid_name        = length(regexall(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name)) > 0 && length(local.az.virtual_machine_extension.name) > local.az.virtual_machine_extension.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name_unique)) > 0
    }
    virtual_machine_scale_set = {
      valid_name        = length(regexall(local.az.virtual_machine_scale_set.regex, local.az.virtual_machine_scale_set.name)) > 0 && length(local.az.virtual_machine_scale_set.name) > local.az.virtual_machine_scale_set.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine_scale_set.regex, local.az.virtual_machine_scale_set.name_unique)) > 0
    }
    virtual_machine_scale_set_extension = {
      valid_name        = length(regexall(local.az.virtual_machine_scale_set_extension.regex, local.az.virtual_machine_scale_set_extension.name)) > 0 && length(local.az.virtual_machine_scale_set_extension.name) > local.az.virtual_machine_scale_set_extension.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine_scale_set_extension.regex, local.az.virtual_machine_scale_set_extension.name_unique)) > 0
    }
    virtual_network = {
      valid_name        = length(regexall(local.az.virtual_network.regex, local.az.virtual_network.name)) > 0 && length(local.az.virtual_network.name) > local.az.virtual_network.min_length
      valid_name_unique = length(regexall(local.az.virtual_network.regex, local.az.virtual_network.name_unique)) > 0
    }
    virtual_network_gateway = {
      valid_name        = length(regexall(local.az.virtual_network_gateway.regex, local.az.virtual_network_gateway.name)) > 0 && length(local.az.virtual_network_gateway.name) > local.az.virtual_network_gateway.min_length
      valid_name_unique = length(regexall(local.az.virtual_network_gateway.regex, local.az.virtual_network_gateway.name_unique)) > 0
    }
    virtual_network_gateway_connection = {
      valid_name        = length(regexall(local.az.virtual_network_gateway_connection.regex, local.az.virtual_network_gateway_connection.name)) > 0 && length(local.az.virtual_network_gateway_connection.name) > local.az.virtual_network_gateway_connection.min_length
      valid_name_unique = length(regexall(local.az.virtual_network_gateway_connection.regex, local.az.virtual_network_gateway_connection.name_unique)) > 0
    }
    virtual_network_peering = {
      valid_name        = length(regexall(local.az.virtual_network_peering.regex, local.az.virtual_network_peering.name)) > 0 && length(local.az.virtual_network_peering.name) > local.az.virtual_network_peering.min_length
      valid_name_unique = length(regexall(local.az.virtual_network_peering.regex, local.az.virtual_network_peering.name_unique)) > 0
    }
    virtual_wan = {
      valid_name        = length(regexall(local.az.virtual_wan.regex, local.az.virtual_wan.name)) > 0 && length(local.az.virtual_wan.name) > local.az.virtual_wan.min_length
      valid_name_unique = length(regexall(local.az.virtual_wan.regex, local.az.virtual_wan.name_unique)) > 0
    }
    windows_virtual_machine = {
      valid_name        = length(regexall(local.az.windows_virtual_machine.regex, local.az.windows_virtual_machine.name)) > 0 && length(local.az.windows_virtual_machine.name) > local.az.windows_virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.windows_virtual_machine.regex, local.az.windows_virtual_machine.name_unique)) > 0
    }
    windows_virtual_machine_scale_set = {
      valid_name        = length(regexall(local.az.windows_virtual_machine_scale_set.regex, local.az.windows_virtual_machine_scale_set.name)) > 0 && length(local.az.windows_virtual_machine_scale_set.name) > local.az.windows_virtual_machine_scale_set.min_length
      valid_name_unique = length(regexall(local.az.windows_virtual_machine_scale_set.regex, local.az.windows_virtual_machine_scale_set.name_unique)) > 0
    }
  }
}
