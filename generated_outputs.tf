
output "unique-seed" {
  value = coalesce(var.unique-seed, local.random_safe_generation)
}
output "analysis_services_server" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.analysis_services_server, local.suffix_safe])), 0, 63)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.analysis_services_server, local.suffix_unique_safe])), 0, 63)
    dashes      = false
    slug        = local.az.analysis_services_server
    min_length  = 3
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{3,63}$)[a-z][a-z0-9]+$"
  }
}

output "api_managment_service" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.api_managment_service, local.suffix_safe])), 0, 50)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.api_managment_service, local.suffix_unique_safe])), 0, 50)
    dashes      = false
    slug        = local.az.api_managment_service
    min_length  = 1
    max_length  = 50
    scope       = "global"
    regex       = "^(?=.{1,50}$)[a-z][a-zA-Z0-9]+$"
  }
}

output "app_configuration" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.app_configuration, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.app_configuration, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.app_configuration
    min_length  = 5
    max_length  = 50
    scope       = "resourceGroup"
    regex       = "^(?=.{5,50}$)[a-zA-Z0-9_\-]+$"
  }
}

output "role_assignment" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.role_assignment, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.role_assignment, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.role_assignment
    min_length  = 1
    max_length  = 64
    scope       = "assignment"
    regex       = "^(?=.{1,64}$)[^%]+[^ %\.]$"
  }
}

output "role_definition" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.role_definition, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.role_definition, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.role_definition
    min_length  = 1
    max_length  = 64
    scope       = "definition"
    regex       = "^(?=.{1,64}$)[^%]+[^ %\.]$"
  }
}

output "automation_account" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_account, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_account, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.automation_account
    min_length  = 6
    max_length  = 50
    scope       = "resourceGroup"
    regex       = "^(?=.{6,50}$)[a-zA-Z][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "automation_certificate" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_certificate, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_certificate, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.automation_certificate
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[^<>*%:.?\+/]+[^<>*%:.?\+/ ]$"
  }
}

output "automation_credential" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_credential, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_credential, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.automation_credential
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[^<>*%:.?\+/]+[^<>*%:.?\+/ ]$"
  }
}

output "automation_runbook" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_runbook, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_runbook, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.automation_runbook
    min_length  = 1
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z][a-zA-Z0-9\-]+$"
  }
}

output "automation_schedule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_schedule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_schedule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.automation_schedule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[^<>*%:.?\+/]+[^<>*%:.?\+/ ]$"
  }
}

output "automation_variable" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.automation_variable, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.automation_variable, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.automation_variable
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[^<>*%:.?\+/]+[^<>*%:.?\+/ ]$"
  }
}

output "batch_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.batch_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.batch_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.batch_account
    min_length  = 3
    max_length  = 24
    scope       = "region"
    regex       = "^(?=.{3,24}$)[a-z0-9]+$"
  }
}

output "batch_application" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.batch_application, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.batch_application, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.batch_application
    min_length  = 1
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{1,64}$)[a-zA-Z0-9_\-]+$"
  }
}

output "batch_certificate" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.batch_certificate, local.suffix])), 0, 45)
    name_unique = substr(join("-", compact([local.prefix, local.az.batch_certificate, local.suffix_unique])), 0, 45)
    dashes      = true
    slug        = local.az.batch_certificate
    min_length  = 5
    max_length  = 45
    scope       = "parent"
    regex       = "^(?=.{5,45}$)[a-zA-Z0-9_\-]+$"
  }
}

output "batch_pool" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.batch_pool, local.suffix])), 0, 24)
    name_unique = substr(join("-", compact([local.prefix, local.az.batch_pool, local.suffix_unique])), 0, 24)
    dashes      = true
    slug        = local.az.batch_pool
    min_length  = 3
    max_length  = 24
    scope       = "parent"
    regex       = "^(?=.{1,64}$)[a-zA-Z0-9_\-]+$"
  }
}

output "bot_web_app" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_web_app, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_web_app, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_web_app
    min_length  = 2
    max_length  = 64
    scope       = "global"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_channel_Email" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_channel_Email, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_channel_Email, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_channel_Email
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_channel_ms_teams" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_channel_ms_teams, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_channel_ms_teams, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_channel_ms_teams
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_channel_slack" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_channel_slack, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_channel_slack, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_channel_slack
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_channel_directline" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_channel_directline, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_channel_directline, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_channel_directline
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_channels_registration" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_channels_registration, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_channels_registration, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_channels_registration
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "bot_connection" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bot_connection, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.bot_connection, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.bot_connection
    min_length  = 2
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9_\-\.]+$"
  }
}

