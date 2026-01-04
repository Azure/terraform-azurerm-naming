// Unit tests for the root module using Terraform's built-in test framework.
// These tests exercise the module's naming logic using `command = plan` so
// they behave like unit tests (no resources are created).

test {
  # Enable parallel execution for independent runs. Individual runs may
  # still override this setting if necessary.
  parallel = true
}

run "suffix_resource_group_name_001" {
  command = plan

  variables {
    suffix = [ "test" ]
  }

  assert {
    condition     = output.resource_group.name == "rg-test"
    error_message = "resource_group.name did not match expected"
  }
}

run "suffix_resource_group_name_002" {
  command = plan

  variables {
    suffix = [ "azure", "test" ]
  }

  assert {
    condition     = output.resource_group.name == "rg-azure-test"
    error_message = "resource_group.name did not match expected"
  }
}
