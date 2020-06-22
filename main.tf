provider "random" {
  version = "~> 2.2"
}

resource "random_string" "main" {
  length  = 60
  special = false
  upper   = false
  number  = var.unique-include-numbers
}

resource "random_string" "first_letter" {
  length  = 1
  special = false
  upper   = false
  number  = false
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
      regex       = "/^[a-z][a-z0-9]+$/"
    }
    api_managment_service = {
      name        = substr(join("", compact([local.prefix_safe, "apim", local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "apim", local.suffix_unique_safe])), 0, 50)
      dashes      = false
      slug        = "apim"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-z][a-zA-Z0-9]+$/"
    }
    app_configuration = {
      name        = substr(join("-", compact([local.prefix, "appcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "appcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "appcg"
      min_length  = 5
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9_-]+$/"
    }
    role_assignment = {
      name        = substr(join("-", compact([local.prefix, "ra", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "ra", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "ra"
      min_length  = 1
      max_length  = 64
      scope       = "assignment"
      regex       = "/^[^%]+[^ %.]$/"
    }
    role_definition = {
      name        = substr(join("-", compact([local.prefix, "rd", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "rd", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "rd"
      min_length  = 1
      max_length  = 64
      scope       = "definition"
      regex       = "/^[^%]+[^ %.]$/"
    }
    automation_account = {
      name        = substr(join("-", compact([local.prefix, "aa", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "aa", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "aa"
      min_length  = 6
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    automation_certificate = {
      name        = substr(join("-", compact([local.prefix, "aacert", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aacert", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aacert"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    automation_credential = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aacred", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    automation_runbook = {
      name        = substr(join("-", compact([local.prefix, "aacred", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "aacred", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "aacred"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+$/"
    }
    automation_schedule = {
      name        = substr(join("-", compact([local.prefix, "aasched", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aasched", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aasched"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    automation_variable = {
      name        = substr(join("-", compact([local.prefix, "aavar", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "aavar", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "aavar"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    batch_account = {
      name        = substr(join("", compact([local.prefix_safe, "ba", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "ba", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "ba"
      min_length  = 3
      max_length  = 24
      scope       = "region"
      regex       = "/^[a-z0-9]+$/"
    }
    batch_application = {
      name        = substr(join("-", compact([local.prefix, "baapp", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "baapp", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "baapp"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9_-]+$/"
    }
    batch_certificate = {
      name        = substr(join("-", compact([local.prefix, "bacert", local.suffix])), 0, 45)
      name_unique = substr(join("-", compact([local.prefix, "bacert", local.suffix_unique])), 0, 45)
      dashes      = true
      slug        = "bacert"
      min_length  = 5
      max_length  = 45
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9_-]+$/"
    }
    batch_pool = {
      name        = substr(join("-", compact([local.prefix, "bapool", local.suffix])), 0, 24)
      name_unique = substr(join("-", compact([local.prefix, "bapool", local.suffix_unique])), 0, 24)
      dashes      = true
      slug        = "bapool"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9_-]+$/"
    }
    bot_web_app = {
      name        = substr(join("-", compact([local.prefix, "bot", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "bot", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "bot"
      min_length  = 2
      max_length  = 64
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_channel_Email = {
      name        = substr(join("-", compact([local.prefix, "botmail", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botmail", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botmail"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_channel_ms_teams = {
      name        = substr(join("-", compact([local.prefix, "botteams", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botteams", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botteams"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_channel_slack = {
      name        = substr(join("-", compact([local.prefix, "botslack", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botslack", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botslack"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_channel_directline = {
      name        = substr(join("-", compact([local.prefix, "botline", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botline", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botline"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_channels_registration = {
      name        = substr(join("-", compact([local.prefix, "botchan", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botchan", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botchan"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    bot_connection = {
      name        = substr(join("-", compact([local.prefix, "botcon", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "botcon", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "botcon"
      min_length  = 2
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    redis_cache = {
      name        = substr(join("-", compact([local.prefix, "redis", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "redis", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "redis"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    redis_firewall_rule = {
      name        = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_safe])), 0, 256)
      name_unique = substr(join("", compact([local.prefix_safe, "redisfw", local.suffix_unique_safe])), 0, 256)
      dashes      = false
      slug        = "redisfw"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9]+$/"
    }
    cdn_profile = {
      name        = substr(join("-", compact([local.prefix, "cdnprof", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "cdnprof", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "cdnprof"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    cdn_endpoint = {
      name        = substr(join("-", compact([local.prefix, "cdn", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "cdn", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "cdn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    cognitive_account = {
      name        = substr(join("-", compact([local.prefix, "cog", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "cog", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "cog"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+$/"
    }
    availability_set = {
      name        = substr(join("-", compact([local.prefix, "avail", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "avail", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "avail"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$/"
    }
    disk_encryption_set = {
      name        = substr(join("-", compact([local.prefix, "des", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "des", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "des"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9_]+$/"
    }
    image = {
      name        = substr(join("-", compact([local.prefix, "img", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "img", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "img"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$/"
    }
    linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    linux_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    managed_disk = {
      name        = substr(join("-", compact([local.prefix, "dsk", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dsk", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dsk"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9_]+$/"
    }
    virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "vm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vm"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    windows_virtual_machine_scale_set = {
      name        = substr(join("-", compact([local.prefix, "vmss", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "vmss", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "vmss"
      min_length  = 1
      max_length  = 15
      scope       = "resourceGroup"
      regex       = "/^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$/"
    }
    containerGroups = {
      name        = substr(join("-", compact([local.prefix, "cg", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "cg", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "cg"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    container_registry = {
      name        = substr(join("", compact([local.prefix_safe, "cr", local.suffix_safe])), 0, 63)
      name_unique = substr(join("", compact([local.prefix_safe, "cr", local.suffix_unique_safe])), 0, 63)
      dashes      = false
      slug        = "cr"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9]+$/"
    }
    container_registry_webhook = {
      name        = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "crwh", local.suffix_unique_safe])), 0, 50)
      dashes      = false
      slug        = "crwh"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9]+$/"
    }
    kubernetes_cluster = {
      name        = substr(join("-", compact([local.prefix, "aks", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "aks", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "aks"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$/"
    }
    cosmosdb_account = {
      name        = substr(join("-", compact([local.prefix, "cosmos", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "cosmos", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "cosmos"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$/"
    }
    custom_provider = {
      name        = substr(join("-", compact([local.prefix, "prov", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "prov", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "prov"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[^&%?\\/]+[^&%.?\\/ ]$/"
    }
    mariadb_server = {
      name        = substr(join("-", compact([local.prefix, "maria", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "maria", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "maria"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$/"
    }
    mariadb_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mariafw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mariafw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mariafw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    mariadb_database = {
      name        = substr(join("-", compact([local.prefix, "mariadb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mariadb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mariadb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    mariadb_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mariavn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mariavn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mariavn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    mysql_server = {
      name        = substr(join("-", compact([local.prefix, "mysql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mysql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mysql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$/"
    }
    mysql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mysqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mysqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    mysql_database = {
      name        = substr(join("-", compact([local.prefix, "mysqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "mysqldb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "mysqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    mysql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "mysqlvn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "mysqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    postgresql_server = {
      name        = substr(join("-", compact([local.prefix, "psql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "psql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$/"
    }
    postgresql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "psqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "psqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    postgresql_database = {
      name        = substr(join("-", compact([local.prefix, "psqldb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "psqldb", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "psqldb"
      min_length  = 1
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    postgresql_virtual_network_rule = {
      name        = substr(join("-", compact([local.prefix, "psqlvn", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "psqlvn", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "psqlvn"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    database_migration_project = {
      name        = substr(join("-", compact([local.prefix, "migr", local.suffix])), 0, 57)
      name_unique = substr(join("-", compact([local.prefix, "migr", local.suffix_unique])), 0, 57)
      dashes      = true
      slug        = "migr"
      min_length  = 2
      max_length  = 57
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    database_migration_service = {
      name        = substr(join("-", compact([local.prefix, "dms", local.suffix])), 0, 62)
      name_unique = substr(join("-", compact([local.prefix, "dms", local.suffix_unique])), 0, 62)
      dashes      = true
      slug        = "dms"
      min_length  = 2
      max_length  = 62
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-_.]+$/"
    }
    databricks_workspace = {
      name        = substr(join("-", compact([local.prefix, "dbw", local.suffix])), 0, 30)
      name_unique = substr(join("-", compact([local.prefix, "dbw", local.suffix_unique])), 0, 30)
      dashes      = true
      slug        = "dbw"
      min_length  = 3
      max_length  = 30
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    kusto_cluster = {
      name        = substr(join("", compact([local.prefix_safe, "kc", local.suffix_safe])), 0, 22)
      name_unique = substr(join("", compact([local.prefix_safe, "kc", local.suffix_unique_safe])), 0, 22)
      dashes      = false
      slug        = "kc"
      min_length  = 4
      max_length  = 22
      scope       = "global"
      regex       = "/^[a-z][a-z0-9]+$/"
    }
    kusto_database = {
      name        = substr(join("-", compact([local.prefix, "kdb", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "kdb", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "kdb"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9- .]+$/"
    }
    kusto_eventhub_data_connection = {
      name        = substr(join("-", compact([local.prefix, "kehc", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.prefix, "kehc", local.suffix_unique])), 0, 40)
      dashes      = true
      slug        = "kehc"
      min_length  = 1
      max_length  = 40
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9- .]+$/"
    }
    data_factory = {
      name        = substr(join("-", compact([local.prefix, "adf", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "adf", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "adf"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    data_factory_dataset_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfmysql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$/"
    }
    data_factory_dataset_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfpsql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$/"
    }
    data_factory_dataset_sql_server_table = {
      name        = substr(join("-", compact([local.prefix, "adfmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfmssql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$/"
    }
    data_factory_integration_runtime_managed = {
      name        = substr(join("-", compact([local.prefix, "adfir", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "adfir", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "adfir"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    data_factory_pipeline = {
      name        = substr(join("-", compact([local.prefix, "adfpl", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfpl", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfpl"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$/"
    }
    data_factory_linked_service_data_lake_storage_gen2 = {
      name        = substr(join("-", compact([local.prefix, "adfsvst", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvst", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvst"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_factory_linked_service_key_vault = {
      name        = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvkv", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvkv"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_factory_linked_service_mysql = {
      name        = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvmysql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvmysql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_factory_linked_service_postgresql = {
      name        = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvpsql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvpsql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_factory_linked_service_sql_server = {
      name        = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adfsvmssql", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adfsvmssql"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_factory_trigger_schedule = {
      name        = substr(join("-", compact([local.prefix, "adftg", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "adftg", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "adftg"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$/"
    }
    data_lake_analytics_account = {
      name        = substr(join("", compact([local.prefix_safe, "dla", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "dla", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "dla"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "/^[a-z0-9]+$/"
    }
    data_lake_analytics_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dlfw", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dlfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-z0-9-_]+$/"
    }
    data_lake_store = {
      name        = substr(join("", compact([local.prefix_safe, "dls", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "dls", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "dls"
      min_length  = 3
      max_length  = 24
      scope       = "parent"
      regex       = "/^[a-z0-9]+$/"
    }
    data_lake_store_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "dlsfw", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dlsfw", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dlsfw"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    dev_test_lab = {
      name        = substr(join("-", compact([local.prefix, "lab", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "lab", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "lab"
      min_length  = 1
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    dev_test_linux_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "labvm", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    dev_test_windows_virtual_machine = {
      name        = substr(join("-", compact([local.prefix, "labvm", local.suffix])), 0, 15)
      name_unique = substr(join("-", compact([local.prefix, "labvm", local.suffix_unique])), 0, 15)
      dashes      = true
      slug        = "labvm"
      min_length  = 1
      max_length  = 15
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    frontdoor = {
      name        = substr(join("-", compact([local.prefix, "fd", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "fd", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "fd"
      min_length  = 5
      max_length  = 64
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    frontdoor_firewall_policy = {
      name        = substr(join("-", compact([local.prefix, "fdfw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fdfw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fdfw"
      min_length  = 1
      max_length  = 80
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    hdinsight_hadoop_cluster = {
      name        = substr(join("-", compact([local.prefix, "hadoop", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "hadoop", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "hadoop"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_hbase_cluster = {
      name        = substr(join("-", compact([local.prefix, "hbase", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "hbase", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "hbase"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_kafka_cluster = {
      name        = substr(join("-", compact([local.prefix, "kafka", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "kafka", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "kafka"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_interactive_query_cluster = {
      name        = substr(join("-", compact([local.prefix, "iqr", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "iqr", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "iqr"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_ml_services_cluster = {
      name        = substr(join("-", compact([local.prefix, "mls", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "mls", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "mls"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_rserver_cluster = {
      name        = substr(join("-", compact([local.prefix, "rsv", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "rsv", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "rsv"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_spark_cluster = {
      name        = substr(join("-", compact([local.prefix, "spark", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "spark", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "spark"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    hdinsight_storm_cluster = {
      name        = substr(join("-", compact([local.prefix, "storm", local.suffix])), 0, 59)
      name_unique = substr(join("-", compact([local.prefix, "storm", local.suffix_unique])), 0, 59)
      dashes      = true
      slug        = "storm"
      min_length  = 3
      max_length  = 59
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    iotcentral_application = {
      name        = substr(join("-", compact([local.prefix, "iotapp", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "iotapp", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "iotapp"
      min_length  = 2
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    iothub = {
      name        = substr(join("-", compact([local.prefix, "iot", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "iot", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "iot"
      min_length  = 3
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-z0-9]$/"
    }
    iothub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "iotcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "iotcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "iotcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-._]+$/"
    }
    iothub_dps = {
      name        = substr(join("-", compact([local.prefix, "dps", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dps", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dps"
      min_length  = 3
      max_length  = 64
      scope       = "resoureceGroup"
      regex       = "/^[a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    iothub_dps_certificate = {
      name        = substr(join("-", compact([local.prefix, "dpscert", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "dpscert", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "dpscert"
      min_length  = 1
      max_length  = 64
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-._]+$/"
    }
    key_vault = {
      name        = substr(join("-", compact([local.prefix, "kv", local.suffix])), 0, 24)
      name_unique = substr(join("-", compact([local.prefix, "kv", local.suffix_unique])), 0, 24)
      dashes      = true
      slug        = "kv"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    key_vault_key = {
      name        = substr(join("-", compact([local.prefix, "kvk", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvk", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvk"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    key_vault_secret = {
      name        = substr(join("-", compact([local.prefix, "kvs", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvs", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvs"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    key_vault_certificate = {
      name        = substr(join("-", compact([local.prefix, "kvc", local.suffix])), 0, 127)
      name_unique = substr(join("-", compact([local.prefix, "kvc", local.suffix_unique])), 0, 127)
      dashes      = true
      slug        = "kvc"
      min_length  = 1
      max_length  = 127
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    lb = {
      name        = substr(join("-", compact([local.prefix, "lb", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lb", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lb"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    lb_nat_rule = {
      name        = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lbnatrl", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lbnatrl"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    public_ip = {
      name        = substr(join("-", compact([local.prefix, "pip", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pip", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pip"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    public_ip_prefix = {
      name        = substr(join("-", compact([local.prefix, "pippf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pippf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pippf"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    route = {
      name        = substr(join("-", compact([local.prefix, "rt", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "rt", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "rt"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    route_table = {
      name        = substr(join("-", compact([local.prefix, "route", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "route", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "route"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    subnet = {
      name        = substr(join("-", compact([local.prefix, "snet", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snet", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snet"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    traffic_manager_profile = {
      name        = substr(join("-", compact([local.prefix, "traf", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "traf", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "traf"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$/"
    }
    virtual_wan = {
      name        = substr(join("-", compact([local.prefix, "vwan", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vwan", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vwan"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    virtual_network = {
      name        = substr(join("-", compact([local.prefix, "vnet", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "vnet", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vnet"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    virtual_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "vgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vgw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    virtual_network_peering = {
      name        = substr(join("-", compact([local.prefix, "vpeer", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vpeer", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vpeer"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    network_interface = {
      name        = substr(join("-", compact([local.prefix, "nic", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nic", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nic"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    firewall = {
      name        = substr(join("-", compact([local.prefix, "fw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    eventhub = {
      name        = substr(join("-", compact([local.prefix, "evh", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "evh", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "evh"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    eventhub_namespace = {
      name        = substr(join("-", compact([local.prefix, "ehn", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehn", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehn"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    eventhub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    eventhub_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "ehnar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehnar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehnar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    eventhub_namespace_disaster_recovery_config = {
      name        = substr(join("-", compact([local.prefix, "ehdr", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehdr", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehdr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    eventhub_consumer_group = {
      name        = substr(join("-", compact([local.prefix, "ehcg", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "ehcg", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "ehcg"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    stream_analytics_job = {
      name        = substr(join("-", compact([local.prefix, "asa", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asa", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asa"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_function_javascript_udf = {
      name        = substr(join("-", compact([local.prefix, "asafunc", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asafunc", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asafunc"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_output_blob = {
      name        = substr(join("-", compact([local.prefix, "asaoblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaoblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaoblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_output_mssql = {
      name        = substr(join("-", compact([local.prefix, "asaomssql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaomssql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaomssql"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_output_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaoeh", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaoeh", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaoeh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_output_servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "asaosbq", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaosbq", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaosbq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_output_servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "asaosbt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaosbt", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaosbt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_reference_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asarblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asarblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asarblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_stream_input_blob = {
      name        = substr(join("-", compact([local.prefix, "asaiblob", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaiblob", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaiblob"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_stream_input_eventhub = {
      name        = substr(join("-", compact([local.prefix, "asaieh", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaieh", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaieh"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    stream_analytics_stream_input_iothub = {
      name        = substr(join("-", compact([local.prefix, "asaiiot", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "asaiiot", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "asaiiot"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-_]+$/"
    }
    shared_image_gallery = {
      name        = substr(join("", compact([local.prefix_safe, "sig", local.suffix_safe])), 0, 80)
      name_unique = substr(join("", compact([local.prefix_safe, "sig", local.suffix_unique_safe])), 0, 80)
      dashes      = false
      slug        = "sig"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9.]+[a-zA-Z0-9]$/"
    }
    shared_image = {
      name        = substr(join("-", compact([local.prefix, "si", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "si", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "si"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    snapshots = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snap", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    storage_account = {
      name        = substr(join("", compact([local.prefix_safe, "st", local.suffix_safe])), 0, 24)
      name_unique = substr(join("", compact([local.prefix_safe, "st", local.suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "st"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "/^[a-z0-9]+$/"
    }
    storage_container = {
      name        = substr(join("-", compact([local.prefix, "stct", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stct", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stct"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+$/"
    }
    storage_data_lake_gen2_filesystem = {
      name        = substr(join("-", compact([local.prefix, "stdl", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stdl", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stdl"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    storage_queue = {
      name        = substr(join("-", compact([local.prefix, "stq", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stq", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stq"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    storage_table = {
      name        = substr(join("-", compact([local.prefix, "stt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "stt", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "stt"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    storage_share = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sts", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    storage_share_directory = {
      name        = substr(join("-", compact([local.prefix, "sts", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sts", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sts"
      min_length  = 3
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    machine_learning_workspace = {
      name        = substr(join("-", compact([local.prefix, "mlw", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "mlw", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "mlw"
      min_length  = 1
      max_length  = 260
      scope       = "resourceGroup"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    storage_blob = {
      name        = substr(join("-", compact([local.prefix, "blob", local.suffix])), 0, 1024)
      name_unique = substr(join("-", compact([local.prefix, "blob", local.suffix_unique])), 0, 1024)
      dashes      = true
      slug        = "blob"
      min_length  = 1
      max_length  = 1024
      scope       = "parent"
      regex       = "/^[^\\s\\/$#&]+$/"
    }
    bastion_host = {
      name        = substr(join("-", compact([local.prefix, "snap", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "snap", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "snap"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    local_network_gateway = {
      name        = substr(join("-", compact([local.prefix, "lgw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "lgw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "lgw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    application_gateway = {
      name        = substr(join("-", compact([local.prefix, "agw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "agw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "agw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    express_route_gateway = {
      name        = substr(join("-", compact([local.prefix, "ergw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ergw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ergw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    express_route_circuit = {
      name        = substr(join("-", compact([local.prefix, "erc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "erc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "erc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    point_to_site_vpn_gateway = {
      name        = substr(join("-", compact([local.prefix, "vpngw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vpngw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vpngw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    template_deployment = {
      name        = substr(join("-", compact([local.prefix, "deploy", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "deploy", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "deploy"
      min_length  = 1
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-._\\(\\)]+$/"
    }
    sql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    mssql_server = {
      name        = substr(join("-", compact([local.prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sql", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sql"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    mssql_database = {
      name        = substr(join("-", compact([local.prefix, "sqldb", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqldb", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqldb"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    sql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlep", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    mssql_elasticpool = {
      name        = substr(join("-", compact([local.prefix, "sqlep", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlep", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlep"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$/"
    }
    sql_failover_group = {
      name        = substr(join("-", compact([local.prefix, "sqlfg", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sqlfg", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sqlfg"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-z0-9][a-z0-9-]+[a-z0-9]$/"
    }
    sql_firewall_rule = {
      name        = substr(join("-", compact([local.prefix, "sqlfw", local.suffix])), 0, 128)
      name_unique = substr(join("-", compact([local.prefix, "sqlfw", local.suffix_unique])), 0, 128)
      dashes      = true
      slug        = "sqlfw"
      min_length  = 1
      max_length  = 128
      scope       = "parent"
      regex       = "/^[^<>*%:?\\+\\/]+[^<>*%:.?\\+\\/]$/"
    }
    log_analytics_workspace = {
      name        = substr(join("-", compact([local.prefix, "log", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "log", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "log"
      min_length  = 4
      max_length  = 63
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    service_fabric_cluster = {
      name        = substr(join("-", compact([local.prefix, "sf", local.suffix])), 0, 23)
      name_unique = substr(join("-", compact([local.prefix, "sf", local.suffix_unique])), 0, 23)
      dashes      = true
      slug        = "sf"
      min_length  = 4
      max_length  = 23
      scope       = "region"
      regex       = "/^[a-z][a-z0-9-]+[a-z0-9]$/"
    }
    maps_account = {
      name        = substr(join("-", compact([local.prefix, "map", local.suffix])), 0, 98)
      name_unique = substr(join("-", compact([local.prefix, "map", local.suffix_unique])), 0, 98)
      dashes      = true
      slug        = "map"
      min_length  = 1
      max_length  = 98
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+$/"
    }
    network_watcher = {
      name        = substr(join("-", compact([local.prefix, "nw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nw", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nw"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    resource_group = {
      name        = substr(join("-", compact([local.prefix, "rg", local.suffix])), 0, 90)
      name_unique = substr(join("-", compact([local.prefix, "rg", local.suffix_unique])), 0, 90)
      dashes      = true
      slug        = "rg"
      min_length  = 1
      max_length  = 90
      scope       = "subscription"
      regex       = "/^[a-zA-Z0-9-._\\(\\)]+[a-zA-Z0-9-_\\(\\)]$/"
    }
    network_security_group = {
      name        = substr(join("-", compact([local.prefix, "nsg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    network_security_group_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsgr", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    network_security_rule = {
      name        = substr(join("-", compact([local.prefix, "nsgr", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "nsgr", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsgr"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    application_security_group = {
      name        = substr(join("-", compact([local.prefix, "asg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "asg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "asg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_zone = {
      name        = substr(join("-", compact([local.prefix, "dns", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "dns", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "dns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_zone = {
      name        = substr(join("-", compact([local.prefix, "pdns", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pdns", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pdns"
      min_length  = 1
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    notification_hub = {
      name        = substr(join("-", compact([local.prefix, "nh", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "nh", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "nh"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+$/"
    }
    notification_hub_namespace = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    notification_hub_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 256)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 256)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 256
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+$/"
    }
    servicebus_namespace = {
      name        = substr(join("-", compact([local.prefix, "sb", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sb", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sb"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    servicebus_namespace_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    servicebus_queue = {
      name        = substr(join("-", compact([local.prefix, "sbq", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "sbq", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "sbq"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._\\/\\]+[a-zA-Z0-9_]$/"
    }
    servicebus_queue_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "sbqar", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbqar", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbqar"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    servicebus_subscription = {
      name        = substr(join("-", compact([local.prefix, "sbs", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbs", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbs"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    servicebus_subscription_rule = {
      name        = substr(join("-", compact([local.prefix, "sbsr", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "sbsr", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "sbsr"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    servicebus_topic = {
      name        = substr(join("-", compact([local.prefix, "sbt", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "sbt", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "sbt"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._\\/\\]+[a-zA-Z0-9]$/"
    }
    servicebus_topic_authorization_rule = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    powerbi_embedded = {
      name        = substr(join("-", compact([local.prefix, "pbi", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "pbi", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pbi"
      min_length  = 3
      max_length  = 63
      scope       = "region"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+$/"
    }
    dashboard = {
      name        = substr(join("-", compact([local.prefix, "dsb", local.suffix])), 0, 160)
      name_unique = substr(join("-", compact([local.prefix, "dsb", local.suffix_unique])), 0, 160)
      dashes      = true
      slug        = "dsb"
      min_length  = 3
      max_length  = 160
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    signalr_service = {
      name        = substr(join("-", compact([local.prefix, "sgnlr", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.prefix, "sgnlr", local.suffix_unique])), 0, 63)
      dashes      = true
      slug        = "sgnlr"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    eventgrid_domain = {
      name        = substr(join("-", compact([local.prefix, "egd", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egd", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egd"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    eventgrid_domain_topic = {
      name        = substr(join("-", compact([local.prefix, "egdt", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egdt", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egdt"
      min_length  = 3
      max_length  = 50
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    eventgrid_event_subscription = {
      name        = substr(join("-", compact([local.prefix, "egs", local.suffix])), 0, 64)
      name_unique = substr(join("-", compact([local.prefix, "egs", local.suffix_unique])), 0, 64)
      dashes      = true
      slug        = "egs"
      min_length  = 3
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    eventgrid_topic = {
      name        = substr(join("-", compact([local.prefix, "egt", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "egt", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "egt"
      min_length  = 3
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9-]+$/"
    }
    relay_namespace = {
      name        = substr(join("-", compact([local.prefix, "rln", local.suffix])), 0, 50)
      name_unique = substr(join("-", compact([local.prefix, "rln", local.suffix_unique])), 0, 50)
      dashes      = true
      slug        = "rln"
      min_length  = 6
      max_length  = 50
      scope       = "global"
      regex       = "/^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$/"
    }
    relay_hybrid_connection = {
      name        = substr(join("-", compact([local.prefix, "rlhc", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.prefix, "rlhc", local.suffix_unique])), 0, 260)
      dashes      = true
      slug        = "rlhc"
      min_length  = 1
      max_length  = 260
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$/"
    }
    private_endpoint = {
      name        = substr(join("-", compact([local.prefix, "pe", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pe", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pe"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    private_service_connection = {
      name        = substr(join("-", compact([local.prefix, "psc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "psc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "psc"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    firewall_ip_configuration = {
      name        = substr(join("-", compact([local.prefix, "fwipconf", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwipconf", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwipconf"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    firewall_application_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwapp", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwapp", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwapp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    firewall_nat_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwnatrc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwnatrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    firewall_network_rule_collection = {
      name        = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "fwnetrc", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "fwnetrc"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_caa_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_ns_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "dnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "dnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "dnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_a_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_aaaa_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_cname_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_mx_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_ptr_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_srv_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_txt_record = {
      name        = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnsrec", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnsrec"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    virtual_machine_extension = {
      name        = substr(join("-", compact([local.prefix, "vmx", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vmx", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vmx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    virtual_machine_scale_set_extension = {
      name        = substr(join("-", compact([local.prefix, "vmssx", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "vmssx", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "vmssx"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    network_ddos_protection_plan = {
      name        = substr(join("-", compact([local.prefix, "ddospp", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ddospp", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ddospp"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_dns_zone_group = {
      name        = substr(join("-", compact([local.prefix, "pdnszg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pdnszg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pdnszg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$/"
    }
    proximity_placement_group = {
      name        = substr(join("-", compact([local.prefix, "ppg", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "ppg", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "ppg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
    private_link_service = {
      name        = substr(join("-", compact([local.prefix, "pls", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.prefix, "pls", local.suffix_unique])), 0, 80)
      dashes      = true
      slug        = "pls"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "/^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$/"
    }
  }
  validation = {
    analysis_services_server = {
      // valid_name        = regex(local.az.analysis_services_server.regex, local.az.analysis_services_server.name)
      valid_name_unique = regex(local.az.analysis_services_server.regex, local.az.analysis_services_server.name_unique)
    }
    api_managment_service = {
      // valid_name        = regex(local.az.api_managment_service.regex, local.az.api_managment_service.name)
      valid_name_unique = regex(local.az.api_managment_service.regex, local.az.api_managment_service.name_unique)
    }
    app_configuration = {
      // valid_name        = regex(local.az.app_configuration.regex, local.az.app_configuration.name)
      valid_name_unique = regex(local.az.app_configuration.regex, local.az.app_configuration.name_unique)
    }
    role_assignment = {
      // valid_name        = regex(local.az.role_assignment.regex, local.az.role_assignment.name)
      valid_name_unique = regex(local.az.role_assignment.regex, local.az.role_assignment.name_unique)
    }
    role_definition = {
      // valid_name        = regex(local.az.role_definition.regex, local.az.role_definition.name)
      valid_name_unique = regex(local.az.role_definition.regex, local.az.role_definition.name_unique)
    }
    automation_account = {
      // valid_name        = regex(local.az.automation_account.regex, local.az.automation_account.name)
      valid_name_unique = regex(local.az.automation_account.regex, local.az.automation_account.name_unique)
    }
    automation_certificate = {
      // valid_name        = regex(local.az.automation_certificate.regex, local.az.automation_certificate.name)
      valid_name_unique = regex(local.az.automation_certificate.regex, local.az.automation_certificate.name_unique)
    }
    automation_credential = {
      // valid_name        = regex(local.az.automation_credential.regex, local.az.automation_credential.name)
      valid_name_unique = regex(local.az.automation_credential.regex, local.az.automation_credential.name_unique)
    }
    automation_runbook = {
      // valid_name        = regex(local.az.automation_runbook.regex, local.az.automation_runbook.name)
      valid_name_unique = regex(local.az.automation_runbook.regex, local.az.automation_runbook.name_unique)
    }
    automation_schedule = {
      // valid_name        = regex(local.az.automation_schedule.regex, local.az.automation_schedule.name)
      valid_name_unique = regex(local.az.automation_schedule.regex, local.az.automation_schedule.name_unique)
    }
    automation_variable = {
      // valid_name        = regex(local.az.automation_variable.regex, local.az.automation_variable.name)
      valid_name_unique = regex(local.az.automation_variable.regex, local.az.automation_variable.name_unique)
    }
    batch_account = {
      // valid_name        = regex(local.az.batch_account.regex, local.az.batch_account.name)
      valid_name_unique = regex(local.az.batch_account.regex, local.az.batch_account.name_unique)
    }
    batch_application = {
      // valid_name        = regex(local.az.batch_application.regex, local.az.batch_application.name)
      valid_name_unique = regex(local.az.batch_application.regex, local.az.batch_application.name_unique)
    }
    batch_certificate = {
      // valid_name        = regex(local.az.batch_certificate.regex, local.az.batch_certificate.name)
      valid_name_unique = regex(local.az.batch_certificate.regex, local.az.batch_certificate.name_unique)
    }
    batch_pool = {
      // valid_name        = regex(local.az.batch_pool.regex, local.az.batch_pool.name)
      valid_name_unique = regex(local.az.batch_pool.regex, local.az.batch_pool.name_unique)
    }
    bot_web_app = {
      // valid_name        = regex(local.az.bot_web_app.regex, local.az.bot_web_app.name)
      valid_name_unique = regex(local.az.bot_web_app.regex, local.az.bot_web_app.name_unique)
    }
    bot_channel_Email = {
      // valid_name        = regex(local.az.bot_channel_Email.regex, local.az.bot_channel_Email.name)
      valid_name_unique = regex(local.az.bot_channel_Email.regex, local.az.bot_channel_Email.name_unique)
    }
    bot_channel_ms_teams = {
      // valid_name        = regex(local.az.bot_channel_ms_teams.regex, local.az.bot_channel_ms_teams.name)
      valid_name_unique = regex(local.az.bot_channel_ms_teams.regex, local.az.bot_channel_ms_teams.name_unique)
    }
    bot_channel_slack = {
      // valid_name        = regex(local.az.bot_channel_slack.regex, local.az.bot_channel_slack.name)
      valid_name_unique = regex(local.az.bot_channel_slack.regex, local.az.bot_channel_slack.name_unique)
    }
    bot_channel_directline = {
      // valid_name        = regex(local.az.bot_channel_directline.regex, local.az.bot_channel_directline.name)
      valid_name_unique = regex(local.az.bot_channel_directline.regex, local.az.bot_channel_directline.name_unique)
    }
    bot_channels_registration = {
      // valid_name        = regex(local.az.bot_channels_registration.regex, local.az.bot_channels_registration.name)
      valid_name_unique = regex(local.az.bot_channels_registration.regex, local.az.bot_channels_registration.name_unique)
    }
    bot_connection = {
      // valid_name        = regex(local.az.bot_connection.regex, local.az.bot_connection.name)
      valid_name_unique = regex(local.az.bot_connection.regex, local.az.bot_connection.name_unique)
    }
    redis_cache = {
      // valid_name        = regex(local.az.redis_cache.regex, local.az.redis_cache.name)
      valid_name_unique = regex(local.az.redis_cache.regex, local.az.redis_cache.name_unique)
    }
    redis_firewall_rule = {
      // valid_name        = regex(local.az.redis_firewall_rule.regex, local.az.redis_firewall_rule.name)
      valid_name_unique = regex(local.az.redis_firewall_rule.regex, local.az.redis_firewall_rule.name_unique)
    }
    cdn_profile = {
      // valid_name        = regex(local.az.cdn_profile.regex, local.az.cdn_profile.name)
      valid_name_unique = regex(local.az.cdn_profile.regex, local.az.cdn_profile.name_unique)
    }
    cdn_endpoint = {
      // valid_name        = regex(local.az.cdn_endpoint.regex, local.az.cdn_endpoint.name)
      valid_name_unique = regex(local.az.cdn_endpoint.regex, local.az.cdn_endpoint.name_unique)
    }
    cognitive_account = {
      // valid_name        = regex(local.az.cognitive_account.regex, local.az.cognitive_account.name)
      valid_name_unique = regex(local.az.cognitive_account.regex, local.az.cognitive_account.name_unique)
    }
    availability_set = {
      // valid_name        = regex(local.az.availability_set.regex, local.az.availability_set.name)
      valid_name_unique = regex(local.az.availability_set.regex, local.az.availability_set.name_unique)
    }
    disk_encryption_set = {
      // valid_name        = regex(local.az.disk_encryption_set.regex, local.az.disk_encryption_set.name)
      valid_name_unique = regex(local.az.disk_encryption_set.regex, local.az.disk_encryption_set.name_unique)
    }
    image = {
      // valid_name        = regex(local.az.image.regex, local.az.image.name)
      valid_name_unique = regex(local.az.image.regex, local.az.image.name_unique)
    }
    linux_virtual_machine = {
      // valid_name        = regex(local.az.linux_virtual_machine.regex, local.az.linux_virtual_machine.name)
      valid_name_unique = regex(local.az.linux_virtual_machine.regex, local.az.linux_virtual_machine.name_unique)
    }
    linux_virtual_machine_scale_set = {
      // valid_name        = regex(local.az.linux_virtual_machine_scale_set.regex, local.az.linux_virtual_machine_scale_set.name)
      valid_name_unique = regex(local.az.linux_virtual_machine_scale_set.regex, local.az.linux_virtual_machine_scale_set.name_unique)
    }
    managed_disk = {
      // valid_name        = regex(local.az.managed_disk.regex, local.az.managed_disk.name)
      valid_name_unique = regex(local.az.managed_disk.regex, local.az.managed_disk.name_unique)
    }
    virtual_machine = {
      // valid_name        = regex(local.az.virtual_machine.regex, local.az.virtual_machine.name)
      valid_name_unique = regex(local.az.virtual_machine.regex, local.az.virtual_machine.name_unique)
    }
    virtual_machine_scale_set = {
      // valid_name        = regex(local.az.virtual_machine_scale_set.regex, local.az.virtual_machine_scale_set.name)
      valid_name_unique = regex(local.az.virtual_machine_scale_set.regex, local.az.virtual_machine_scale_set.name_unique)
    }
    windows_virtual_machine = {
      // valid_name        = regex(local.az.windows_virtual_machine.regex, local.az.windows_virtual_machine.name)
      valid_name_unique = regex(local.az.windows_virtual_machine.regex, local.az.windows_virtual_machine.name_unique)
    }
    windows_virtual_machine_scale_set = {
      // valid_name        = regex(local.az.windows_virtual_machine_scale_set.regex, local.az.windows_virtual_machine_scale_set.name)
      valid_name_unique = regex(local.az.windows_virtual_machine_scale_set.regex, local.az.windows_virtual_machine_scale_set.name_unique)
    }
    containerGroups = {
      // valid_name        = regex(local.az.containerGroups.regex, local.az.containerGroups.name)
      valid_name_unique = regex(local.az.containerGroups.regex, local.az.containerGroups.name_unique)
    }
    container_registry = {
      // valid_name        = regex(local.az.container_registry.regex, local.az.container_registry.name)
      valid_name_unique = regex(local.az.container_registry.regex, local.az.container_registry.name_unique)
    }
    container_registry_webhook = {
      // valid_name        = regex(local.az.container_registry_webhook.regex, local.az.container_registry_webhook.name)
      valid_name_unique = regex(local.az.container_registry_webhook.regex, local.az.container_registry_webhook.name_unique)
    }
    kubernetes_cluster = {
      // valid_name        = regex(local.az.kubernetes_cluster.regex, local.az.kubernetes_cluster.name)
      valid_name_unique = regex(local.az.kubernetes_cluster.regex, local.az.kubernetes_cluster.name_unique)
    }
    cosmosdb_account = {
      // valid_name        = regex(local.az.cosmosdb_account.regex, local.az.cosmosdb_account.name)
      valid_name_unique = regex(local.az.cosmosdb_account.regex, local.az.cosmosdb_account.name_unique)
    }
    custom_provider = {
      // valid_name        = regex(local.az.custom_provider.regex, local.az.custom_provider.name)
      valid_name_unique = regex(local.az.custom_provider.regex, local.az.custom_provider.name_unique)
    }
    mariadb_server = {
      // valid_name        = regex(local.az.mariadb_server.regex, local.az.mariadb_server.name)
      valid_name_unique = regex(local.az.mariadb_server.regex, local.az.mariadb_server.name_unique)
    }
    mariadb_firewall_rule = {
      // valid_name        = regex(local.az.mariadb_firewall_rule.regex, local.az.mariadb_firewall_rule.name)
      valid_name_unique = regex(local.az.mariadb_firewall_rule.regex, local.az.mariadb_firewall_rule.name_unique)
    }
    mariadb_database = {
      // valid_name        = regex(local.az.mariadb_database.regex, local.az.mariadb_database.name)
      valid_name_unique = regex(local.az.mariadb_database.regex, local.az.mariadb_database.name_unique)
    }
    mariadb_virtual_network_rule = {
      // valid_name        = regex(local.az.mariadb_virtual_network_rule.regex, local.az.mariadb_virtual_network_rule.name)
      valid_name_unique = regex(local.az.mariadb_virtual_network_rule.regex, local.az.mariadb_virtual_network_rule.name_unique)
    }
    mysql_server = {
      // valid_name        = regex(local.az.mysql_server.regex, local.az.mysql_server.name)
      valid_name_unique = regex(local.az.mysql_server.regex, local.az.mysql_server.name_unique)
    }
    mysql_firewall_rule = {
      // valid_name        = regex(local.az.mysql_firewall_rule.regex, local.az.mysql_firewall_rule.name)
      valid_name_unique = regex(local.az.mysql_firewall_rule.regex, local.az.mysql_firewall_rule.name_unique)
    }
    mysql_database = {
      // valid_name        = regex(local.az.mysql_database.regex, local.az.mysql_database.name)
      valid_name_unique = regex(local.az.mysql_database.regex, local.az.mysql_database.name_unique)
    }
    mysql_virtual_network_rule = {
      // valid_name        = regex(local.az.mysql_virtual_network_rule.regex, local.az.mysql_virtual_network_rule.name)
      valid_name_unique = regex(local.az.mysql_virtual_network_rule.regex, local.az.mysql_virtual_network_rule.name_unique)
    }
    postgresql_server = {
      // valid_name        = regex(local.az.postgresql_server.regex, local.az.postgresql_server.name)
      valid_name_unique = regex(local.az.postgresql_server.regex, local.az.postgresql_server.name_unique)
    }
    postgresql_firewall_rule = {
      // valid_name        = regex(local.az.postgresql_firewall_rule.regex, local.az.postgresql_firewall_rule.name)
      valid_name_unique = regex(local.az.postgresql_firewall_rule.regex, local.az.postgresql_firewall_rule.name_unique)
    }
    postgresql_database = {
      // valid_name        = regex(local.az.postgresql_database.regex, local.az.postgresql_database.name)
      valid_name_unique = regex(local.az.postgresql_database.regex, local.az.postgresql_database.name_unique)
    }
    postgresql_virtual_network_rule = {
      // valid_name        = regex(local.az.postgresql_virtual_network_rule.regex, local.az.postgresql_virtual_network_rule.name)
      valid_name_unique = regex(local.az.postgresql_virtual_network_rule.regex, local.az.postgresql_virtual_network_rule.name_unique)
    }
    database_migration_project = {
      // valid_name        = regex(local.az.database_migration_project.regex, local.az.database_migration_project.name)
      valid_name_unique = regex(local.az.database_migration_project.regex, local.az.database_migration_project.name_unique)
    }
    database_migration_service = {
      // valid_name        = regex(local.az.database_migration_service.regex, local.az.database_migration_service.name)
      valid_name_unique = regex(local.az.database_migration_service.regex, local.az.database_migration_service.name_unique)
    }
    databricks_workspace = {
      // valid_name        = regex(local.az.databricks_workspace.regex, local.az.databricks_workspace.name)
      valid_name_unique = regex(local.az.databricks_workspace.regex, local.az.databricks_workspace.name_unique)
    }
    kusto_cluster = {
      // valid_name        = regex(local.az.kusto_cluster.regex, local.az.kusto_cluster.name)
      valid_name_unique = regex(local.az.kusto_cluster.regex, local.az.kusto_cluster.name_unique)
    }
    kusto_database = {
      // valid_name        = regex(local.az.kusto_database.regex, local.az.kusto_database.name)
      valid_name_unique = regex(local.az.kusto_database.regex, local.az.kusto_database.name_unique)
    }
    kusto_eventhub_data_connection = {
      // valid_name        = regex(local.az.kusto_eventhub_data_connection.regex, local.az.kusto_eventhub_data_connection.name)
      valid_name_unique = regex(local.az.kusto_eventhub_data_connection.regex, local.az.kusto_eventhub_data_connection.name_unique)
    }
    data_factory = {
      // valid_name        = regex(local.az.data_factory.regex, local.az.data_factory.name)
      valid_name_unique = regex(local.az.data_factory.regex, local.az.data_factory.name_unique)
    }
    data_factory_dataset_mysql = {
      // valid_name        = regex(local.az.data_factory_dataset_mysql.regex, local.az.data_factory_dataset_mysql.name)
      valid_name_unique = regex(local.az.data_factory_dataset_mysql.regex, local.az.data_factory_dataset_mysql.name_unique)
    }
    data_factory_dataset_postgresql = {
      // valid_name        = regex(local.az.data_factory_dataset_postgresql.regex, local.az.data_factory_dataset_postgresql.name)
      valid_name_unique = regex(local.az.data_factory_dataset_postgresql.regex, local.az.data_factory_dataset_postgresql.name_unique)
    }
    data_factory_dataset_sql_server_table = {
      // valid_name        = regex(local.az.data_factory_dataset_sql_server_table.regex, local.az.data_factory_dataset_sql_server_table.name)
      valid_name_unique = regex(local.az.data_factory_dataset_sql_server_table.regex, local.az.data_factory_dataset_sql_server_table.name_unique)
    }
    data_factory_integration_runtime_managed = {
      // valid_name        = regex(local.az.data_factory_integration_runtime_managed.regex, local.az.data_factory_integration_runtime_managed.name)
      valid_name_unique = regex(local.az.data_factory_integration_runtime_managed.regex, local.az.data_factory_integration_runtime_managed.name_unique)
    }
    data_factory_pipeline = {
      // valid_name        = regex(local.az.data_factory_pipeline.regex, local.az.data_factory_pipeline.name)
      valid_name_unique = regex(local.az.data_factory_pipeline.regex, local.az.data_factory_pipeline.name_unique)
    }
    data_factory_linked_service_data_lake_storage_gen2 = {
      // valid_name        = regex(local.az.data_factory_linked_service_data_lake_storage_gen2.regex, local.az.data_factory_linked_service_data_lake_storage_gen2.name)
      valid_name_unique = regex(local.az.data_factory_linked_service_data_lake_storage_gen2.regex, local.az.data_factory_linked_service_data_lake_storage_gen2.name_unique)
    }
    data_factory_linked_service_key_vault = {
      // valid_name        = regex(local.az.data_factory_linked_service_key_vault.regex, local.az.data_factory_linked_service_key_vault.name)
      valid_name_unique = regex(local.az.data_factory_linked_service_key_vault.regex, local.az.data_factory_linked_service_key_vault.name_unique)
    }
    data_factory_linked_service_mysql = {
      // valid_name        = regex(local.az.data_factory_linked_service_mysql.regex, local.az.data_factory_linked_service_mysql.name)
      valid_name_unique = regex(local.az.data_factory_linked_service_mysql.regex, local.az.data_factory_linked_service_mysql.name_unique)
    }
    data_factory_linked_service_postgresql = {
      // valid_name        = regex(local.az.data_factory_linked_service_postgresql.regex, local.az.data_factory_linked_service_postgresql.name)
      valid_name_unique = regex(local.az.data_factory_linked_service_postgresql.regex, local.az.data_factory_linked_service_postgresql.name_unique)
    }
    data_factory_linked_service_sql_server = {
      // valid_name        = regex(local.az.data_factory_linked_service_sql_server.regex, local.az.data_factory_linked_service_sql_server.name)
      valid_name_unique = regex(local.az.data_factory_linked_service_sql_server.regex, local.az.data_factory_linked_service_sql_server.name_unique)
    }
    data_factory_trigger_schedule = {
      // valid_name        = regex(local.az.data_factory_trigger_schedule.regex, local.az.data_factory_trigger_schedule.name)
      valid_name_unique = regex(local.az.data_factory_trigger_schedule.regex, local.az.data_factory_trigger_schedule.name_unique)
    }
    data_lake_analytics_account = {
      // valid_name        = regex(local.az.data_lake_analytics_account.regex, local.az.data_lake_analytics_account.name)
      valid_name_unique = regex(local.az.data_lake_analytics_account.regex, local.az.data_lake_analytics_account.name_unique)
    }
    data_lake_analytics_firewall_rule = {
      // valid_name        = regex(local.az.data_lake_analytics_firewall_rule.regex, local.az.data_lake_analytics_firewall_rule.name)
      valid_name_unique = regex(local.az.data_lake_analytics_firewall_rule.regex, local.az.data_lake_analytics_firewall_rule.name_unique)
    }
    data_lake_store = {
      // valid_name        = regex(local.az.data_lake_store.regex, local.az.data_lake_store.name)
      valid_name_unique = regex(local.az.data_lake_store.regex, local.az.data_lake_store.name_unique)
    }
    data_lake_store_firewall_rule = {
      // valid_name        = regex(local.az.data_lake_store_firewall_rule.regex, local.az.data_lake_store_firewall_rule.name)
      valid_name_unique = regex(local.az.data_lake_store_firewall_rule.regex, local.az.data_lake_store_firewall_rule.name_unique)
    }
    dev_test_lab = {
      // valid_name        = regex(local.az.dev_test_lab.regex, local.az.dev_test_lab.name)
      valid_name_unique = regex(local.az.dev_test_lab.regex, local.az.dev_test_lab.name_unique)
    }
    dev_test_linux_virtual_machine = {
      // valid_name        = regex(local.az.dev_test_linux_virtual_machine.regex, local.az.dev_test_linux_virtual_machine.name)
      valid_name_unique = regex(local.az.dev_test_linux_virtual_machine.regex, local.az.dev_test_linux_virtual_machine.name_unique)
    }
    dev_test_windows_virtual_machine = {
      // valid_name        = regex(local.az.dev_test_windows_virtual_machine.regex, local.az.dev_test_windows_virtual_machine.name)
      valid_name_unique = regex(local.az.dev_test_windows_virtual_machine.regex, local.az.dev_test_windows_virtual_machine.name_unique)
    }
    frontdoor = {
      // valid_name        = regex(local.az.frontdoor.regex, local.az.frontdoor.name)
      valid_name_unique = regex(local.az.frontdoor.regex, local.az.frontdoor.name_unique)
    }
    frontdoor_firewall_policy = {
      // valid_name        = regex(local.az.frontdoor_firewall_policy.regex, local.az.frontdoor_firewall_policy.name)
      valid_name_unique = regex(local.az.frontdoor_firewall_policy.regex, local.az.frontdoor_firewall_policy.name_unique)
    }
    hdinsight_hadoop_cluster = {
      // valid_name        = regex(local.az.hdinsight_hadoop_cluster.regex, local.az.hdinsight_hadoop_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_hadoop_cluster.regex, local.az.hdinsight_hadoop_cluster.name_unique)
    }
    hdinsight_hbase_cluster = {
      // valid_name        = regex(local.az.hdinsight_hbase_cluster.regex, local.az.hdinsight_hbase_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_hbase_cluster.regex, local.az.hdinsight_hbase_cluster.name_unique)
    }
    hdinsight_kafka_cluster = {
      // valid_name        = regex(local.az.hdinsight_kafka_cluster.regex, local.az.hdinsight_kafka_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_kafka_cluster.regex, local.az.hdinsight_kafka_cluster.name_unique)
    }
    hdinsight_interactive_query_cluster = {
      // valid_name        = regex(local.az.hdinsight_interactive_query_cluster.regex, local.az.hdinsight_interactive_query_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_interactive_query_cluster.regex, local.az.hdinsight_interactive_query_cluster.name_unique)
    }
    hdinsight_ml_services_cluster = {
      // valid_name        = regex(local.az.hdinsight_ml_services_cluster.regex, local.az.hdinsight_ml_services_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_ml_services_cluster.regex, local.az.hdinsight_ml_services_cluster.name_unique)
    }
    hdinsight_rserver_cluster = {
      // valid_name        = regex(local.az.hdinsight_rserver_cluster.regex, local.az.hdinsight_rserver_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_rserver_cluster.regex, local.az.hdinsight_rserver_cluster.name_unique)
    }
    hdinsight_spark_cluster = {
      // valid_name        = regex(local.az.hdinsight_spark_cluster.regex, local.az.hdinsight_spark_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_spark_cluster.regex, local.az.hdinsight_spark_cluster.name_unique)
    }
    hdinsight_storm_cluster = {
      // valid_name        = regex(local.az.hdinsight_storm_cluster.regex, local.az.hdinsight_storm_cluster.name)
      valid_name_unique = regex(local.az.hdinsight_storm_cluster.regex, local.az.hdinsight_storm_cluster.name_unique)
    }
    iotcentral_application = {
      // valid_name        = regex(local.az.iotcentral_application.regex, local.az.iotcentral_application.name)
      valid_name_unique = regex(local.az.iotcentral_application.regex, local.az.iotcentral_application.name_unique)
    }
    iothub = {
      // valid_name        = regex(local.az.iothub.regex, local.az.iothub.name)
      valid_name_unique = regex(local.az.iothub.regex, local.az.iothub.name_unique)
    }
    iothub_consumer_group = {
      // valid_name        = regex(local.az.iothub_consumer_group.regex, local.az.iothub_consumer_group.name)
      valid_name_unique = regex(local.az.iothub_consumer_group.regex, local.az.iothub_consumer_group.name_unique)
    }
    iothub_dps = {
      // valid_name        = regex(local.az.iothub_dps.regex, local.az.iothub_dps.name)
      valid_name_unique = regex(local.az.iothub_dps.regex, local.az.iothub_dps.name_unique)
    }
    iothub_dps_certificate = {
      // valid_name        = regex(local.az.iothub_dps_certificate.regex, local.az.iothub_dps_certificate.name)
      valid_name_unique = regex(local.az.iothub_dps_certificate.regex, local.az.iothub_dps_certificate.name_unique)
    }
    key_vault = {
      // valid_name        = regex(local.az.key_vault.regex, local.az.key_vault.name)
      valid_name_unique = regex(local.az.key_vault.regex, local.az.key_vault.name_unique)
    }
    key_vault_key = {
      // valid_name        = regex(local.az.key_vault_key.regex, local.az.key_vault_key.name)
      valid_name_unique = regex(local.az.key_vault_key.regex, local.az.key_vault_key.name_unique)
    }
    key_vault_secret = {
      // valid_name        = regex(local.az.key_vault_secret.regex, local.az.key_vault_secret.name)
      valid_name_unique = regex(local.az.key_vault_secret.regex, local.az.key_vault_secret.name_unique)
    }
    key_vault_certificate = {
      // valid_name        = regex(local.az.key_vault_certificate.regex, local.az.key_vault_certificate.name)
      valid_name_unique = regex(local.az.key_vault_certificate.regex, local.az.key_vault_certificate.name_unique)
    }
    lb = {
      // valid_name        = regex(local.az.lb.regex, local.az.lb.name)
      valid_name_unique = regex(local.az.lb.regex, local.az.lb.name_unique)
    }
    lb_nat_rule = {
      // valid_name        = regex(local.az.lb_nat_rule.regex, local.az.lb_nat_rule.name)
      valid_name_unique = regex(local.az.lb_nat_rule.regex, local.az.lb_nat_rule.name_unique)
    }
    public_ip = {
      // valid_name        = regex(local.az.public_ip.regex, local.az.public_ip.name)
      valid_name_unique = regex(local.az.public_ip.regex, local.az.public_ip.name_unique)
    }
    public_ip_prefix = {
      // valid_name        = regex(local.az.public_ip_prefix.regex, local.az.public_ip_prefix.name)
      valid_name_unique = regex(local.az.public_ip_prefix.regex, local.az.public_ip_prefix.name_unique)
    }
    route = {
      // valid_name        = regex(local.az.route.regex, local.az.route.name)
      valid_name_unique = regex(local.az.route.regex, local.az.route.name_unique)
    }
    route_table = {
      // valid_name        = regex(local.az.route_table.regex, local.az.route_table.name)
      valid_name_unique = regex(local.az.route_table.regex, local.az.route_table.name_unique)
    }
    subnet = {
      // valid_name        = regex(local.az.subnet.regex, local.az.subnet.name)
      valid_name_unique = regex(local.az.subnet.regex, local.az.subnet.name_unique)
    }
    traffic_manager_profile = {
      // valid_name        = regex(local.az.traffic_manager_profile.regex, local.az.traffic_manager_profile.name)
      valid_name_unique = regex(local.az.traffic_manager_profile.regex, local.az.traffic_manager_profile.name_unique)
    }
    virtual_wan = {
      // valid_name        = regex(local.az.virtual_wan.regex, local.az.virtual_wan.name)
      valid_name_unique = regex(local.az.virtual_wan.regex, local.az.virtual_wan.name_unique)
    }
    virtual_network = {
      // valid_name        = regex(local.az.virtual_network.regex, local.az.virtual_network.name)
      valid_name_unique = regex(local.az.virtual_network.regex, local.az.virtual_network.name_unique)
    }
    virtual_network_gateway = {
      // valid_name        = regex(local.az.virtual_network_gateway.regex, local.az.virtual_network_gateway.name)
      valid_name_unique = regex(local.az.virtual_network_gateway.regex, local.az.virtual_network_gateway.name_unique)
    }
    virtual_network_peering = {
      // valid_name        = regex(local.az.virtual_network_peering.regex, local.az.virtual_network_peering.name)
      valid_name_unique = regex(local.az.virtual_network_peering.regex, local.az.virtual_network_peering.name_unique)
    }
    network_interface = {
      // valid_name        = regex(local.az.network_interface.regex, local.az.network_interface.name)
      valid_name_unique = regex(local.az.network_interface.regex, local.az.network_interface.name_unique)
    }
    firewall = {
      // valid_name        = regex(local.az.firewall.regex, local.az.firewall.name)
      valid_name_unique = regex(local.az.firewall.regex, local.az.firewall.name_unique)
    }
    eventhub = {
      // valid_name        = regex(local.az.eventhub.regex, local.az.eventhub.name)
      valid_name_unique = regex(local.az.eventhub.regex, local.az.eventhub.name_unique)
    }
    eventhub_namespace = {
      // valid_name        = regex(local.az.eventhub_namespace.regex, local.az.eventhub_namespace.name)
      valid_name_unique = regex(local.az.eventhub_namespace.regex, local.az.eventhub_namespace.name_unique)
    }
    eventhub_authorization_rule = {
      // valid_name        = regex(local.az.eventhub_authorization_rule.regex, local.az.eventhub_authorization_rule.name)
      valid_name_unique = regex(local.az.eventhub_authorization_rule.regex, local.az.eventhub_authorization_rule.name_unique)
    }
    eventhub_namespace_authorization_rule = {
      // valid_name        = regex(local.az.eventhub_namespace_authorization_rule.regex, local.az.eventhub_namespace_authorization_rule.name)
      valid_name_unique = regex(local.az.eventhub_namespace_authorization_rule.regex, local.az.eventhub_namespace_authorization_rule.name_unique)
    }
    eventhub_namespace_disaster_recovery_config = {
      // valid_name        = regex(local.az.eventhub_namespace_disaster_recovery_config.regex, local.az.eventhub_namespace_disaster_recovery_config.name)
      valid_name_unique = regex(local.az.eventhub_namespace_disaster_recovery_config.regex, local.az.eventhub_namespace_disaster_recovery_config.name_unique)
    }
    eventhub_consumer_group = {
      // valid_name        = regex(local.az.eventhub_consumer_group.regex, local.az.eventhub_consumer_group.name)
      valid_name_unique = regex(local.az.eventhub_consumer_group.regex, local.az.eventhub_consumer_group.name_unique)
    }
    stream_analytics_job = {
      // valid_name        = regex(local.az.stream_analytics_job.regex, local.az.stream_analytics_job.name)
      valid_name_unique = regex(local.az.stream_analytics_job.regex, local.az.stream_analytics_job.name_unique)
    }
    stream_analytics_function_javascript_udf = {
      // valid_name        = regex(local.az.stream_analytics_function_javascript_udf.regex, local.az.stream_analytics_function_javascript_udf.name)
      valid_name_unique = regex(local.az.stream_analytics_function_javascript_udf.regex, local.az.stream_analytics_function_javascript_udf.name_unique)
    }
    stream_analytics_output_blob = {
      // valid_name        = regex(local.az.stream_analytics_output_blob.regex, local.az.stream_analytics_output_blob.name)
      valid_name_unique = regex(local.az.stream_analytics_output_blob.regex, local.az.stream_analytics_output_blob.name_unique)
    }
    stream_analytics_output_mssql = {
      // valid_name        = regex(local.az.stream_analytics_output_mssql.regex, local.az.stream_analytics_output_mssql.name)
      valid_name_unique = regex(local.az.stream_analytics_output_mssql.regex, local.az.stream_analytics_output_mssql.name_unique)
    }
    stream_analytics_output_eventhub = {
      // valid_name        = regex(local.az.stream_analytics_output_eventhub.regex, local.az.stream_analytics_output_eventhub.name)
      valid_name_unique = regex(local.az.stream_analytics_output_eventhub.regex, local.az.stream_analytics_output_eventhub.name_unique)
    }
    stream_analytics_output_servicebus_queue = {
      // valid_name        = regex(local.az.stream_analytics_output_servicebus_queue.regex, local.az.stream_analytics_output_servicebus_queue.name)
      valid_name_unique = regex(local.az.stream_analytics_output_servicebus_queue.regex, local.az.stream_analytics_output_servicebus_queue.name_unique)
    }
    stream_analytics_output_servicebus_topic = {
      // valid_name        = regex(local.az.stream_analytics_output_servicebus_topic.regex, local.az.stream_analytics_output_servicebus_topic.name)
      valid_name_unique = regex(local.az.stream_analytics_output_servicebus_topic.regex, local.az.stream_analytics_output_servicebus_topic.name_unique)
    }
    stream_analytics_reference_input_blob = {
      // valid_name        = regex(local.az.stream_analytics_reference_input_blob.regex, local.az.stream_analytics_reference_input_blob.name)
      valid_name_unique = regex(local.az.stream_analytics_reference_input_blob.regex, local.az.stream_analytics_reference_input_blob.name_unique)
    }
    stream_analytics_stream_input_blob = {
      // valid_name        = regex(local.az.stream_analytics_stream_input_blob.regex, local.az.stream_analytics_stream_input_blob.name)
      valid_name_unique = regex(local.az.stream_analytics_stream_input_blob.regex, local.az.stream_analytics_stream_input_blob.name_unique)
    }
    stream_analytics_stream_input_eventhub = {
      // valid_name        = regex(local.az.stream_analytics_stream_input_eventhub.regex, local.az.stream_analytics_stream_input_eventhub.name)
      valid_name_unique = regex(local.az.stream_analytics_stream_input_eventhub.regex, local.az.stream_analytics_stream_input_eventhub.name_unique)
    }
    stream_analytics_stream_input_iothub = {
      // valid_name        = regex(local.az.stream_analytics_stream_input_iothub.regex, local.az.stream_analytics_stream_input_iothub.name)
      valid_name_unique = regex(local.az.stream_analytics_stream_input_iothub.regex, local.az.stream_analytics_stream_input_iothub.name_unique)
    }
    shared_image_gallery = {
      // valid_name        = regex(local.az.shared_image_gallery.regex, local.az.shared_image_gallery.name)
      valid_name_unique = regex(local.az.shared_image_gallery.regex, local.az.shared_image_gallery.name_unique)
    }
    shared_image = {
      // valid_name        = regex(local.az.shared_image.regex, local.az.shared_image.name)
      valid_name_unique = regex(local.az.shared_image.regex, local.az.shared_image.name_unique)
    }
    snapshots = {
      // valid_name        = regex(local.az.snapshots.regex, local.az.snapshots.name)
      valid_name_unique = regex(local.az.snapshots.regex, local.az.snapshots.name_unique)
    }
    storage_account = {
      // valid_name        = regex(local.az.storage_account.regex, local.az.storage_account.name)
      valid_name_unique = regex(local.az.storage_account.regex, local.az.storage_account.name_unique)
    }
    storage_container = {
      // valid_name        = regex(local.az.storage_container.regex, local.az.storage_container.name)
      valid_name_unique = regex(local.az.storage_container.regex, local.az.storage_container.name_unique)
    }
    storage_data_lake_gen2_filesystem = {
      // valid_name        = regex(local.az.storage_data_lake_gen2_filesystem.regex, local.az.storage_data_lake_gen2_filesystem.name)
      valid_name_unique = regex(local.az.storage_data_lake_gen2_filesystem.regex, local.az.storage_data_lake_gen2_filesystem.name_unique)
    }
    storage_queue = {
      // valid_name        = regex(local.az.storage_queue.regex, local.az.storage_queue.name)
      valid_name_unique = regex(local.az.storage_queue.regex, local.az.storage_queue.name_unique)
    }
    storage_table = {
      // valid_name        = regex(local.az.storage_table.regex, local.az.storage_table.name)
      valid_name_unique = regex(local.az.storage_table.regex, local.az.storage_table.name_unique)
    }
    storage_share = {
      // valid_name        = regex(local.az.storage_share.regex, local.az.storage_share.name)
      valid_name_unique = regex(local.az.storage_share.regex, local.az.storage_share.name_unique)
    }
    storage_share_directory = {
      // valid_name        = regex(local.az.storage_share_directory.regex, local.az.storage_share_directory.name)
      valid_name_unique = regex(local.az.storage_share_directory.regex, local.az.storage_share_directory.name_unique)
    }
    machine_learning_workspace = {
      // valid_name        = regex(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name)
      valid_name_unique = regex(local.az.machine_learning_workspace.regex, local.az.machine_learning_workspace.name_unique)
    }
    storage_blob = {
      // valid_name        = regex(local.az.storage_blob.regex, local.az.storage_blob.name)
      valid_name_unique = regex(local.az.storage_blob.regex, local.az.storage_blob.name_unique)
    }
    bastion_host = {
      // valid_name        = regex(local.az.bastion_host.regex, local.az.bastion_host.name)
      valid_name_unique = regex(local.az.bastion_host.regex, local.az.bastion_host.name_unique)
    }
    local_network_gateway = {
      // valid_name        = regex(local.az.local_network_gateway.regex, local.az.local_network_gateway.name)
      valid_name_unique = regex(local.az.local_network_gateway.regex, local.az.local_network_gateway.name_unique)
    }
    application_gateway = {
      // valid_name        = regex(local.az.application_gateway.regex, local.az.application_gateway.name)
      valid_name_unique = regex(local.az.application_gateway.regex, local.az.application_gateway.name_unique)
    }
    express_route_gateway = {
      // valid_name        = regex(local.az.express_route_gateway.regex, local.az.express_route_gateway.name)
      valid_name_unique = regex(local.az.express_route_gateway.regex, local.az.express_route_gateway.name_unique)
    }
    express_route_circuit = {
      // valid_name        = regex(local.az.express_route_circuit.regex, local.az.express_route_circuit.name)
      valid_name_unique = regex(local.az.express_route_circuit.regex, local.az.express_route_circuit.name_unique)
    }
    point_to_site_vpn_gateway = {
      // valid_name        = regex(local.az.point_to_site_vpn_gateway.regex, local.az.point_to_site_vpn_gateway.name)
      valid_name_unique = regex(local.az.point_to_site_vpn_gateway.regex, local.az.point_to_site_vpn_gateway.name_unique)
    }
    template_deployment = {
      // valid_name        = regex(local.az.template_deployment.regex, local.az.template_deployment.name)
      valid_name_unique = regex(local.az.template_deployment.regex, local.az.template_deployment.name_unique)
    }
    sql_server = {
      // valid_name        = regex(local.az.sql_server.regex, local.az.sql_server.name)
      valid_name_unique = regex(local.az.sql_server.regex, local.az.sql_server.name_unique)
    }
    mssql_server = {
      // valid_name        = regex(local.az.mssql_server.regex, local.az.mssql_server.name)
      valid_name_unique = regex(local.az.mssql_server.regex, local.az.mssql_server.name_unique)
    }
    mssql_database = {
      // valid_name        = regex(local.az.mssql_database.regex, local.az.mssql_database.name)
      valid_name_unique = regex(local.az.mssql_database.regex, local.az.mssql_database.name_unique)
    }
    sql_elasticpool = {
      // valid_name        = regex(local.az.sql_elasticpool.regex, local.az.sql_elasticpool.name)
      valid_name_unique = regex(local.az.sql_elasticpool.regex, local.az.sql_elasticpool.name_unique)
    }
    mssql_elasticpool = {
      // valid_name        = regex(local.az.mssql_elasticpool.regex, local.az.mssql_elasticpool.name)
      valid_name_unique = regex(local.az.mssql_elasticpool.regex, local.az.mssql_elasticpool.name_unique)
    }
    sql_failover_group = {
      // valid_name        = regex(local.az.sql_failover_group.regex, local.az.sql_failover_group.name)
      valid_name_unique = regex(local.az.sql_failover_group.regex, local.az.sql_failover_group.name_unique)
    }
    sql_firewall_rule = {
      // valid_name        = regex(local.az.sql_firewall_rule.regex, local.az.sql_firewall_rule.name)
      valid_name_unique = regex(local.az.sql_firewall_rule.regex, local.az.sql_firewall_rule.name_unique)
    }
    log_analytics_workspace = {
      // valid_name        = regex(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name)
      valid_name_unique = regex(local.az.log_analytics_workspace.regex, local.az.log_analytics_workspace.name_unique)
    }
    service_fabric_cluster = {
      // valid_name        = regex(local.az.service_fabric_cluster.regex, local.az.service_fabric_cluster.name)
      valid_name_unique = regex(local.az.service_fabric_cluster.regex, local.az.service_fabric_cluster.name_unique)
    }
    maps_account = {
      // valid_name        = regex(local.az.maps_account.regex, local.az.maps_account.name)
      valid_name_unique = regex(local.az.maps_account.regex, local.az.maps_account.name_unique)
    }
    network_watcher = {
      // valid_name        = regex(local.az.network_watcher.regex, local.az.network_watcher.name)
      valid_name_unique = regex(local.az.network_watcher.regex, local.az.network_watcher.name_unique)
    }
    resource_group = {
      // valid_name        = regex(local.az.resource_group.regex, local.az.resource_group.name)
      valid_name_unique = regex(local.az.resource_group.regex, local.az.resource_group.name_unique)
    }
    network_security_group = {
      // valid_name        = regex(local.az.network_security_group.regex, local.az.network_security_group.name)
      valid_name_unique = regex(local.az.network_security_group.regex, local.az.network_security_group.name_unique)
    }
    network_security_group_rule = {
      // valid_name        = regex(local.az.network_security_group_rule.regex, local.az.network_security_group_rule.name)
      valid_name_unique = regex(local.az.network_security_group_rule.regex, local.az.network_security_group_rule.name_unique)
    }
    network_security_rule = {
      // valid_name        = regex(local.az.network_security_rule.regex, local.az.network_security_rule.name)
      valid_name_unique = regex(local.az.network_security_rule.regex, local.az.network_security_rule.name_unique)
    }
    application_security_group = {
      // valid_name        = regex(local.az.application_security_group.regex, local.az.application_security_group.name)
      valid_name_unique = regex(local.az.application_security_group.regex, local.az.application_security_group.name_unique)
    }
    dns_zone = {
      // valid_name        = regex(local.az.dns_zone.regex, local.az.dns_zone.name)
      valid_name_unique = regex(local.az.dns_zone.regex, local.az.dns_zone.name_unique)
    }
    private_dns_zone = {
      // valid_name        = regex(local.az.private_dns_zone.regex, local.az.private_dns_zone.name)
      valid_name_unique = regex(local.az.private_dns_zone.regex, local.az.private_dns_zone.name_unique)
    }
    notification_hub = {
      // valid_name        = regex(local.az.notification_hub.regex, local.az.notification_hub.name)
      valid_name_unique = regex(local.az.notification_hub.regex, local.az.notification_hub.name_unique)
    }
    notification_hub_namespace = {
      // valid_name        = regex(local.az.notification_hub_namespace.regex, local.az.notification_hub_namespace.name)
      valid_name_unique = regex(local.az.notification_hub_namespace.regex, local.az.notification_hub_namespace.name_unique)
    }
    notification_hub_authorization_rule = {
      // valid_name        = regex(local.az.notification_hub_authorization_rule.regex, local.az.notification_hub_authorization_rule.name)
      valid_name_unique = regex(local.az.notification_hub_authorization_rule.regex, local.az.notification_hub_authorization_rule.name_unique)
    }
    servicebus_namespace = {
      // valid_name        = regex(local.az.servicebus_namespace.regex, local.az.servicebus_namespace.name)
      valid_name_unique = regex(local.az.servicebus_namespace.regex, local.az.servicebus_namespace.name_unique)
    }
    servicebus_namespace_authorization_rule = {
      // valid_name        = regex(local.az.servicebus_namespace_authorization_rule.regex, local.az.servicebus_namespace_authorization_rule.name)
      valid_name_unique = regex(local.az.servicebus_namespace_authorization_rule.regex, local.az.servicebus_namespace_authorization_rule.name_unique)
    }
    servicebus_queue = {
      // valid_name        = regex(local.az.servicebus_queue.regex, local.az.servicebus_queue.name)
      valid_name_unique = regex(local.az.servicebus_queue.regex, local.az.servicebus_queue.name_unique)
    }
    servicebus_queue_authorization_rule = {
      // valid_name        = regex(local.az.servicebus_queue_authorization_rule.regex, local.az.servicebus_queue_authorization_rule.name)
      valid_name_unique = regex(local.az.servicebus_queue_authorization_rule.regex, local.az.servicebus_queue_authorization_rule.name_unique)
    }
    servicebus_subscription = {
      // valid_name        = regex(local.az.servicebus_subscription.regex, local.az.servicebus_subscription.name)
      valid_name_unique = regex(local.az.servicebus_subscription.regex, local.az.servicebus_subscription.name_unique)
    }
    servicebus_subscription_rule = {
      // valid_name        = regex(local.az.servicebus_subscription_rule.regex, local.az.servicebus_subscription_rule.name)
      valid_name_unique = regex(local.az.servicebus_subscription_rule.regex, local.az.servicebus_subscription_rule.name_unique)
    }
    servicebus_topic = {
      // valid_name        = regex(local.az.servicebus_topic.regex, local.az.servicebus_topic.name)
      valid_name_unique = regex(local.az.servicebus_topic.regex, local.az.servicebus_topic.name_unique)
    }
    servicebus_topic_authorization_rule = {
      // valid_name        = regex(local.az.servicebus_topic_authorization_rule.regex, local.az.servicebus_topic_authorization_rule.name)
      valid_name_unique = regex(local.az.servicebus_topic_authorization_rule.regex, local.az.servicebus_topic_authorization_rule.name_unique)
    }
    powerbi_embedded = {
      // valid_name        = regex(local.az.powerbi_embedded.regex, local.az.powerbi_embedded.name)
      valid_name_unique = regex(local.az.powerbi_embedded.regex, local.az.powerbi_embedded.name_unique)
    }
    dashboard = {
      // valid_name        = regex(local.az.dashboard.regex, local.az.dashboard.name)
      valid_name_unique = regex(local.az.dashboard.regex, local.az.dashboard.name_unique)
    }
    signalr_service = {
      // valid_name        = regex(local.az.signalr_service.regex, local.az.signalr_service.name)
      valid_name_unique = regex(local.az.signalr_service.regex, local.az.signalr_service.name_unique)
    }
    eventgrid_domain = {
      // valid_name        = regex(local.az.eventgrid_domain.regex, local.az.eventgrid_domain.name)
      valid_name_unique = regex(local.az.eventgrid_domain.regex, local.az.eventgrid_domain.name_unique)
    }
    eventgrid_domain_topic = {
      // valid_name        = regex(local.az.eventgrid_domain_topic.regex, local.az.eventgrid_domain_topic.name)
      valid_name_unique = regex(local.az.eventgrid_domain_topic.regex, local.az.eventgrid_domain_topic.name_unique)
    }
    eventgrid_event_subscription = {
      // valid_name        = regex(local.az.eventgrid_event_subscription.regex, local.az.eventgrid_event_subscription.name)
      valid_name_unique = regex(local.az.eventgrid_event_subscription.regex, local.az.eventgrid_event_subscription.name_unique)
    }
    eventgrid_topic = {
      // valid_name        = regex(local.az.eventgrid_topic.regex, local.az.eventgrid_topic.name)
      valid_name_unique = regex(local.az.eventgrid_topic.regex, local.az.eventgrid_topic.name_unique)
    }
    relay_namespace = {
      // valid_name        = regex(local.az.relay_namespace.regex, local.az.relay_namespace.name)
      valid_name_unique = regex(local.az.relay_namespace.regex, local.az.relay_namespace.name_unique)
    }
    relay_hybrid_connection = {
      // valid_name        = regex(local.az.relay_hybrid_connection.regex, local.az.relay_hybrid_connection.name)
      valid_name_unique = regex(local.az.relay_hybrid_connection.regex, local.az.relay_hybrid_connection.name_unique)
    }
    private_endpoint = {
      // valid_name        = regex(local.az.private_endpoint.regex, local.az.private_endpoint.name)
      valid_name_unique = regex(local.az.private_endpoint.regex, local.az.private_endpoint.name_unique)
    }
    private_service_connection = {
      // valid_name        = regex(local.az.private_service_connection.regex, local.az.private_service_connection.name)
      valid_name_unique = regex(local.az.private_service_connection.regex, local.az.private_service_connection.name_unique)
    }
    firewall_ip_configuration = {
      // valid_name        = regex(local.az.firewall_ip_configuration.regex, local.az.firewall_ip_configuration.name)
      valid_name_unique = regex(local.az.firewall_ip_configuration.regex, local.az.firewall_ip_configuration.name_unique)
    }
    firewall_application_rule_collection = {
      // valid_name        = regex(local.az.firewall_application_rule_collection.regex, local.az.firewall_application_rule_collection.name)
      valid_name_unique = regex(local.az.firewall_application_rule_collection.regex, local.az.firewall_application_rule_collection.name_unique)
    }
    firewall_nat_rule_collection = {
      // valid_name        = regex(local.az.firewall_nat_rule_collection.regex, local.az.firewall_nat_rule_collection.name)
      valid_name_unique = regex(local.az.firewall_nat_rule_collection.regex, local.az.firewall_nat_rule_collection.name_unique)
    }
    firewall_network_rule_collection = {
      // valid_name        = regex(local.az.firewall_network_rule_collection.regex, local.az.firewall_network_rule_collection.name)
      valid_name_unique = regex(local.az.firewall_network_rule_collection.regex, local.az.firewall_network_rule_collection.name_unique)
    }
    dns_a_record = {
      // valid_name        = regex(local.az.dns_a_record.regex, local.az.dns_a_record.name)
      valid_name_unique = regex(local.az.dns_a_record.regex, local.az.dns_a_record.name_unique)
    }
    dns_aaaa_record = {
      // valid_name        = regex(local.az.dns_aaaa_record.regex, local.az.dns_aaaa_record.name)
      valid_name_unique = regex(local.az.dns_aaaa_record.regex, local.az.dns_aaaa_record.name_unique)
    }
    dns_caa_record = {
      // valid_name        = regex(local.az.dns_caa_record.regex, local.az.dns_caa_record.name)
      valid_name_unique = regex(local.az.dns_caa_record.regex, local.az.dns_caa_record.name_unique)
    }
    dns_cname_record = {
      // valid_name        = regex(local.az.dns_cname_record.regex, local.az.dns_cname_record.name)
      valid_name_unique = regex(local.az.dns_cname_record.regex, local.az.dns_cname_record.name_unique)
    }
    dns_mx_record = {
      // valid_name        = regex(local.az.dns_mx_record.regex, local.az.dns_mx_record.name)
      valid_name_unique = regex(local.az.dns_mx_record.regex, local.az.dns_mx_record.name_unique)
    }
    dns_ns_record = {
      // valid_name        = regex(local.az.dns_ns_record.regex, local.az.dns_ns_record.name)
      valid_name_unique = regex(local.az.dns_ns_record.regex, local.az.dns_ns_record.name_unique)
    }
    dns_ptr_record = {
      // valid_name        = regex(local.az.dns_ptr_record.regex, local.az.dns_ptr_record.name)
      valid_name_unique = regex(local.az.dns_ptr_record.regex, local.az.dns_ptr_record.name_unique)
    }
    dns_txt_record = {
      // valid_name        = regex(local.az.dns_txt_record.regex, local.az.dns_txt_record.name)
      valid_name_unique = regex(local.az.dns_txt_record.regex, local.az.dns_txt_record.name_unique)
    }
    private_dns_a_record = {
      // valid_name        = regex(local.az.private_dns_a_record.regex, local.az.private_dns_a_record.name)
      valid_name_unique = regex(local.az.private_dns_a_record.regex, local.az.private_dns_a_record.name_unique)
    }
    private_dns_aaaa_record = {
      // valid_name        = regex(local.az.private_dns_aaaa_record.regex, local.az.private_dns_aaaa_record.name)
      valid_name_unique = regex(local.az.private_dns_aaaa_record.regex, local.az.private_dns_aaaa_record.name_unique)
    }
    private_dns_cname_record = {
      // valid_name        = regex(local.az.private_dns_cname_record.regex, local.az.private_dns_cname_record.name)
      valid_name_unique = regex(local.az.private_dns_cname_record.regex, local.az.private_dns_cname_record.name_unique)
    }
    private_dns_mx_record = {
      // valid_name        = regex(local.az.private_dns_mx_record.regex, local.az.private_dns_mx_record.name)
      valid_name_unique = regex(local.az.private_dns_mx_record.regex, local.az.private_dns_mx_record.name_unique)
    }
    private_dns_ptr_record = {
      // valid_name        = regex(local.az.private_dns_ptr_record.regex, local.az.private_dns_ptr_record.name)
      valid_name_unique = regex(local.az.private_dns_ptr_record.regex, local.az.private_dns_ptr_record.name_unique)
    }
    private_dns_srv_record = {
      // valid_name        = regex(local.az.private_dns_srv_record.regex, local.az.private_dns_srv_record.name)
      valid_name_unique = regex(local.az.private_dns_srv_record.regex, local.az.private_dns_srv_record.name_unique)
    }
    private_dns_txt_record = {
      // valid_name        = regex(local.az.private_dns_txt_record.regex, local.az.private_dns_txt_record.name)
      valid_name_unique = regex(local.az.private_dns_txt_record.regex, local.az.private_dns_txt_record.name_unique)
    }
    virtual_machine_extension = {
      // valid_name        = regex(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name)
      valid_name_unique = regex(local.az.virtual_machine_extension.regex, local.az.virtual_machine_extension.name_unique)
    }
    virtual_machine_scale_set_extension = {
      // valid_name        = regex(local.az.virtual_machine_scale_set_extension.regex, local.az.virtual_machine_scale_set_extension.name)
      valid_name_unique = regex(local.az.virtual_machine_scale_set_extension.regex, local.az.virtual_machine_scale_set_extension.name_unique)
    }
    network_ddos_protection_plan = {
      // valid_name        = regex(local.az.network_ddos_protection_plan.regex, local.az.network_ddos_protection_plan.name)
      valid_name_unique = regex(local.az.network_ddos_protection_plan.regex, local.az.network_ddos_protection_plan.name_unique)
    }
    private_dns_zone_group = {
      // valid_name        = regex(local.az.private_dns_zone_group.regex, local.az.private_dns_zone_group.name)
      valid_name_unique = regex(local.az.private_dns_zone_group.regex, local.az.private_dns_zone_group.name_unique)
    }
    proximity_placement_group = {
      // valid_name        = regex(local.az.proximity_placement_group.regex, local.az.proximity_placement_group.name)
      valid_name_unique = regex(local.az.proximity_placement_group.regex, local.az.proximity_placement_group.name_unique)
    }
    private_link_service = {
      // valid_name        = regex(local.az.private_link_service.regex, local.az.private_link_service.name)
      valid_name_unique = regex(local.az.private_link_service.regex, local.az.private_link_service.name_unique)
    }
  }
}