output "redis_cache" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.redis_cache, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.redis_cache, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.redis_cache
    min_length  = 1
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{1,50}$)(?!.*--)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "redis_firewall_rule" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.redis_firewall_rule, local.suffix_safe])), 0, 256)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.redis_firewall_rule, local.suffix_unique_safe])), 0, 256)
    dashes      = false
    slug        = local.az.redis_firewall_rule
    min_length  = 1
    max_length  = 256
    scope       = "parent"
    regex       = "^(?=.{1,256}$)[a-zA-Z0-9]+$"
  }
}

output "cdn_profile" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.cdn_profile, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.cdn_profile, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.cdn_profile
    min_length  = 1
    max_length  = 260
    scope       = "resourceGroup"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "cdn_endpoint" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.cdn_endpoint, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.cdn_endpoint, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.cdn_endpoint
    min_length  = 1
    max_length  = 50
    scope       = "global"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "cognitive_account" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.cognitive_account, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.cognitive_account, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.cognitive_account
    min_length  = 2
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][a-zA-Z0-9\-]+$"
  }
}

output "availability_set" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.availability_set, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.availability_set, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.availability_set
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-_\.]+[a-zA-Z0-9_]$"
  }
}

output "disk_encryption_set" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.disk_encryption_set, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.disk_encryption_set, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.disk_encryption_set
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9_]+$"
  }
}

output "image" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.image, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.image, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.image
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-_\.]+[a-zA-Z0-9_]$"
  }
}

output "linux_virtual_machine" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.linux_virtual_machine, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.linux_virtual_machine, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.linux_virtual_machine
    min_length  = 1
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{1,64}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "linux_virtual_machine_scale_set" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.linux_virtual_machine_scale_set, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.linux_virtual_machine_scale_set, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.linux_virtual_machine_scale_set
    min_length  = 1
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{1,64}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "managed_disk" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.managed_disk, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.managed_disk, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.managed_disk
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9_]+$"
  }
}

output "virtual_machine" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_machine, local.suffix])), 0, 15)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_machine, local.suffix_unique])), 0, 15)
    dashes      = true
    slug        = local.az.virtual_machine
    min_length  = 1
    max_length  = 15
    scope       = "resourceGroup"
    regex       = "^(?=.{1,15}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "virtual_machine_scale_set" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_machine_scale_set, local.suffix])), 0, 15)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_machine_scale_set, local.suffix_unique])), 0, 15)
    dashes      = true
    slug        = local.az.virtual_machine_scale_set
    min_length  = 1
    max_length  = 15
    scope       = "resourceGroup"
    regex       = "^(?=.{1,15}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "windows_virtual_machine" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.windows_virtual_machine, local.suffix])), 0, 15)
    name_unique = substr(join("-", compact([local.prefix, local.az.windows_virtual_machine, local.suffix_unique])), 0, 15)
    dashes      = true
    slug        = local.az.windows_virtual_machine
    min_length  = 1
    max_length  = 15
    scope       = "resourceGroup"
    regex       = "^(?=.{1,15}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "windows_virtual_machine_scale_set" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.windows_virtual_machine_scale_set, local.suffix])), 0, 15)
    name_unique = substr(join("-", compact([local.prefix, local.az.windows_virtual_machine_scale_set, local.suffix_unique])), 0, 15)
    dashes      = true
    slug        = local.az.windows_virtual_machine_scale_set
    min_length  = 1
    max_length  = 15
    scope       = "resourceGroup"
    regex       = "^(?=.{1,15}$)[^\/"'\[\]:|<>+=;,?*@&_][^\/"'\[\]:|<>+=;,?*@&]+[^\/"'\[\]:|<>+=;,?*@&\.\-]$"
  }
}

output "containerGroups" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.containerGroups, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.containerGroups, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.containerGroups
    min_length  = 1
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{1,63}$)(?!.*--)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "container_registry" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.container_registry, local.suffix_safe])), 0, 63)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.container_registry, local.suffix_unique_safe])), 0, 63)
    dashes      = false
    slug        = local.az.container_registry
    min_length  = 1
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9]+$"
  }
}

