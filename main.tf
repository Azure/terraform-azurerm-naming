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
  // Names based in the recomendations of
  // https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
  az = {
    analysis_services_server = {
      name        = substr(join("", compact([local.prefix_safe, "as", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", compact([local.prefix_safe, "as", local.suffix_unique_safe])), 0, 63)
      dashes      = false
      slug        = "as"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z][a-z0-9]+$"
      separator   = ""
    }
    api_management = {
      name        = substr(join("-", compact([local.prefix, "apim", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "apim", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "apim"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]+$"
      separator   = "-"
    }
    app_configuration = {
      name        = substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "appcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "appcg"
      min_length  = 5
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_-]+$"
      separator   = "-"
    }
    app_service = {
      name        = substr(join("-", compact([local.prefix, "app", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.prefix, "app", local.suffix_unique])), 0, 60)
      dashes      = true
      slug        = "app"
      min_length  = 2
      max_length  = 60
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]"
      separator   = "-"
    }
    app_service_environment = {
      name        = substr(join("-", compact([local.prefix, "ase", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.prefix, "ase", local.suffix_unique])), 0, 40)
      dashes      = true
      slug        = "ase"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    app_service_plan = {
      name        = substr(join("-", compact([local.prefix, "plan", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.prefix, "plan", local.suffix_unique])), 0, 40)
      dashes      = true
      slug        = "plan"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    application_gateway = {
      name        = substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "agw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "agw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    application_insights = {
      name        = substr(join("-", compact([local.prefix, "appi", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "appi", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "appi"
      min_length  = 10
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^%\\&?/]+$"
      separator   = "-"
    }
    application_security_group = {
      name        = substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "asg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "asg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    automation_account = {
      name        = substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "aa", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "aa"
      min_length  = 6
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    automation_certificate = {
      name        = substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aacert", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aacert"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    automation_credential = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aacred", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    automation_runbook = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "aacred", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+$"
      separator   = "-"
    }
    automation_schedule = {
      name        = substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aasched", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aasched"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    automation_variable = {
      name        = substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aavar", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aavar"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    availability_set = {
      name        = substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "avail", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "avail"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    backup_policy_vm = {
      name        = substr(join("-", compact([local.prefix, "bkpol", local.suffix])), 0, 150)
      name_unique = substr(join("-", compact([local.prefix, "bkpol", local.suffix_unique])), 0, 150)
      dashes      = true
      slug        = "bkpol"
      min_length  = 3
      max_length  = 150
      scope       = "parent"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    bastion_host = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snap", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    batch_account = {
      name        = substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "ba", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "ba"
      min_length  = 3
      max_length  = 24
      scope       = "region"
      regex       = "^[a-z0-9]+$"
      separator   = ""
    }
    batch_application = {
      name        = substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "baapp", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "baapp"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"
      separator   = "-"
    }
    batch_certificate = {
      name        = substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, 45)
      name_unique = substr(join("-", compact([local.prefix, "bacert", local.suffix_unique])), 0, 45)
      dashes      = true
      slug        = "bacert"
      min_length  = 5
      max_length  = 45
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"
      separator   = "-"
    }
    batch_pool = {
      name        = substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, 24)
      name_unique = substr(join("-", compact([local.prefix, "bapool", local.suffix_unique])), 0, 24)
      dashes      = true
      slug        = "bapool"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "^[a-zA-Z0-9_-]+$"
      separator   = "-"
    }
    bot_channel_directline = {
      name        = substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botline", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botline"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_channel_email = {
      name        = substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botmail", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botmail"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_channel_ms_teams = {
      name        = substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botteams", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botteams"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_channel_slack = {
      name        = substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botslack", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botslack"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_channels_registration = {
      name        = substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botchan", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botchan"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_connection = {
      name        = substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botcon", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botcon"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    bot_web_app = {
      name        = substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "bot", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "bot"
      min_length  = 2
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    cdn_endpoint = {
      name        = substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "cdn", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "cdn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_frontdoor_endpoint = {
      name        = substr(join("-", compact([local.prefix, "fde", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "fde", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "fde"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_frontdoor_origin = {
      name        = substr(join("-", compact([local.prefix, "cdno", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "cdno", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "cdno"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_frontdoor_origin_group = {
      name        = substr(join("-", compact([local.prefix, "cdnog", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "cdnog", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "cdnog"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_frontdoor_profile = {
      name        = substr(join("-", compact([local.prefix, "afd", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "afd", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "afd"
      min_length  = 5
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_frontdoor_route = {
      name        = substr(join("-", compact([local.prefix, "cdnr", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "cdnr", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "cdnr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cdn_profile = {
      name        = substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "cdnprof", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "cdnprof"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    cognitive_account = {
      name        = substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "cog", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "cog"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
      separator   = "-"
    }
    communication_service = {
      name        = substr(join("-", compact([local.prefix, "acs", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "acs", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "acs"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    container_app = {
      name        = substr(join("-", compact([local.prefix, "ca", local.suffix])), 0, 32)
      name_unique = substr(join("-", compact([local.prefix, "ca", local.suffix_unique])), 0, 32)
      dashes      = true
      slug        = "ca"
      min_length  = 1
      max_length  = 32
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    container_app_environment = {
      name        = substr(join("-", compact([local.prefix, "cae", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.prefix, "cae", local.suffix_unique])), 0, 60)
      dashes      = true
      slug        = "cae"
      min_length  = 1
      max_length  = 60
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    container_app_job = {
      name        = substr(join("-", compact([local.prefix, "caj", local.suffix])), 0, 32)
      name_unique = substr(join("-", compact([local.prefix, "caj", local.suffix_unique])), 0, 32)
      dashes      = true
      slug        = "caj"
      min_length  = 2
      max_length  = 32
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    container_group = {
      name        = substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "cg", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "cg"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    container_registry = {
      name        = substr(join("", compact([local.prefix_safe, "acr", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", compact([local.prefix_safe, "acr", local.suffix_unique_safe])), 0, 63)
      dashes      = false
      slug        = "acr"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9]+$"
      separator   = ""
    }
    container_registry_webhook = {
      name        = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_unique_safe])), 0, 50)
      dashes      = false
      slug        = "crwh"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9]+$"
      separator   = ""
    }
    cosmosdb_account = {
      name        = substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "cosmos", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "cosmos"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_cassandra = {
      name        = substr(join("-", compact([local.prefix, "coscas", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "coscas", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "coscas"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_cassandra_cluster = {
      name        = substr(join("-", compact([local.prefix, "mcc", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "mcc", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "mcc"
      min_length  = 1
      max_length  = 44
      scope       = "parent"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_cassandra_datacenter = {
      name        = substr(join("-", compact([local.prefix, "mcdc", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "mcdc", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "mcdc"
      min_length  = 1
      max_length  = 44
      scope       = "parent"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_gremlin = {
      name        = substr(join("-", compact([local.prefix, "cosgrm", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "cosgrm", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "cosgrm"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_mongodb = {
      name        = substr(join("-", compact([local.prefix, "cosmon", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "cosmon", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "cosmon"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_nosql = {
      name        = substr(join("-", compact([local.prefix, "cosno", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "cosno", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "cosno"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_postgres = {
      name        = substr(join("-", compact([local.prefix, "cospos", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "cospos", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "cospos"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    cosmosdb_tables = {
      name        = substr(join("-", compact([local.prefix, "costab", local.suffix])), 0, 44)
      name_unique = substr(join("-", compact([local.prefix, "costab", local.suffix_unique])), 0, 44)
      dashes      = true
      slug        = "costab"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
      separator   = "-"
    }
    custom_provider = {
      name        = substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "prov", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "prov"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^&%?\\/]+[^&%.?\\/ ]$"
      separator   = "-"
    }
    dashboard = {
      name        = substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, 160)
      name_unique = substr(join("-", compact([local.prefix, "dsb", local.suffix_unique])), 0, 160)
      dashes      = true
      slug        = "dsb"
      min_length  = 3
      max_length  = 160
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    dashboard_grafana = {
      name        = substr(join("-", compact([local.prefix, "amg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "amg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "amg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    data_factory = {
      name        = substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "adf", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "adf"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_dataset_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfmysql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_dataset_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfpsql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_dataset_sql_server_table = {
      name        = substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfmssql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_integration_runtime_managed = {
      name        = substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "adfir", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "adfir"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_linked_service_data_lake_storage_gen2 = {
      name        = substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvst", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvst"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_factory_linked_service_key_vault = {
      name        = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvkv"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_factory_linked_service_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_factory_linked_service_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_factory_linked_service_sql_server = {
      name        = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_factory_pipeline = {
      name        = substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfpl", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfpl"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    data_factory_trigger_schedule = {
      name        = substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adftg", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adftg"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
      separator   = "-"
    }
    data_lake_analytics_account = {
      name        = substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "dla", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "dla"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-z0-9]+$"
      separator   = ""
    }
    data_lake_analytics_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dlfw", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dlfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-z0-9-_]+$"
      separator   = "-"
    }
    data_lake_store = {
      name        = substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "dls", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "dls"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "^[a-z0-9]+$"
      separator   = ""
    }
    data_lake_store_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dlsfw", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dlsfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    data_protection_backup_vault = {
      name        = substr(join("-", compact([local.prefix, "bvault", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "bvault", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "bvault"
      min_length  = 2
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    database_migration_project = {
      name        = substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, 57)
      name_unique = substr(join("-", compact([local.prefix, "migr", local.suffix_unique])), 0, 57)
      dashes      = true
      slug        = "migr"
      min_length  = 2
      max_length  = 57
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    database_migration_service = {
      name        = substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, 62)
      name_unique = substr(join("-", compact([local.prefix, "dms", local.suffix_unique])), 0, 62)
      dashes      = true
      slug        = "dms"
      min_length  = 2
      max_length  = 62
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
      separator   = "-"
    }
    databricks_access_connector = {
      name        = substr(join("-", compact([local.prefix, "dbac", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbac", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbac"
      min_length  = 3
      max_length  = 30
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    databricks_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbc", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbc", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    databricks_high_concurrency_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbhcc", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbhcc", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbhcc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    databricks_standard_cluster = {
      name        = substr(join("-", compact([local.prefix, "dbsc", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbsc", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbsc"
      min_length  = 3
      max_length  = 30
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    databricks_workspace = {
      name        = substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbw", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbw"
      min_length  = 3
      max_length  = 30
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    dev_test_lab = {
      name        = substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "lab", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "lab"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    dev_test_linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "labvm", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    dev_test_windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "labvm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 15
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    disk_encryption_set = {
      name        = substr(join("-", compact([local.prefix, "des", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "des", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "des"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_]+$"
      separator   = "-"
    }
    dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_caa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_ns_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_private_resolver = {
      name        = substr(join("-", compact([local.prefix, "dnspr", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnspr", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnspr"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    dns_zone = {
      name        = substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "dns", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "dns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    eventgrid_domain = {
      name        = substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egd", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egd"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventgrid_domain_topic = {
      name        = substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egdt", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egdt"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventgrid_event_subscription = {
      name        = substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "egs", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "egs"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventgrid_namespace = {
      name        = substr(join("-", compact([local.prefix, "evgns", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "evgns", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "evgns"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventgrid_system_topic = {
      name        = substr(join("-", compact([local.prefix, "egst", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egst", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egst"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventgrid_topic = {
      name        = substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egt", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egt"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    eventhub = {
      name        = substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "evh", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "evh"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_cluster = {
      name        = substr(join("-", compact([local.prefix, "evhcl", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "evhcl", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "evhcl"
      min_length  = 6
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_namespace = {
      name        = substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehn", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehnar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehnar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    eventhub_namespace_disaster_recovery_config = {
      name        = substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehdr", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehdr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    express_route_circuit = {
      name        = substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "erc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "erc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    express_route_gateway = {
      name        = substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ergw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ergw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    fabric_capacity = {
      name        = substr(join("", compact([local.prefix_safe, "fc", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", compact([local.prefix_safe, "fc", local.suffix_unique_safe])), 0, 63)
      dashes      = false
      slug        = "fc"
      min_length  = 3
      max_length  = 63
      scope       = "region"
      regex       = "^[a-z][a-z0-9]+$"
      separator   = ""
    }
    firewall = {
      name        = substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_application_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwapp", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwapp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_ip_configuration = {
      name        = substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwipconf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwipconf"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_nat_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwnatrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_network_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwnetrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "afwp", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "afwp", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "afwp"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    firewall_policy_rule_collection_group = {
      name        = substr(join("-", compact([local.prefix, "fwprcg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwprcg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwprcg"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    frontdoor = {
      name        = substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "fd", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "fd"
      min_length  = 5
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    frontdoor_firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fdfw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fdfw"
      min_length  = 1
      max_length  = 80
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    function_app = {
      name        = substr(join("-", compact([local.prefix, "func", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.prefix, "func", local.suffix_unique])), 0, 60)
      dashes      = true
      slug        = "func"
      min_length  = 2
      max_length  = 60
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_hadoop_cluster = {
      name        = substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "hadoop", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "hadoop"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_hbase_cluster = {
      name        = substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "hbase", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "hbase"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_interactive_query_cluster = {
      name        = substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "iqr", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "iqr"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_kafka_cluster = {
      name        = substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "kafka", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "kafka"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_ml_services_cluster = {
      name        = substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "mls", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "mls"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_rserver_cluster = {
      name        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "rsv", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "rsv"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_spark_cluster = {
      name        = substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "spark", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "spark"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    hdinsight_storm_cluster = {
      name        = substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "storm", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "storm"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    image = {
      name        = substr(join("-", compact([local.prefix, "img", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "img", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "img"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    iotcentral_application = {
      name        = substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "iotapp", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "iotapp"
      min_length  = 2
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    iothub = {
      name        = substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "iot", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "iot"
      min_length  = 3
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    iothub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "iotcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "iotcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-._]+$"
      separator   = "-"
    }
    iothub_dps = {
      name        = substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dps", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dps"
      min_length  = 3
      max_length  = 64
      scope       = "resoureceGroup"
      regex       = "^[a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    iothub_dps_certificate = {
      name        = substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dpscert", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dpscert"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-._]+$"
      separator   = "-"
    }
    ip_group = {
      name        = substr(join("-", compact([local.prefix, "ipg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ipg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ipg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    key_vault = {
      name        = substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, 24)
      name_unique = substr(join("-", compact([local.prefix, "kv", local.suffix_unique])), 0, 24)
      dashes      = true
      slug        = "kv"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    key_vault_certificate = {
      name        = substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvc", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvc"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    key_vault_key = {
      name        = substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvk", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvk"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    key_vault_secret = {
      name        = substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvs", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvs"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-]+$"
      separator   = "-"
    }
    kubernetes_cluster = {
      name        = substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "aks", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "aks"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    kusto_cluster = {
      name        = substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, 22)
      name_unique = substr(join("", compact([local.prefix_safe, "kc", local.suffix_unique_safe])), 0, 22)
      dashes      = false
      slug        = "kc"
      min_length  = 4
      max_length  = 22
      scope       = "global"
      regex       = "^[a-z][a-z0-9]+$"
      separator   = ""
    }
    kusto_database = {
      name        = substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "kdb", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "kdb"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9- .]+$"
      separator   = "-"
    }
    kusto_eventhub_data_connection = {
      name        = substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.prefix, "kehc", local.suffix_unique])), 0, 40)
      dashes      = true
      slug        = "kehc"
      min_length  = 1
      max_length  = 40
      scope       = "parent"
      regex       = "^[a-zA-Z0-9- .]+$"
      separator   = "-"
    }
    lb = {
      name        = substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lb", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lb"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    lb_nat_rule = {
      name        = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lbnatrl"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    lb_rule = {
      name        = substr(join("-", compact([local.prefix, "rule", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rule", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rule"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
    }
    linux_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
    }
    load_test = {
      name        = substr(join("-", compact([local.prefix, "lt", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "lt", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "lt"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9|]$"
      separator   = "-"
    }
    local_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lgw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    log_analytics_query_pack = {
      name        = substr(join("-", compact([local.prefix, "pack", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pack", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pack"
      min_length  = 4
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    log_analytics_workspace = {
      name        = substr(join("-", compact([local.prefix, "log", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "log", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "log"
      min_length  = 4
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    logic_app_integration_account = {
      name        = substr(join("-", compact([local.prefix, "ia", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ia", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ia"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._()]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    logic_app_workflow = {
      name        = substr(join("-", compact([local.prefix, "logic", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "logic", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "logic"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    machine_learning_registry = {
      name        = substr(join("-", compact([local.prefix, "mlr", local.suffix])), 0, 33)
      name_unique = substr(join("-", compact([local.prefix, "mlr", local.suffix_unique])), 0, 33)
      dashes      = true
      slug        = "mlr"
      min_length  = 3
      max_length  = 33
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
      separator   = "-"
    }
    machine_learning_workspace = {
      name        = substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "mlw", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "mlw"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    maintenance_configuration = {
      name        = substr(join("-", compact([local.prefix, "mc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "mc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "mc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    managed_disk = {
      name        = substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dsk", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dsk"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9_]+$"
      separator   = "-"
    }
    management_group = {
      name        = substr(join("-", compact([local.prefix, "mg", local.suffix])), 0, 90)
      name_unique = substr(join("-", compact([local.prefix, "mg", local.suffix_unique])), 0, 90)
      dashes      = true
      slug        = "mg"
      min_length  = 1
      max_length  = 90
      scope       = "tenant"
      regex       = "^[a-zA-Z0-9-_().]+$"
      separator   = "-"
    }
    maps_account = {
      name        = substr(join("-", compact([local.prefix, "map", local.suffix])), 0, 98)
      name_unique = substr(join("-", compact([local.prefix, "map", local.suffix_unique])), 0, 98)
      dashes      = true
      slug        = "map"
      min_length  = 1
      max_length  = 98
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
      separator   = "-"
    }
    mariadb_database = {
      name        = substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mariadb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mariadb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    mariadb_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mariafw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mariafw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    mariadb_server = {
      name        = substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "maria", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "maria"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    mariadb_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mariavn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mariavn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    monitor_action_group = {
      name        = substr(join("-", compact([local.prefix, "mag", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "mag", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "mag"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^%&?\\+\\/]+[^^%&?\\+\\/ ]$"
      separator   = "-"
    }
    monitor_alert_processing_rule_action_group = {
      name        = substr(join("-", compact([local.prefix, "apr", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "apr", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "apr"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^<>*{}%&:\\?+/#|]+[^<>*{}%&:\\?+/#| ]$"
      separator   = "-"
    }
    monitor_autoscale_setting = {
      name        = substr(join("-", compact([local.prefix, "mas", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "mas", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "mas"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^<>%&#.,?\\+\\/]+[^<>%&#.,?\\+\\/ ]$"
      separator   = "-"
    }
    monitor_data_collection_endpoint = {
      name        = substr(join("-", compact([local.prefix, "dce", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dce", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dce"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    monitor_data_collection_rule = {
      name        = substr(join("-", compact([local.prefix, "dcr", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dcr", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dcr"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    monitor_diagnostic_setting = {
      name        = substr(join("-", compact([local.prefix, "mds", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "mds", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "mds"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^*<>%:&?\\+\\/]+[^*<>%:&?\\+\\/ ]$"
      separator   = "-"
    }
    monitor_scheduled_query_rules_alert = {
      name        = substr(join("-", compact([local.prefix, "msqa", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "msqa", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "msqa"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "^[^*<>%:{}&#.,?\\+\\/]+[^*<>%:{}&#.,?\\+\\/ ]$"
      separator   = "-"
    }
    mssql_database = {
      name        = substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqldb", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqldb"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    mssql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlep", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    mssql_job_agent = {
      name        = substr(join("-", compact([local.prefix, "sqlja", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlja", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlja"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    mssql_managed_instance = {
      name        = substr(join("-", compact([local.prefix, "sqlmi", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sqlmi", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sqlmi"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    mssql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    mysql_database = {
      name        = substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mysqldb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mysqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    mysql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mysqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    mysql_server = {
      name        = substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mysql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mysql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    mysql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mysqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    nat_gateway = {
      name        = substr(join("-", compact([local.prefix, "ng", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ng", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ng"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_ddos_protection_plan = {
      name        = substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ddospp", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ddospp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_interface = {
      name        = substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nic", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nic"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_manager = {
      name        = substr(join("-", compact([local.prefix, "vnm", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vnm", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vnm"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_security_group = {
      name        = substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_security_group_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsgr", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_security_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsgr", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    network_watcher = {
      name        = substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    notification_hub = {
      name        = substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "nh", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "nh"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
      separator   = "-"
    }
    notification_hub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 256)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 256)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
      separator   = "-"
    }
    notification_hub_namespace = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    point_to_site_vpn_gateway = {
      name        = substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vpngw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vpngw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    policy_definition = {
      name        = substr(join("-", compact([local.prefix, "pdef", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "pdef", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "pdef"
      min_length  = 1
      max_length  = 128
      scope       = "tenant"
      regex       = "^[^<>*%&:?./+]+[^<>*%&:?./+ ]$"
      separator   = "-"
    }
    postgresql_database = {
      name        = substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "psqldb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "psqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    postgresql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "psqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "psqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    postgresql_server = {
      name        = substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "psql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    postgresql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "psqlvn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "psqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    powerbi_embedded = {
      name        = substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pbi", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pbi"
      min_length  = 3
      max_length  = 63
      scope       = "region"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
      separator   = "-"
    }
    private_dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_srv_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_zone = {
      name        = substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pdns", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pdns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_dns_zone_group = {
      name        = substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnszg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnszg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_endpoint = {
      name        = substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pe", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pe"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_link_service = {
      name        = substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pls", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pls"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    private_service_connection = {
      name        = substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "psc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "psc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    proximity_placement_group = {
      name        = substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ppg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ppg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    public_ip = {
      name        = substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pip", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pip"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    public_ip_prefix = {
      name        = substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pippf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pippf"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    purview_account = {
      name        = substr(join("-", compact([local.prefix, "pview", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pview", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pview"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    recovery_services_vault = {
      name        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "rsv", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "rsv"
      min_length  = 2
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    redhat_openshift_cluster = {
      name        = substr(join("-", compact([local.prefix, "aro", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "aro", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "aro"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    redis_cache = {
      name        = substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "redis", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "redis"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    redis_firewall_rule = {
      name        = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, 256)
      name_unique = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_unique_safe])), 0, 256)
      dashes      = false
      slug        = "redisfw"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "^[a-zA-Z0-9]+$"
      separator   = ""
    }
    relay_hybrid_connection = {
      name        = substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "rlhc", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "rlhc"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    relay_namespace = {
      name        = substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "rln", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "rln"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    resource_group = {
      name        = substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, 90)
      name_unique = substr(join("-", compact([local.prefix, "rg", local.suffix_unique])), 0, 90)
      dashes      = true
      slug        = "rg"
      min_length  = 1
      max_length  = 90
      scope       = "subscription"
      regex       = "^[a-zA-Z0-9-._\\(\\)]+[a-zA-Z0-9-_\\(\\)]$"
      separator   = "-"
    }
    resource_group_template_deployment = {
      name        = substr(join("-", compact([local.prefix, "ts", local.suffix])), 0, 90)
      name_unique = substr(join("-", compact([local.prefix, "ts", local.suffix_unique])), 0, 90)
      dashes      = true
      slug        = "ts"
      min_length  = 1
      max_length  = 90
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-._()]+$"
      separator   = "-"
    }
    role_assignment = {
      name        = substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "ra", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "ra"
      min_length  = 1
      max_length  = 64
      scope       = "assignment"
      regex       = "^[^%]+[^ %.]$"
      separator   = "-"
    }
    role_definition = {
      name        = substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "rd", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "rd"
      min_length  = 1
      max_length  = 64
      scope       = "definition"
      regex       = "^[^%]+[^ %.]$"
      separator   = "-"
    }
    route = {
      name        = substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rt", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rt"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    route_filter = {
      name        = substr(join("-", compact([local.prefix, "rf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rf"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    route_server = {
      name        = substr(join("-", compact([local.prefix, "rtserv", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rtserv", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rtserv"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    route_table = {
      name        = substr(join("-", compact([local.prefix, "route", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "route", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "route"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    search_service = {
      name        = substr(join("-", compact([local.prefix, "srch", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "srch", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "srch"
      min_length  = 2
      max_length  = 64
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
      separator   = "-"
    }
    service_fabric_cluster = {
      name        = substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, 23)
      name_unique = substr(join("-", compact([local.prefix, "sf", local.suffix_unique])), 0, 23)
      dashes      = true
      slug        = "sf"
      min_length  = 4
      max_length  = 23
      scope       = "region"
      regex       = "^[a-z][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    servicebus_namespace = {
      name        = substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sb", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sb"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "sbq", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "sbq"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    servicebus_queue_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbqar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbqar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_subscription = {
      name        = substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbs", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbs"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_subscription_rule = {
      name        = substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbsr", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbsr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "sbt", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "sbt"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    servicebus_topic_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    shared_image = {
      name        = substr(join("-", compact([local.prefix, "si", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "si", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "si"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    shared_image_gallery = {
      name        = substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, 80)
      name_unique = substr(join("", compact([local.prefix_safe, "sig", local.suffix_unique_safe])), 0, 80)
      dashes      = false
      slug        = "sig"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9.]+[a-zA-Z0-9]$"
      separator   = ""
    }
    signalr_service = {
      name        = substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sgnlr", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sgnlr"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    snapshots = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snap", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    sql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlep", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
      separator   = "-"
    }
    sql_failover_group = {
      name        = substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sqlfg", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sqlfg"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    sql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "^[^<>*%:?\\+\\/]+[^<>*%:.?\\+\\/]$"
      separator   = "-"
    }
    sql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    ssh_public_key = {
      name        = substr(join("-", compact([local.prefix, "sshkey", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "sshkey", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "sshkey"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    static_web_app = {
      name        = substr(join("-", compact([local.prefix, "stapp", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.prefix, "stapp", local.suffix_unique])), 0, 40)
      dashes      = true
      slug        = "stapp"
      min_length  = 1
      max_length  = 40
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
      separator   = "-"
    }
    storage_account = {
      name        = substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "st", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "st"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-z0-9]+$"
      separator   = ""
    }
    storage_blob = {
      name        = substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, 1024)
      name_unique = substr(join("-", compact([local.prefix, "blob", local.suffix_unique])), 0, 1024)
      dashes      = true
      slug        = "blob"
      min_length  = 1
      max_length  = 1024
      scope       = "parent"
      regex       = "^[^\\s\\/$#&]+$"
      separator   = "-"
    }
    storage_container = {
      name        = substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stct", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stct"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+$"
      separator   = "-"
    }
    storage_data_lake_gen2_filesystem = {
      name        = substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stdl", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stdl"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    storage_queue = {
      name        = substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stq", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    storage_share = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sts", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    storage_share_directory = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sts", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    storage_table = {
      name        = substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stt", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    stream_analytics_function_javascript_udf = {
      name        = substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asafunc", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asafunc"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_job = {
      name        = substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asa", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asa"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_output_blob = {
      name        = substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaoblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaoblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_output_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaoeh", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaoeh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_output_mssql = {
      name        = substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaomssql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaomssql"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_output_servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaosbq", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaosbq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_output_servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaosbt", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaosbt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_reference_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asarblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asarblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_stream_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaiblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaiblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_stream_input_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaieh", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaieh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    stream_analytics_stream_input_iothub = {
      name        = substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaiiot", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaiiot"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    subnet = {
      name        = substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snet", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snet"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    subnet_service_endpoint_storage_policy = {
      name        = substr(join("-", compact([local.prefix, "se", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "se", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "se"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    synapse_private_link_hub = {
      name        = substr(join("-", compact([local.prefix, "synplh", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "synplh", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "synplh"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    synapse_spark_pool = {
      name        = substr(join("", compact([local.prefix_safe, "synsp", local.suffix_safe])), 0, 32)
      name_unique = substr(join("", compact([local.prefix_safe, "synsp", local.suffix_unique_safe])), 0, 32)
      dashes      = false
      slug        = "synsp"
      min_length  = 3
      max_length  = 32
      scope       = "parent"
      regex       = "^[a-zA-Z0-9]+$"
      separator   = ""
    }
    synapse_sql_pool = {
      name        = substr(join("", compact([local.prefix_safe, "syndp", local.suffix_safe])), 0, 60)
      name_unique = substr(join("", compact([local.prefix_safe, "syndp", local.suffix_unique_safe])), 0, 60)
      dashes      = false
      slug        = "syndp"
      min_length  = 1
      max_length  = 60
      scope       = "parent"
      regex       = "^[a-zA-Z0-9]+$"
      separator   = ""
    }
    synapse_workspace = {
      name        = substr(join("-", compact([local.prefix, "synw", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "synw", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "synw"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
      separator   = "-"
    }
    template_deployment = {
      name        = substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "deploy", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "deploy"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-._\\(\\)]+$"
      separator   = "-"
    }
    traffic_manager_profile = {
      name        = substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "traf", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "traf"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    user_assigned_identity = {
      name        = substr(join("-", compact([local.prefix, "uai", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "uai", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "uai"
      min_length  = 3
      max_length  = 128
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
      separator   = "-"
    }
    virtual_desktop_application_group = {
      name        = substr(join("-", compact([local.prefix, "vdag", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "vdag", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "vdag"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_desktop_host_pool = {
      name        = substr(join("-", compact([local.prefix, "vdpool", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "vdpool", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "vdpool"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_desktop_scaling_plan = {
      name        = substr(join("-", compact([local.prefix, "vdscaling", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "vdscaling", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "vdscaling"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_desktop_workspace = {
      name        = substr(join("-", compact([local.prefix, "vdws", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "vdws", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "vdws"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_hub = {
      name        = substr(join("-", compact([local.prefix, "vhub", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vhub", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vhub"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
    }
    virtual_machine_extension = {
      name        = substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vmx", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vmx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_machine_restore_point_collection = {
      name        = substr(join("-", compact([local.prefix, "rpc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rpc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rpc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
    }
    virtual_machine_scale_set_extension = {
      name        = substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vmssx", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vmssx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_network = {
      name        = substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vnet", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vnet"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vgw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_network_gateway_connection = {
      name        = substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vcn", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vcn"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_network_peering = {
      name        = substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vpeer", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vpeer"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    virtual_wan = {
      name        = substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vwan", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vwan"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    vpn_gateway = {
      name        = substr(join("-", compact([local.prefix, "vpng", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vpng", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vpng"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    vpn_gateway_connection = {
      name        = substr(join("-", compact([local.prefix, "vcn", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vcn", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vcn"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    vpn_site = {
      name        = substr(join("-", compact([local.prefix, "vst", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vst", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vst"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    web_application_firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "waf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "waf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "waf"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    web_application_firewall_policy_rule_group = {
      name        = substr(join("-", compact([local.prefix, "wafrg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "wafrg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "wafrg"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
      separator   = "-"
    }
    windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
    }
    windows_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
      separator   = "-"
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
    backup_policy_vm = {
      valid_name        = length(regexall(local.az.backup_policy_vm.regex, local.az.backup_policy_vm.name)) > 0 && length(local.az.backup_policy_vm.name) > local.az.backup_policy_vm.min_length
      valid_name_unique = length(regexall(local.az.backup_policy_vm.regex, local.az.backup_policy_vm.name_unique)) > 0
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
    cdn_frontdoor_endpoint = {
      valid_name        = length(regexall(local.az.cdn_frontdoor_endpoint.regex, local.az.cdn_frontdoor_endpoint.name)) > 0 && length(local.az.cdn_frontdoor_endpoint.name) > local.az.cdn_frontdoor_endpoint.min_length
      valid_name_unique = length(regexall(local.az.cdn_frontdoor_endpoint.regex, local.az.cdn_frontdoor_endpoint.name_unique)) > 0
    }
    cdn_frontdoor_origin = {
      valid_name        = length(regexall(local.az.cdn_frontdoor_origin.regex, local.az.cdn_frontdoor_origin.name)) > 0 && length(local.az.cdn_frontdoor_origin.name) > local.az.cdn_frontdoor_origin.min_length
      valid_name_unique = length(regexall(local.az.cdn_frontdoor_origin.regex, local.az.cdn_frontdoor_origin.name_unique)) > 0
    }
    cdn_frontdoor_origin_group = {
      valid_name        = length(regexall(local.az.cdn_frontdoor_origin_group.regex, local.az.cdn_frontdoor_origin_group.name)) > 0 && length(local.az.cdn_frontdoor_origin_group.name) > local.az.cdn_frontdoor_origin_group.min_length
      valid_name_unique = length(regexall(local.az.cdn_frontdoor_origin_group.regex, local.az.cdn_frontdoor_origin_group.name_unique)) > 0
    }
    cdn_frontdoor_profile = {
      valid_name        = length(regexall(local.az.cdn_frontdoor_profile.regex, local.az.cdn_frontdoor_profile.name)) > 0 && length(local.az.cdn_frontdoor_profile.name) > local.az.cdn_frontdoor_profile.min_length
      valid_name_unique = length(regexall(local.az.cdn_frontdoor_profile.regex, local.az.cdn_frontdoor_profile.name_unique)) > 0
    }
    cdn_frontdoor_route = {
      valid_name        = length(regexall(local.az.cdn_frontdoor_route.regex, local.az.cdn_frontdoor_route.name)) > 0 && length(local.az.cdn_frontdoor_route.name) > local.az.cdn_frontdoor_route.min_length
      valid_name_unique = length(regexall(local.az.cdn_frontdoor_route.regex, local.az.cdn_frontdoor_route.name_unique)) > 0
    }
    cdn_profile = {
      valid_name        = length(regexall(local.az.cdn_profile.regex, local.az.cdn_profile.name)) > 0 && length(local.az.cdn_profile.name) > local.az.cdn_profile.min_length
      valid_name_unique = length(regexall(local.az.cdn_profile.regex, local.az.cdn_profile.name_unique)) > 0
    }
    cognitive_account = {
      valid_name        = length(regexall(local.az.cognitive_account.regex, local.az.cognitive_account.name)) > 0 && length(local.az.cognitive_account.name) > local.az.cognitive_account.min_length
      valid_name_unique = length(regexall(local.az.cognitive_account.regex, local.az.cognitive_account.name_unique)) > 0
    }
    communication_service = {
      valid_name        = length(regexall(local.az.communication_service.regex, local.az.communication_service.name)) > 0 && length(local.az.communication_service.name) > local.az.communication_service.min_length
      valid_name_unique = length(regexall(local.az.communication_service.regex, local.az.communication_service.name_unique)) > 0
    }
    container_app = {
      valid_name        = length(regexall(local.az.container_app.regex, local.az.container_app.name)) > 0 && length(local.az.container_app.name) > local.az.container_app.min_length
      valid_name_unique = length(regexall(local.az.container_app.regex, local.az.container_app.name_unique)) > 0
    }
    container_app_environment = {
      valid_name        = length(regexall(local.az.container_app_environment.regex, local.az.container_app_environment.name)) > 0 && length(local.az.container_app_environment.name) > local.az.container_app_environment.min_length
      valid_name_unique = length(regexall(local.az.container_app_environment.regex, local.az.container_app_environment.name_unique)) > 0
    }
    container_app_job = {
      valid_name        = length(regexall(local.az.container_app_job.regex, local.az.container_app_job.name)) > 0 && length(local.az.container_app_job.name) > local.az.container_app_job.min_length
      valid_name_unique = length(regexall(local.az.container_app_job.regex, local.az.container_app_job.name_unique)) > 0
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
    cosmosdb_cassandra = {
      valid_name        = length(regexall(local.az.cosmosdb_cassandra.regex, local.az.cosmosdb_cassandra.name)) > 0 && length(local.az.cosmosdb_cassandra.name) > local.az.cosmosdb_cassandra.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_cassandra.regex, local.az.cosmosdb_cassandra.name_unique)) > 0
    }
    cosmosdb_cassandra_cluster = {
      valid_name        = length(regexall(local.az.cosmosdb_cassandra_cluster.regex, local.az.cosmosdb_cassandra_cluster.name)) > 0 && length(local.az.cosmosdb_cassandra_cluster.name) > local.az.cosmosdb_cassandra_cluster.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_cassandra_cluster.regex, local.az.cosmosdb_cassandra_cluster.name_unique)) > 0
    }
    cosmosdb_cassandra_datacenter = {
      valid_name        = length(regexall(local.az.cosmosdb_cassandra_datacenter.regex, local.az.cosmosdb_cassandra_datacenter.name)) > 0 && length(local.az.cosmosdb_cassandra_datacenter.name) > local.az.cosmosdb_cassandra_datacenter.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_cassandra_datacenter.regex, local.az.cosmosdb_cassandra_datacenter.name_unique)) > 0
    }
    cosmosdb_gremlin = {
      valid_name        = length(regexall(local.az.cosmosdb_gremlin.regex, local.az.cosmosdb_gremlin.name)) > 0 && length(local.az.cosmosdb_gremlin.name) > local.az.cosmosdb_gremlin.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_gremlin.regex, local.az.cosmosdb_gremlin.name_unique)) > 0
    }
    cosmosdb_mongodb = {
      valid_name        = length(regexall(local.az.cosmosdb_mongodb.regex, local.az.cosmosdb_mongodb.name)) > 0 && length(local.az.cosmosdb_mongodb.name) > local.az.cosmosdb_mongodb.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_mongodb.regex, local.az.cosmosdb_mongodb.name_unique)) > 0
    }
    cosmosdb_nosql = {
      valid_name        = length(regexall(local.az.cosmosdb_nosql.regex, local.az.cosmosdb_nosql.name)) > 0 && length(local.az.cosmosdb_nosql.name) > local.az.cosmosdb_nosql.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_nosql.regex, local.az.cosmosdb_nosql.name_unique)) > 0
    }
    cosmosdb_postgres = {
      valid_name        = length(regexall(local.az.cosmosdb_postgres.regex, local.az.cosmosdb_postgres.name)) > 0 && length(local.az.cosmosdb_postgres.name) > local.az.cosmosdb_postgres.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_postgres.regex, local.az.cosmosdb_postgres.name_unique)) > 0
    }
    cosmosdb_tables = {
      valid_name        = length(regexall(local.az.cosmosdb_tables.regex, local.az.cosmosdb_tables.name)) > 0 && length(local.az.cosmosdb_tables.name) > local.az.cosmosdb_tables.min_length
      valid_name_unique = length(regexall(local.az.cosmosdb_tables.regex, local.az.cosmosdb_tables.name_unique)) > 0
    }
    custom_provider = {
      valid_name        = length(regexall(local.az.custom_provider.regex, local.az.custom_provider.name)) > 0 && length(local.az.custom_provider.name) > local.az.custom_provider.min_length
      valid_name_unique = length(regexall(local.az.custom_provider.regex, local.az.custom_provider.name_unique)) > 0
    }
    dashboard = {
      valid_name        = length(regexall(local.az.dashboard.regex, local.az.dashboard.name)) > 0 && length(local.az.dashboard.name) > local.az.dashboard.min_length
      valid_name_unique = length(regexall(local.az.dashboard.regex, local.az.dashboard.name_unique)) > 0
    }
    dashboard_grafana = {
      valid_name        = length(regexall(local.az.dashboard_grafana.regex, local.az.dashboard_grafana.name)) > 0 && length(local.az.dashboard_grafana.name) > local.az.dashboard_grafana.min_length
      valid_name_unique = length(regexall(local.az.dashboard_grafana.regex, local.az.dashboard_grafana.name_unique)) > 0
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
    data_protection_backup_vault = {
      valid_name        = length(regexall(local.az.data_protection_backup_vault.regex, local.az.data_protection_backup_vault.name)) > 0 && length(local.az.data_protection_backup_vault.name) > local.az.data_protection_backup_vault.min_length
      valid_name_unique = length(regexall(local.az.data_protection_backup_vault.regex, local.az.data_protection_backup_vault.name_unique)) > 0
    }
    database_migration_project = {
      valid_name        = length(regexall(local.az.database_migration_project.regex, local.az.database_migration_project.name)) > 0 && length(local.az.database_migration_project.name) > local.az.database_migration_project.min_length
      valid_name_unique = length(regexall(local.az.database_migration_project.regex, local.az.database_migration_project.name_unique)) > 0
    }
    database_migration_service = {
      valid_name        = length(regexall(local.az.database_migration_service.regex, local.az.database_migration_service.name)) > 0 && length(local.az.database_migration_service.name) > local.az.database_migration_service.min_length
      valid_name_unique = length(regexall(local.az.database_migration_service.regex, local.az.database_migration_service.name_unique)) > 0
    }
    databricks_access_connector = {
      valid_name        = length(regexall(local.az.databricks_access_connector.regex, local.az.databricks_access_connector.name)) > 0 && length(local.az.databricks_access_connector.name) > local.az.databricks_access_connector.min_length
      valid_name_unique = length(regexall(local.az.databricks_access_connector.regex, local.az.databricks_access_connector.name_unique)) > 0
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
    dns_private_resolver = {
      valid_name        = length(regexall(local.az.dns_private_resolver.regex, local.az.dns_private_resolver.name)) > 0 && length(local.az.dns_private_resolver.name) > local.az.dns_private_resolver.min_length
      valid_name_unique = length(regexall(local.az.dns_private_resolver.regex, local.az.dns_private_resolver.name_unique)) > 0
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
    eventgrid_namespace = {
      valid_name        = length(regexall(local.az.eventgrid_namespace.regex, local.az.eventgrid_namespace.name)) > 0 && length(local.az.eventgrid_namespace.name) > local.az.eventgrid_namespace.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_namespace.regex, local.az.eventgrid_namespace.name_unique)) > 0
    }
    eventgrid_system_topic = {
      valid_name        = length(regexall(local.az.eventgrid_system_topic.regex, local.az.eventgrid_system_topic.name)) > 0 && length(local.az.eventgrid_system_topic.name) > local.az.eventgrid_system_topic.min_length
      valid_name_unique = length(regexall(local.az.eventgrid_system_topic.regex, local.az.eventgrid_system_topic.name_unique)) > 0
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
    eventhub_cluster = {
      valid_name        = length(regexall(local.az.eventhub_cluster.regex, local.az.eventhub_cluster.name)) > 0 && length(local.az.eventhub_cluster.name) > local.az.eventhub_cluster.min_length
      valid_name_unique = length(regexall(local.az.eventhub_cluster.regex, local.az.eventhub_cluster.name_unique)) > 0
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
    fabric_capacity = {
      valid_name        = length(regexall(local.az.fabric_capacity.regex, local.az.fabric_capacity.name)) > 0 && length(local.az.fabric_capacity.name) > local.az.fabric_capacity.min_length
      valid_name_unique = length(regexall(local.az.fabric_capacity.regex, local.az.fabric_capacity.name_unique)) > 0
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
    ip_group = {
      valid_name        = length(regexall(local.az.ip_group.regex, local.az.ip_group.name)) > 0 && length(local.az.ip_group.name) > local.az.ip_group.min_length
      valid_name_unique = length(regexall(local.az.ip_group.regex, local.az.ip_group.name_unique)) > 0
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
    lb_rule = {
      valid_name        = length(regexall(local.az.lb_rule.regex, local.az.lb_rule.name)) > 0 && length(local.az.lb_rule.name) > local.az.lb_rule.min_length
      valid_name_unique = length(regexall(local.az.lb_rule.regex, local.az.lb_rule.name_unique)) > 0
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
    log_analytics_query_pack = {
      valid_name        = length(regexall(local.az.log_analytics_query_pack.regex, local.az.log_analytics_query_pack.name)) > 0 && length(local.az.log_analytics_query_pack.name) > local.az.log_analytics_query_pack.min_length
      valid_name_unique = length(regexall(local.az.log_analytics_query_pack.regex, local.az.log_analytics_query_pack.name_unique)) > 0
    }
    log_analytics_workspace = {
      valid_name        = length(regexall(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name)) > 0 && length(local.az.log_analytics_workspace.name) > local.az.log_analytics_workspace.min_length
      valid_name_unique = length(regexall(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name_unique)) > 0
    }
    logic_app_integration_account = {
      valid_name        = length(regexall(local.az.logic_app_integration_account.regex, local.az.logic_app_integration_account.name)) > 0 && length(local.az.logic_app_integration_account.name) > local.az.logic_app_integration_account.min_length
      valid_name_unique = length(regexall(local.az.logic_app_integration_account.regex, local.az.logic_app_integration_account.name_unique)) > 0
    }
    logic_app_workflow = {
      valid_name        = length(regexall(local.az.logic_app_workflow.regex, local.az.logic_app_workflow.name)) > 0 && length(local.az.logic_app_workflow.name) > local.az.logic_app_workflow.min_length
      valid_name_unique = length(regexall(local.az.logic_app_workflow.regex, local.az.logic_app_workflow.name_unique)) > 0
    }
    machine_learning_registry = {
      valid_name        = length(regexall(local.az.machine_learning_registry.regex, local.az.machine_learning_registry.name)) > 0 && length(local.az.machine_learning_registry.name) > local.az.machine_learning_registry.min_length
      valid_name_unique = length(regexall(local.az.machine_learning_registry.regex, local.az.machine_learning_registry.name_unique)) > 0
    }
    machine_learning_workspace = {
      valid_name        = length(regexall(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name)) > 0 && length(local.az.machine_learning_workspace.name) > local.az.machine_learning_workspace.min_length
      valid_name_unique = length(regexall(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name_unique)) > 0
    }
    maintenance_configuration = {
      valid_name        = length(regexall(local.az.maintenance_configuration.regex, local.az.maintenance_configuration.name)) > 0 && length(local.az.maintenance_configuration.name) > local.az.maintenance_configuration.min_length
      valid_name_unique = length(regexall(local.az.maintenance_configuration.regex, local.az.maintenance_configuration.name_unique)) > 0
    }
    managed_disk = {
      valid_name        = length(regexall(local.az.managed_disk.regex, local.az.managed_disk.name)) > 0 && length(local.az.managed_disk.name) > local.az.managed_disk.min_length
      valid_name_unique = length(regexall(local.az.managed_disk.regex, local.az.managed_disk.name_unique)) > 0
    }
    management_group = {
      valid_name        = length(regexall(local.az.management_group.regex, local.az.management_group.name)) > 0 && length(local.az.management_group.name) > local.az.management_group.min_length
      valid_name_unique = length(regexall(local.az.management_group.regex, local.az.management_group.name_unique)) > 0
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
    monitor_alert_processing_rule_action_group = {
      valid_name        = length(regexall(local.az.monitor_alert_processing_rule_action_group.regex, local.az.monitor_alert_processing_rule_action_group.name)) > 0 && length(local.az.monitor_alert_processing_rule_action_group.name) > local.az.monitor_alert_processing_rule_action_group.min_length
      valid_name_unique = length(regexall(local.az.monitor_alert_processing_rule_action_group.regex, local.az.monitor_alert_processing_rule_action_group.name_unique)) > 0
    }
    monitor_autoscale_setting = {
      valid_name        = length(regexall(local.az.monitor_autoscale_setting.regex, local.az.monitor_autoscale_setting.name)) > 0 && length(local.az.monitor_autoscale_setting.name) > local.az.monitor_autoscale_setting.min_length
      valid_name_unique = length(regexall(local.az.monitor_autoscale_setting.regex, local.az.monitor_autoscale_setting.name_unique)) > 0
    }
    monitor_data_collection_endpoint = {
      valid_name        = length(regexall(local.az.monitor_data_collection_endpoint.regex, local.az.monitor_data_collection_endpoint.name)) > 0 && length(local.az.monitor_data_collection_endpoint.name) > local.az.monitor_data_collection_endpoint.min_length
      valid_name_unique = length(regexall(local.az.monitor_data_collection_endpoint.regex, local.az.monitor_data_collection_endpoint.name_unique)) > 0
    }
    monitor_data_collection_rule = {
      valid_name        = length(regexall(local.az.monitor_data_collection_rule.regex, local.az.monitor_data_collection_rule.name)) > 0 && length(local.az.monitor_data_collection_rule.name) > local.az.monitor_data_collection_rule.min_length
      valid_name_unique = length(regexall(local.az.monitor_data_collection_rule.regex, local.az.monitor_data_collection_rule.name_unique)) > 0
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
    mssql_job_agent = {
      valid_name        = length(regexall(local.az.mssql_job_agent.regex, local.az.mssql_job_agent.name)) > 0 && length(local.az.mssql_job_agent.name) > local.az.mssql_job_agent.min_length
      valid_name_unique = length(regexall(local.az.mssql_job_agent.regex, local.az.mssql_job_agent.name_unique)) > 0
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
    network_manager = {
      valid_name        = length(regexall(local.az.network_manager.regex, local.az.network_manager.name)) > 0 && length(local.az.network_manager.name) > local.az.network_manager.min_length
      valid_name_unique = length(regexall(local.az.network_manager.regex, local.az.network_manager.name_unique)) > 0
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
    policy_definition = {
      valid_name        = length(regexall(local.az.policy_definition.regex, local.az.policy_definition.name)) > 0 && length(local.az.policy_definition.name) > local.az.policy_definition.min_length
      valid_name_unique = length(regexall(local.az.policy_definition.regex, local.az.policy_definition.name_unique)) > 0
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
    purview_account = {
      valid_name        = length(regexall(local.az.purview_account.regex, local.az.purview_account.name)) > 0 && length(local.az.purview_account.name) > local.az.purview_account.min_length
      valid_name_unique = length(regexall(local.az.purview_account.regex, local.az.purview_account.name_unique)) > 0
    }
    recovery_services_vault = {
      valid_name        = length(regexall(local.az.recovery_services_vault.regex, local.az.recovery_services_vault.name)) > 0 && length(local.az.recovery_services_vault.name) > local.az.recovery_services_vault.min_length
      valid_name_unique = length(regexall(local.az.recovery_services_vault.regex, local.az.recovery_services_vault.name_unique)) > 0
    }
    redhat_openshift_cluster = {
      valid_name        = length(regexall(local.az.redhat_openshift_cluster.regex, local.az.redhat_openshift_cluster.name)) > 0 && length(local.az.redhat_openshift_cluster.name) > local.az.redhat_openshift_cluster.min_length
      valid_name_unique = length(regexall(local.az.redhat_openshift_cluster.regex, local.az.redhat_openshift_cluster.name_unique)) > 0
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
    resource_group_template_deployment = {
      valid_name        = length(regexall(local.az.resource_group_template_deployment.regex, local.az.resource_group_template_deployment.name)) > 0 && length(local.az.resource_group_template_deployment.name) > local.az.resource_group_template_deployment.min_length
      valid_name_unique = length(regexall(local.az.resource_group_template_deployment.regex, local.az.resource_group_template_deployment.name_unique)) > 0
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
    route_filter = {
      valid_name        = length(regexall(local.az.route_filter.regex, local.az.route_filter.name)) > 0 && length(local.az.route_filter.name) > local.az.route_filter.min_length
      valid_name_unique = length(regexall(local.az.route_filter.regex, local.az.route_filter.name_unique)) > 0
    }
    route_server = {
      valid_name        = length(regexall(local.az.route_server.regex, local.az.route_server.name)) > 0 && length(local.az.route_server.name) > local.az.route_server.min_length
      valid_name_unique = length(regexall(local.az.route_server.regex, local.az.route_server.name_unique)) > 0
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
    ssh_public_key = {
      valid_name        = length(regexall(local.az.ssh_public_key.regex, local.az.ssh_public_key.name)) > 0 && length(local.az.ssh_public_key.name) > local.az.ssh_public_key.min_length
      valid_name_unique = length(regexall(local.az.ssh_public_key.regex, local.az.ssh_public_key.name_unique)) > 0
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
    subnet_service_endpoint_storage_policy = {
      valid_name        = length(regexall(local.az.subnet_service_endpoint_storage_policy.regex, local.az.subnet_service_endpoint_storage_policy.name)) > 0 && length(local.az.subnet_service_endpoint_storage_policy.name) > local.az.subnet_service_endpoint_storage_policy.min_length
      valid_name_unique = length(regexall(local.az.subnet_service_endpoint_storage_policy.regex, local.az.subnet_service_endpoint_storage_policy.name_unique)) > 0
    }
    synapse_private_link_hub = {
      valid_name        = length(regexall(local.az.synapse_private_link_hub.regex, local.az.synapse_private_link_hub.name)) > 0 && length(local.az.synapse_private_link_hub.name) > local.az.synapse_private_link_hub.min_length
      valid_name_unique = length(regexall(local.az.synapse_private_link_hub.regex, local.az.synapse_private_link_hub.name_unique)) > 0
    }
    synapse_spark_pool = {
      valid_name        = length(regexall(local.az.synapse_spark_pool.regex, local.az.synapse_spark_pool.name)) > 0 && length(local.az.synapse_spark_pool.name) > local.az.synapse_spark_pool.min_length
      valid_name_unique = length(regexall(local.az.synapse_spark_pool.regex, local.az.synapse_spark_pool.name_unique)) > 0
    }
    synapse_sql_pool = {
      valid_name        = length(regexall(local.az.synapse_sql_pool.regex, local.az.synapse_sql_pool.name)) > 0 && length(local.az.synapse_sql_pool.name) > local.az.synapse_sql_pool.min_length
      valid_name_unique = length(regexall(local.az.synapse_sql_pool.regex, local.az.synapse_sql_pool.name_unique)) > 0
    }
    synapse_workspace = {
      valid_name        = length(regexall(local.az.synapse_workspace.regex, local.az.synapse_workspace.name)) > 0 && length(local.az.synapse_workspace.name) > local.az.synapse_workspace.min_length
      valid_name_unique = length(regexall(local.az.synapse_workspace.regex, local.az.synapse_workspace.name_unique)) > 0
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
    virtual_hub = {
      valid_name        = length(regexall(local.az.virtual_hub.regex, local.az.virtual_hub.name)) > 0 && length(local.az.virtual_hub.name) > local.az.virtual_hub.min_length
      valid_name_unique = length(regexall(local.az.virtual_hub.regex, local.az.virtual_hub.name_unique)) > 0
    }
    virtual_machine = {
      valid_name        = length(regexall(local.az.virtual_machine.regex, local.az.virtual_machine.name)) > 0 && length(local.az.virtual_machine.name) > local.az.virtual_machine.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine.regex, local.az.virtual_machine.name_unique)) > 0
    }
    virtual_machine_extension = {
      valid_name        = length(regexall(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name)) > 0 && length(local.az.virtual_machine_extension.name) > local.az.virtual_machine_extension.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name_unique)) > 0
    }
    virtual_machine_restore_point_collection = {
      valid_name        = length(regexall(local.az.virtual_machine_restore_point_collection.regex, local.az.virtual_machine_restore_point_collection.name)) > 0 && length(local.az.virtual_machine_restore_point_collection.name) > local.az.virtual_machine_restore_point_collection.min_length
      valid_name_unique = length(regexall(local.az.virtual_machine_restore_point_collection.regex, local.az.virtual_machine_restore_point_collection.name_unique)) > 0
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
    vpn_gateway = {
      valid_name        = length(regexall(local.az.vpn_gateway.regex, local.az.vpn_gateway.name)) > 0 && length(local.az.vpn_gateway.name) > local.az.vpn_gateway.min_length
      valid_name_unique = length(regexall(local.az.vpn_gateway.regex, local.az.vpn_gateway.name_unique)) > 0
    }
    vpn_gateway_connection = {
      valid_name        = length(regexall(local.az.vpn_gateway_connection.regex, local.az.vpn_gateway_connection.name)) > 0 && length(local.az.vpn_gateway_connection.name) > local.az.vpn_gateway_connection.min_length
      valid_name_unique = length(regexall(local.az.vpn_gateway_connection.regex, local.az.vpn_gateway_connection.name_unique)) > 0
    }
    vpn_site = {
      valid_name        = length(regexall(local.az.vpn_site.regex, local.az.vpn_site.name)) > 0 && length(local.az.vpn_site.name) > local.az.vpn_site.min_length
      valid_name_unique = length(regexall(local.az.vpn_site.regex, local.az.vpn_site.name_unique)) > 0
    }
    web_application_firewall_policy = {
      valid_name        = length(regexall(local.az.web_application_firewall_policy.regex, local.az.web_application_firewall_policy.name)) > 0 && length(local.az.web_application_firewall_policy.name) > local.az.web_application_firewall_policy.min_length
      valid_name_unique = length(regexall(local.az.web_application_firewall_policy.regex, local.az.web_application_firewall_policy.name_unique)) > 0
    }
    web_application_firewall_policy_rule_group = {
      valid_name        = length(regexall(local.az.web_application_firewall_policy_rule_group.regex, local.az.web_application_firewall_policy_rule_group.name)) > 0 && length(local.az.web_application_firewall_policy_rule_group.name) > local.az.web_application_firewall_policy_rule_group.min_length
      valid_name_unique = length(regexall(local.az.web_application_firewall_policy_rule_group.regex, local.az.web_application_firewall_policy_rule_group.name_unique)) > 0
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
