
// Example 1

module "name_empty" {
  source = "../"
}

output "name_empty" {
  value = module.name_empty.storage_account.name_unique
}

// Example 2

module "suffix" {
  source        = "../"
  suffix        = ["su", "fix"]
  unique-length = 20
}

output "suffix" {
  value = module.suffix.storage_account.name_unique
}

// Example 3

module "random" {
  source      = "../"
  unique-seed = module.suffix.unique-seed
}

output "random" {
  value = module.random.storage_account.name_unique
}

// Example 4

module "everything" {
  source                 = "../"
  prefix                 = ["pre", "fix"]
  suffix                 = ["su", "fix"]
  unique-seed            = "random"
  unique-length          = 2
  unique-include-numbers = false
}

output "everything" {
  value = module.everything.storage_account.name_unique
}

output "validation_everything" {
  value = module.everything.validation
}

// Example 5

module "slug_override" {
  source = "../"
  resource-slug-overrides = {
    analysis_services_server = "asx"
    api_management           = "apix"
  }
}

output "slug_override" {
  value = {
    analysis_services_server = module.slug_override.analysis_services_server.name_unique
    api_management           = module.slug_override.api_management.name_unique
    app_configuration        = module.slug_override.app_configuration.name_unique
    app_service              = module.slug_override.app_service.name_unique
  }
}