output "container_registry_webhook" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.container_registry_webhook, local.suffix_safe])), 0, 50)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.container_registry_webhook, local.suffix_unique_safe])), 0, 50)
    dashes      = false
    slug        = local.az.container_registry_webhook
    min_length  = 1
    max_length  = 50
    scope       = "resourceGroup"
    regex       = "^(?=.{5,50}$)[a-zA-Z0-9]+$"
  }
}

output "kubernetes_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.kubernetes_cluster, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.kubernetes_cluster, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.kubernetes_cluster
    min_length  = 1
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9][a-zA-Z0-9\-_\.]+[a-zA-Z0-9]$"
  }
}

output "cosmosdb_account" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.cosmosdb_account, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.cosmosdb_account, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.cosmosdb_account
    min_length  = 1
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{1,63}$)[a-z0-9][a-zA-Z0-9\-_\.]+[a-zA-Z0-9]$"
  }
}

output "custom_provider" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.custom_provider, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.custom_provider, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.custom_provider
    min_length  = 3
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{3,64}$)[^&%?\/]+[^&%\.?/ ]$"
  }
}

output "mariadb_server" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mariadb_server, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.mariadb_server, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.mariadb_server
    min_length  = 3
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{3,63}$)[a-z0-9][a-zA-Z0-9\-]+[a-z0-9]$"
  }
}

output "mariadb_firewall_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mariadb_firewall_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.mariadb_firewall_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.mariadb_firewall_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "mariadb_database" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mariadb_database, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.mariadb_database, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.mariadb_database
    min_length  = 1
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "mariadb_virtual_network_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mariadb_virtual_network_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.mariadb_virtual_network_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.mariadb_virtual_network_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "mysql_server" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mysql_server, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.mysql_server, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.mysql_server
    min_length  = 3
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{3,63}$)[a-z0-9][a-zA-Z0-9\-]+[a-z0-9]$"
  }
}

output "mysql_firewall_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mysql_firewall_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.mysql_firewall_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.mysql_firewall_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "mysql_database" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mysql_database, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.mysql_database, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.mysql_database
    min_length  = 1
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "mysql_virtual_network_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.mysql_virtual_network_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.mysql_virtual_network_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.mysql_virtual_network_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "postgresql_server" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.postgresql_server, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.postgresql_server, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.postgresql_server
    min_length  = 3
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{3,63}$)[a-z0-9][a-zA-Z0-9\-]+[a-z0-9]$"
  }
}

output "postgresql_firewall_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.postgresql_firewall_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.postgresql_firewall_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.postgresql_firewall_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "postgresql_database" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.postgresql_database, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.postgresql_database, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.postgresql_database
    min_length  = 1
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "postgresql_virtual_network_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.postgresql_virtual_network_rule, local.suffix])), 0, 128)
    name_unique = substr(join("-", compact([local.prefix, local.az.postgresql_virtual_network_rule, local.suffix_unique])), 0, 128)
    dashes      = true
    slug        = local.az.postgresql_virtual_network_rule
    min_length  = 1
    max_length  = 128
    scope       = "parent"
    regex       = "^(?=.{1,128}$)[a-zA-Z0-9\-_]+$"
  }
}

output "database_migration_project" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.database_migration_project, local.suffix])), 0, 57)
    name_unique = substr(join("-", compact([local.prefix, local.az.database_migration_project, local.suffix_unique])), 0, 57)
    dashes      = true
    slug        = local.az.database_migration_project
    min_length  = 2
    max_length  = 57
    scope       = "parent"
    regex       = "^(?=.{2,57}$)[a-zA-Z0-9][a-zA-Z0-9\-_\.]+$"
  }
}

output "database_migration_service" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.database_migration_service, local.suffix])), 0, 62)
    name_unique = substr(join("-", compact([local.prefix, local.az.database_migration_service, local.suffix_unique])), 0, 62)
    dashes      = true
    slug        = local.az.database_migration_service
    min_length  = 2
    max_length  = 62
    scope       = "resourceGroup"
    regex       = "^(?=.{2,62}$)[a-zA-Z0-9][a-zA-Z0-9\-_\.]+$"
  }
}

