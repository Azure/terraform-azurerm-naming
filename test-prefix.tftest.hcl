// Unit tests for the root module using Terraform's built-in test framework.
// These tests exercise the module's naming logic using `command = plan` so
// they behave like unit tests (no resources are created).

test {
  # Enable parallel execution for independent runs. Individual runs may
  # still override this setting if necessary.
  parallel = true
}

run "prefix_resource_group_name_001" {
  command = plan

  variables {
    prefix = [ "test" ]
  }

  assert {
    condition     = output.resource_group.name == "test-rg"
    error_message = "resource_group.name did not match expected"
  }
}

run "prefix_resource_group_name_002" {
  command = plan

  variables {
    prefix = [ "azure", "test" ]
  }

  assert {
    condition     = output.resource_group.name == "azure-test-rg"
    error_message = "resource_group.name did not match expected"
  }
}