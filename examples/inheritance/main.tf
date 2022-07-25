module "naming_global" {
  source                 = "../../../terraform-azurerm-naming-1"
  prefix                 = ["contoso"]
  unique_include_numbers = false
  unique_length          = 6
  unique_seed            = "parent"
  tags = {
    "level"  = "global",
    "global" = "contoso"
  }
}

module "naming_subscription_app01" {
  source      = "../../../terraform-azurerm-naming-1"
  context     = module.naming_global.context
  suffix      = ["app01"]
  unique_seed = "child1"
  tags = {
    "level" : "subscription"
    "subscription" = "app01"
  }
}

module "naming_subscription_app02" {
  source      = "../../../terraform-azurerm-naming-1"
  context     = module.naming_global.context
  suffix      = ["app02"]
  unique_seed = "child1"
  tags = {
    "level" : "subscription"
    "subscription" = "app02"
  }
}

module "naming_network_westus" {
  source      = "../../../terraform-azurerm-naming-1"
  context     = module.naming_subscription_app01.context
  suffix      = ["westus"]
  unique_seed = "child2"
  tags = {
    "level" : "network"
    "region" = "westus"
  }
}

output "naming_global" {
  value = module.naming_global.resource_group.name_unique
}

output "naming_subscription_app01" {
  value = module.naming_subscription_app01.resource_group.name_unique
}

output "naming_subscription_app02" {
  value = module.naming_subscription_app02.resource_group.name_unique
}

output "naming_network_westus" {
  value = module.naming_network_westus.resource_group.name_unique
}