output "databricks_workspace" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.databricks_workspace, local.suffix])), 0, 30)
    name_unique = substr(join("-", compact([local.prefix, local.az.databricks_workspace, local.suffix_unique])), 0, 30)
    dashes      = true
    slug        = local.az.databricks_workspace
    min_length  = 3
    max_length  = 30
    scope       = "resourceGroup"
    regex       = "^(?=.{3,30}$)[a-zA-Z0-9\-_]+$"
  }
}

output "kusto_cluster" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.kusto_cluster, local.suffix_safe])), 0, 22)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.kusto_cluster, local.suffix_unique_safe])), 0, 22)
    dashes      = false
    slug        = local.az.kusto_cluster
    min_length  = 4
    max_length  = 22
    scope       = "global"
    regex       = "^(?=.{4,22}$)[a-z][a-z0-9]+$"
  }
}

output "kusto_database" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.kusto_database, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.kusto_database, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.kusto_database
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9\- \.]+$"
  }
}

output "kusto_eventhub_data_connection" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.kusto_eventhub_data_connection, local.suffix])), 0, 40)
    name_unique = substr(join("-", compact([local.prefix, local.az.kusto_eventhub_data_connection, local.suffix_unique])), 0, 40)
    dashes      = true
    slug        = local.az.kusto_eventhub_data_connection
    min_length  = 1
    max_length  = 40
    scope       = "parent"
    regex       = "^(?=.{1,40}$)[a-zA-Z0-9\- \.]+$"
  }
}

output "data_factory" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.data_factory
    min_length  = 3
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{3,63}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "data_factory_dataset_mysql" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_mysql, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_mysql, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_dataset_mysql
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+[a-zA-Z0-9]$"
  }
}

output "data_factory_dataset_postgresql" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_postgresql, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_postgresql, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_dataset_postgresql
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+[a-zA-Z0-9]$"
  }
}

output "data_factory_dataset_sql_server_table" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_sql_server_table, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_dataset_sql_server_table, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_dataset_sql_server_table
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+[a-zA-Z0-9]$"
  }
}

output "data_factory_integration_runtime_managed" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_integration_runtime_managed, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_integration_runtime_managed, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.data_factory_integration_runtime_managed
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "data_factory_pipeline" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_pipeline, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_pipeline, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_pipeline
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+[a-zA-Z0-9]$"
  }
}

output "data_factory_linked_service_data_lake_storage_gen2" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_data_lake_storage_gen2, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_data_lake_storage_gen2, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_linked_service_data_lake_storage_gen2
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_factory_linked_service_key_vault" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_key_vault, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_key_vault, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_linked_service_key_vault
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_factory_linked_service_mysql" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_mysql, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_mysql, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_linked_service_mysql
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_factory_linked_service_postgresql" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_postgresql, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_postgresql, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_linked_service_postgresql
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_factory_linked_service_sql_server" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_sql_server, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_linked_service_sql_server, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_linked_service_sql_server
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_factory_trigger_schedule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_factory_trigger_schedule, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_factory_trigger_schedule, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.data_factory_trigger_schedule
    min_length  = 1
    max_length  = 260
    scope       = "parent"
    regex       = "^(?=.{1,260}$)[a-zA-Z0-9][^<>*%:.?\+/]+$"
  }
}

output "data_lake_analytics_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.data_lake_analytics_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.data_lake_analytics_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.data_lake_analytics_account
    min_length  = 3
    max_length  = 24
    scope       = "global"
    regex       = "^(?=.{3,24}$)[a-z0-9]+$"
  }
}

output "data_lake_analytics_firewall_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_lake_analytics_firewall_rule, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_lake_analytics_firewall_rule, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.data_lake_analytics_firewall_rule
    min_length  = 3
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{3,50}$)[a-z0-9\-_]+$"
  }
}

output "data_lake_store" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.data_lake_store, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.data_lake_store, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.data_lake_store
    min_length  = 3
    max_length  = 24
    scope       = "parent"
    regex       = "^(?=.{3,24}$)[a-z0-9]+$"
  }
}

output "data_lake_store_firewall_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.data_lake_store_firewall_rule, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.data_lake_store_firewall_rule, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.data_lake_store_firewall_rule
    min_length  = 3
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{3,50}$)[a-zA-Z0-9\-_]+$"
  }
}

output "dev_test_lab" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.dev_test_lab, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.dev_test_lab, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.dev_test_lab
    min_length  = 1
    max_length  = 50
    scope       = "resourceGroup"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9\-_]+$"
  }
}

