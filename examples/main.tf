
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