output "dev_test_linux_virtual_machine" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.dev_test_linux_virtual_machine, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.dev_test_linux_virtual_machine, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.dev_test_linux_virtual_machine
    min_length  = 1
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9\-]+$"
  }
}

output "dev_test_windows_virtual_machine" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.dev_test_windows_virtual_machine, local.suffix])), 0, 15)
    name_unique = substr(join("-", compact([local.prefix, local.az.dev_test_windows_virtual_machine, local.suffix_unique])), 0, 15)
    dashes      = true
    slug        = local.az.dev_test_windows_virtual_machine
    min_length  = 1
    max_length  = 15
    scope       = "parent"
    regex       = "^(?=.{1,15}$)[a-zA-Z0-9\-]+$"
  }
}

output "frontdoor" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.frontdoor, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.frontdoor, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.frontdoor
    min_length  = 5
    max_length  = 64
    scope       = "global"
    regex       = "^(?=.{5,64}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "frontdoor_firewall_policy" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.frontdoor_firewall_policy, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.frontdoor_firewall_policy, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.frontdoor_firewall_policy
    min_length  = 1
    max_length  = 80
    scope       = "global"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "hdinsight_hadoop_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_hadoop_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_hadoop_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_hadoop_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_hbase_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_hbase_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_hbase_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_hbase_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_kafka_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_kafka_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_kafka_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_kafka_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_interactive_query_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_interactive_query_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_interactive_query_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_interactive_query_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_ml_services_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_ml_services_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_ml_services_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_ml_services_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_rserver_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_rserver_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_rserver_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_rserver_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_spark_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_spark_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_spark_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_spark_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "hdinsight_storm_cluster" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.hdinsight_storm_cluster, local.suffix])), 0, 59)
    name_unique = substr(join("-", compact([local.prefix, local.az.hdinsight_storm_cluster, local.suffix_unique])), 0, 59)
    dashes      = true
    slug        = local.az.hdinsight_storm_cluster
    min_length  = 3
    max_length  = 59
    scope       = "global"
    regex       = "^(?=.{3,59}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "iotcentral_application" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.iotcentral_application, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.iotcentral_application, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.iotcentral_application
    min_length  = 2
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{2,63}$)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "iothub" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.iothub, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.iothub, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.iothub
    min_length  = 3
    max_length  = 50
    scope       = "global"
    regex       = "^(?=.{3,50}$)[a-zA-Z0-9][a-zA-Z0-9\-]+[a-z0-9]$"
  }
}

output "iothub_consumer_group" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.iothub_consumer_group, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.iothub_consumer_group, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.iothub_consumer_group
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9\-\._]+$"
  }
}

output "iothub_dps" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.iothub_dps, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.iothub_dps, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.iothub_dps
    min_length  = 3
    max_length  = 64
    scope       = "resoureceGroup"
    regex       = "^(?=.{3,64}$)[a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "iothub_dps_certificate" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.iothub_dps_certificate, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.iothub_dps_certificate, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.iothub_dps_certificate
    min_length  = 1
    max_length  = 64
    scope       = "parent"
    regex       = "^(?=.{3,64}$)[a-zA-Z0-9\-\._]+$"
  }
}

output "key_vault" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.key_vault, local.suffix])), 0, 24)
    name_unique = substr(join("-", compact([local.prefix, local.az.key_vault, local.suffix_unique])), 0, 24)
    dashes      = true
    slug        = local.az.key_vault
    min_length  = 3
    max_length  = 24
    scope       = "global"
    regex       = "^(?=.{3,24}$)(?!.*--)[a-zA-Z][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "key_vault_key" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.key_vault_key, local.suffix])), 0, 127)
    name_unique = substr(join("-", compact([local.prefix, local.az.key_vault_key, local.suffix_unique])), 0, 127)
    dashes      = true
    slug        = local.az.key_vault_key
    min_length  = 1
    max_length  = 127
    scope       = "parent"
    regex       = "^(?=.{1,127}$)[a-zA-Z0-9\-]+$"
  }
}

output "key_vault_secret" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.key_vault_secret, local.suffix])), 0, 127)
    name_unique = substr(join("-", compact([local.prefix, local.az.key_vault_secret, local.suffix_unique])), 0, 127)
    dashes      = true
    slug        = local.az.key_vault_secret
    min_length  = 1
    max_length  = 127
    scope       = "parent"
    regex       = "^(?=.{1,127}$)[a-zA-Z0-9\-]+$"
  }
}

output "key_vault_certificate" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.key_vault_certificate, local.suffix])), 0, 127)
    name_unique = substr(join("-", compact([local.prefix, local.az.key_vault_certificate, local.suffix_unique])), 0, 127)
    dashes      = true
    slug        = local.az.key_vault_certificate
    min_length  = 1
    max_length  = 127
    scope       = "parent"
    regex       = "^(?=.{1,127}$)[a-zA-Z0-9\-]+$"
  }
}

output "lb" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.lb, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.lb, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.lb
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "lb_nat_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.lb_nat_rule, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.lb_nat_rule, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.lb_nat_rule
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "public_ip" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.public_ip, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.public_ip, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.public_ip
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "public_ip_prefix" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.public_ip_prefix
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "public_ip_prefix" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.public_ip_prefix
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "public_ip_prefix" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.public_ip_prefix, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.public_ip_prefix
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "route" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.route, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.route, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.route
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "route_table" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.route_table, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.route_table, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.route_table
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "subnet" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.subnet, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.subnet, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.subnet
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "traffic_manager_profile" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.traffic_manager_profile, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.traffic_manager_profile, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.traffic_manager_profile
    min_length  = 1
    max_length  = 63
    scope       = "global"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9][a-zA-Z0-9\-\.]+[a-zA-Z0-9_]$"
  }
}

output "virtual_wan" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_wan, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_wan, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.virtual_wan
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "virtual_network" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_network, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_network, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.virtual_network
    min_length  = 2
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{2,64}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "virtual_network_gateway" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_network_gateway, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_network_gateway, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.virtual_network_gateway
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "virtual_network_peering" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.virtual_network_peering, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.virtual_network_peering, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.virtual_network_peering
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "network_interface" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.network_interface, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.network_interface, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.network_interface
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "firewall" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.firewall, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.firewall, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.firewall
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "eventhub" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "eventhub_namespace" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub_namespace, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub_namespace, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub_namespace
    min_length  = 1
    max_length  = 50
    scope       = "global"
    regex       = "^(?=.{1,50}$)[a-zA-Z][a-zA-Z0-9\-]+[a-zA-Z0-9]$"
  }
}

output "eventhub_authorization_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub_authorization_rule, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub_authorization_rule, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub_authorization_rule
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "eventhub_namespace_authorization_rule" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub_namespace_authorization_rule, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub_namespace_authorization_rule, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub_namespace_authorization_rule
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "eventhub_namespace_disaster_recovery_config" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub_namespace_disaster_recovery_config, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub_namespace_disaster_recovery_config, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub_namespace_disaster_recovery_config
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "eventhub_consumer_group" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.eventhub_consumer_group, local.suffix])), 0, 50)
    name_unique = substr(join("-", compact([local.prefix, local.az.eventhub_consumer_group, local.suffix_unique])), 0, 50)
    dashes      = true
    slug        = local.az.eventhub_consumer_group
    min_length  = 1
    max_length  = 50
    scope       = "parent"
    regex       = "^(?=.{1,50}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "stream_analytics_job" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_job, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_job, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_job
    min_length  = 3
    max_length  = 63
    scope       = "resourceGroup"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_function_javascript_udf" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_function_javascript_udf, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_function_javascript_udf, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_function_javascript_udf
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_output_blob" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_blob, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_blob, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_output_blob
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_output_mssql" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_mssql, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_mssql, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_output_mssql
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_output_eventhub" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_eventhub, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_eventhub, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_output_eventhub
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_output_servicebus_queue" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_servicebus_queue, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_servicebus_queue, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_output_servicebus_queue
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_output_servicebus_topic" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_servicebus_topic, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_output_servicebus_topic, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_output_servicebus_topic
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_reference_input_blob" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_reference_input_blob, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_reference_input_blob, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_reference_input_blob
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_stream_input_blob" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_blob, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_blob, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_stream_input_blob
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_stream_input_eventhub" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_eventhub, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_eventhub, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_stream_input_eventhub
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "stream_analytics_stream_input_iothub" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_iothub, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.stream_analytics_stream_input_iothub, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.stream_analytics_stream_input_iothub
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{1,63}$)[a-zA-Z0-9\-_]+$"
  }
}

output "shared_image_gallery" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.shared_image_gallery, local.suffix_safe])), 0, 80)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.shared_image_gallery, local.suffix_unique_safe])), 0, 80)
    dashes      = false
    slug        = local.az.shared_image_gallery
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\.]+[a-zA-Z0-9]$"
  }
}

output "shared_image" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.shared_image, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.shared_image, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.shared_image
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9]$"
  }
}

output "snapshots" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.snapshots, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.snapshots, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.snapshots
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "storage_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.storage_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.storage_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.storage_account
    min_length  = 3
    max_length  = 24
    scope       = "global"
    regex       = "^(?=.{3,24}$)[a-z0-9]+$"
  }
}

output "storage_container" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_container, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_container, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_container
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+$"
  }
}

output "storage_data_lake_gen2_filesystem" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_data_lake_gen2_filesystem, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_data_lake_gen2_filesystem, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_data_lake_gen2_filesystem
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "storage_queue" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_queue, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_queue, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_queue
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "storage_table" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_table, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_table, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_table
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "storage_share" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_share, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_share, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_share
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "storage_share_directory" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_share_directory, local.suffix])), 0, 63)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_share_directory, local.suffix_unique])), 0, 63)
    dashes      = true
    slug        = local.az.storage_share_directory
    min_length  = 3
    max_length  = 63
    scope       = "parent"
    regex       = "^(?=.{3,63}$)(?!.*--)[a-z0-9][a-z0-9\-]+[a-z0-9]$"
  }
}

output "machine_learning_workspace" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.machine_learning_workspace, local.suffix])), 0, 260)
    name_unique = substr(join("-", compact([local.prefix, local.az.machine_learning_workspace, local.suffix_unique])), 0, 260)
    dashes      = true
    slug        = local.az.machine_learning_workspace
    min_length  = 1
    max_length  = 260
    scope       = "resourceGroup"
    regex       = "^(?=.{1,260}$)[^<>*%:.?\+/]+[^<>*%:.?\+/ ]$"
  }
}

output "storage_blob" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.storage_blob, local.suffix])), 0, 1024)
    name_unique = substr(join("-", compact([local.prefix, local.az.storage_blob, local.suffix_unique])), 0, 1024)
    dashes      = true
    slug        = local.az.storage_blob
    min_length  = 1
    max_length  = 1024
    scope       = "parent"
    regex       = "^(?=.{1,1024}$)[^\s/$#&]+$"
  }
}

output "bastion_host" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.bastion_host, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.bastion_host, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.bastion_host
    min_length  = 1
    max_length  = 80
    scope       = "parent"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "local_network_gateway" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.local_network_gateway, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.local_network_gateway, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.local_network_gateway
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "application_gateway" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.application_gateway, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.application_gateway, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.application_gateway
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "express_route_gateway" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.express_route_gateway, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.express_route_gateway, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.express_route_gateway
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "express_route_circuit" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.express_route_circuit, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.express_route_circuit, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.express_route_circuit
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "point_to_site_vpn_gateway" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.point_to_site_vpn_gateway, local.suffix])), 0, 80)
    name_unique = substr(join("-", compact([local.prefix, local.az.point_to_site_vpn_gateway, local.suffix_unique])), 0, 80)
    dashes      = true
    slug        = local.az.point_to_site_vpn_gateway
    min_length  = 1
    max_length  = 80
    scope       = "resourceGroup"
    regex       = "^(?=.{1,80}$)[a-zA-Z0-9][a-zA-Z0-9\-\._]+[a-zA-Z0-9_]$"
  }
}

output "template_deployment" {
  value = {
    name        = substr(join("-", compact([local.prefix, local.az.template_deployment, local.suffix])), 0, 64)
    name_unique = substr(join("-", compact([local.prefix, local.az.template_deployment, local.suffix_unique])), 0, 64)
    dashes      = true
    slug        = local.az.template_deployment
    min_length  = 1
    max_length  = 64
    scope       = "resourceGroup"
    regex       = "^(?=.{1,64}$)[a-zA-Z0-9\-\._\(\)]+[a-zA-Z0-9_]$"
  }
}

output "" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az., local.suffix_safe])), 0,