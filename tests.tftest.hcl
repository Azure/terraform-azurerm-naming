// Unit tests for the root module using Terraform's built-in test framework.
// These tests exercise the module's naming logic using `command = plan` so
// they behave like unit tests (no resources are created).

test {
  # Enable parallel execution for independent runs. Individual runs may
  # still override this setting if necessary.
  parallel = true
}

run "analysis_services_server_test" {
    # This test checks to make sure the resource "analysis_services_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.analysis_services_server.name == "astest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.slug == "as"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.analysis_services_server.regex == "^[a-z][a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "api_management_test" {
    # This test checks to make sure the resource "api_management" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.api_management.name == "apim-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.api_management.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.api_management.slug == "apim"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.api_management.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.api_management.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.api_management.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.api_management.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "app_configuration_test" {
    # This test checks to make sure the resource "app_configuration" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.app_configuration.name == "appcg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.slug == "appcg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.min_length == 5
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.app_configuration.regex == "^[a-zA-Z0-9_-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "app_service_test" {
    # This test checks to make sure the resource "app_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.app_service.name == "app-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.app_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.app_service.slug == "app"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.app_service.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service.max_length == 60
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.app_service.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]"
        error_message = "'regex' did not match what was expected"
    }
}

run "app_service_environment_test" {
    # This test checks to make sure the resource "app_service_environment" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.app_service_environment.name == "ase-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.slug == "ase"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.max_length == 40
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.app_service_environment.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "app_service_plan_test" {
    # This test checks to make sure the resource "app_service_plan" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.app_service_plan.name == "plan-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.slug == "plan"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.max_length == 40
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.app_service_plan.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "application_gateway_test" {
    # This test checks to make sure the resource "application_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.application_gateway.name == "agw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.slug == "agw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.application_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "application_insights_test" {
    # This test checks to make sure the resource "application_insights" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.application_insights.name == "appi-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.slug == "appi"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.min_length == 10
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.application_insights.regex == "^[^%\\&?/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "application_security_group_test" {
    # This test checks to make sure the resource "application_security_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.application_security_group.name == "asg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.slug == "asg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.application_security_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_account_test" {
    # This test checks to make sure the resource "automation_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_account.name == "aa-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.slug == "aa"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.min_length == 6
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_account.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_certificate_test" {
    # This test checks to make sure the resource "automation_certificate" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_certificate.name == "aacert-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.slug == "aacert"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_certificate.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_credential_test" {
    # This test checks to make sure the resource "automation_credential" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_credential.name == "aacred-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.slug == "aacred"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_credential.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_runbook_test" {
    # This test checks to make sure the resource "automation_runbook" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_runbook.name == "aacred-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.slug == "aacred"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_runbook.regex == "^[a-zA-Z][a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_schedule_test" {
    # This test checks to make sure the resource "automation_schedule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_schedule.name == "aasched-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.slug == "aasched"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_schedule.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "automation_variable_test" {
    # This test checks to make sure the resource "automation_variable" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.automation_variable.name == "aavar-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.slug == "aavar"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.automation_variable.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "availability_set_test" {
    # This test checks to make sure the resource "availability_set" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.availability_set.name == "avail-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.slug == "avail"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.availability_set.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "backup_policy_vm_test" {
    # This test checks to make sure the resource "backup_policy_vm" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.backup_policy_vm.name == "bkpol-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.slug == "bkpol"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.max_length == 150
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.backup_policy_vm.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bastion_host_test" {
    # This test checks to make sure the resource "bastion_host" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bastion_host.name == "snap-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.slug == "snap"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bastion_host.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "batch_account_test" {
    # This test checks to make sure the resource "batch_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.batch_account.name == "batest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.slug == "ba"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.scope == "region"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.batch_account.regex == "^[a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "batch_application_test" {
    # This test checks to make sure the resource "batch_application" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.batch_application.name == "baapp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.slug == "baapp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.batch_application.regex == "^[a-zA-Z0-9_-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "batch_certificate_test" {
    # This test checks to make sure the resource "batch_certificate" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.batch_certificate.name == "bacert-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.slug == "bacert"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.min_length == 5
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.max_length == 45
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.batch_certificate.regex == "^[a-zA-Z0-9_-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "batch_pool_test" {
    # This test checks to make sure the resource "batch_pool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.batch_pool.name == "bapool-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.slug == "bapool"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.batch_pool.regex == "^[a-zA-Z0-9_-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_channel_directline_test" {
    # This test checks to make sure the resource "bot_channel_directline" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_channel_directline.name == "botline-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.slug == "botline"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_directline.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_channel_email_test" {
    # This test checks to make sure the resource "bot_channel_email" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_channel_email.name == "botmail-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.slug == "botmail"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_email.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_channel_ms_teams_test" {
    # This test checks to make sure the resource "bot_channel_ms_teams" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_channel_ms_teams.name == "botteams-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.slug == "botteams"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_ms_teams.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_channel_slack_test" {
    # This test checks to make sure the resource "bot_channel_slack" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_channel_slack.name == "botslack-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.slug == "botslack"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_channel_slack.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_channels_registration_test" {
    # This test checks to make sure the resource "bot_channels_registration" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_channels_registration.name == "botchan-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.slug == "botchan"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_channels_registration.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_connection_test" {
    # This test checks to make sure the resource "bot_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_connection.name == "botcon-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.slug == "botcon"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_connection.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "bot_web_app_test" {
    # This test checks to make sure the resource "bot_web_app" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.bot_web_app.name == "bot-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.slug == "bot"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.bot_web_app.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_endpoint_test" {
    # This test checks to make sure the resource "cdn_endpoint" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_endpoint.name == "cdn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.slug == "cdn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_endpoint.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_frontdoor_endpoint_test" {
    # This test checks to make sure the resource "cdn_frontdoor_endpoint" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.name == "fde-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.slug == "fde"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_endpoint.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_frontdoor_origin_test" {
    # This test checks to make sure the resource "cdn_frontdoor_origin" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_frontdoor_origin.name == "cdno-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.slug == "cdno"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_frontdoor_origin_group_test" {
    # This test checks to make sure the resource "cdn_frontdoor_origin_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.name == "cdnog-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.slug == "cdnog"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_origin_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_frontdoor_profile_test" {
    # This test checks to make sure the resource "cdn_frontdoor_profile" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_frontdoor_profile.name == "afd-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.slug == "afd"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.min_length == 5
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_profile.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_frontdoor_route_test" {
    # This test checks to make sure the resource "cdn_frontdoor_route" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_frontdoor_route.name == "cdnr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.slug == "cdnr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_frontdoor_route.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cdn_profile_test" {
    # This test checks to make sure the resource "cdn_profile" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cdn_profile.name == "cdnprof-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.slug == "cdnprof"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cdn_profile.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cognitive_account_test" {
    # This test checks to make sure the resource "cognitive_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cognitive_account.name == "cog-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.slug == "cog"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cognitive_account.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "communication_service_test" {
    # This test checks to make sure the resource "communication_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.communication_service.name == "acs-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.slug == "acs"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.communication_service.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_app_test" {
    # This test checks to make sure the resource "container_app" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_app.name == "ca-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_app.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_app.slug == "ca"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_app.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app.max_length == 32
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_app.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_app_environment_test" {
    # This test checks to make sure the resource "container_app_environment" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_app_environment.name == "cae-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.slug == "cae"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.max_length == 60
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_app_environment.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_app_job_test" {
    # This test checks to make sure the resource "container_app_job" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_app_job.name == "caj-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.slug == "caj"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.max_length == 32
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_app_job.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_group_test" {
    # This test checks to make sure the resource "container_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_group.name == "cg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_group.slug == "cg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_group.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_registry_test" {
    # This test checks to make sure the resource "container_registry" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_registry.name == "acrtest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.slug == "acr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_registry.regex == "^[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "container_registry_webhook_test" {
    # This test checks to make sure the resource "container_registry_webhook" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.container_registry_webhook.name == "crwhtest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.slug == "crwh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.container_registry_webhook.regex == "^[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_account_test" {
    # This test checks to make sure the resource "cosmosdb_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_account.name == "cosmos-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.slug == "cosmos"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_account.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_cassandra_test" {
    # This test checks to make sure the resource "cosmosdb_cassandra" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_cassandra.name == "coscas-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.slug == "coscas"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_cassandra_cluster_test" {
    # This test checks to make sure the resource "cosmosdb_cassandra_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.name == "mcc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.slug == "mcc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_cluster.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_cassandra_datacenter_test" {
    # This test checks to make sure the resource "cosmosdb_cassandra_datacenter" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.name == "mcdc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.slug == "mcdc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_cassandra_datacenter.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_gremlin_test" {
    # This test checks to make sure the resource "cosmosdb_gremlin" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_gremlin.name == "cosgrm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.slug == "cosgrm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_gremlin.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_mongodb_test" {
    # This test checks to make sure the resource "cosmosdb_mongodb" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_mongodb.name == "cosmon-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.slug == "cosmon"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_mongodb.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_nosql_test" {
    # This test checks to make sure the resource "cosmosdb_nosql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_nosql.name == "cosno-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.slug == "cosno"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_nosql.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_postgres_test" {
    # This test checks to make sure the resource "cosmosdb_postgres" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_postgres.name == "cospos-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.slug == "cospos"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_postgres.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "cosmosdb_tables_test" {
    # This test checks to make sure the resource "cosmosdb_tables" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.cosmosdb_tables.name == "costab-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.slug == "costab"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.max_length == 44
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.cosmosdb_tables.regex == "^[a-z0-9][a-z0-9-_.]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "custom_provider_test" {
    # This test checks to make sure the resource "custom_provider" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.custom_provider.name == "prov-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.slug == "prov"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.custom_provider.regex == "^[^&%?\\/]+[^&%.?\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dashboard_test" {
    # This test checks to make sure the resource "dashboard" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dashboard.name == "dsb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.slug == "dsb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.max_length == 160
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dashboard.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dashboard_grafana_test" {
    # This test checks to make sure the resource "dashboard_grafana" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dashboard_grafana.name == "amg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.slug == "amg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dashboard_grafana.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_test" {
    # This test checks to make sure the resource "data_factory" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory.name == "adf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.slug == "adf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_dataset_mysql_test" {
    # This test checks to make sure the resource "data_factory_dataset_mysql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_dataset_mysql.name == "adfmysql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.slug == "adfmysql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_mysql.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_dataset_postgresql_test" {
    # This test checks to make sure the resource "data_factory_dataset_postgresql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.name == "adfpsql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.slug == "adfpsql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_postgresql.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_dataset_sql_server_table_test" {
    # This test checks to make sure the resource "data_factory_dataset_sql_server_table" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.name == "adfmssql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.slug == "adfmssql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_dataset_sql_server_table.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_integration_runtime_managed_test" {
    # This test checks to make sure the resource "data_factory_integration_runtime_managed" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.name == "adfir-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.slug == "adfir"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_integration_runtime_managed.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_linked_service_data_lake_storage_gen2_test" {
    # This test checks to make sure the resource "data_factory_linked_service_data_lake_storage_gen2" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.name == "adfsvst-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.slug == "adfsvst"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_data_lake_storage_gen2.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_linked_service_key_vault_test" {
    # This test checks to make sure the resource "data_factory_linked_service_key_vault" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.name == "adfsvkv-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.slug == "adfsvkv"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_key_vault.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_linked_service_mysql_test" {
    # This test checks to make sure the resource "data_factory_linked_service_mysql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.name == "adfsvmysql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.slug == "adfsvmysql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_mysql.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_linked_service_postgresql_test" {
    # This test checks to make sure the resource "data_factory_linked_service_postgresql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.name == "adfsvpsql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.slug == "adfsvpsql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_postgresql.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_linked_service_sql_server_test" {
    # This test checks to make sure the resource "data_factory_linked_service_sql_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.name == "adfsvmssql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.slug == "adfsvmssql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_linked_service_sql_server.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_pipeline_test" {
    # This test checks to make sure the resource "data_factory_pipeline" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_pipeline.name == "adfpl-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.slug == "adfpl"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_pipeline.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_factory_trigger_schedule_test" {
    # This test checks to make sure the resource "data_factory_trigger_schedule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_factory_trigger_schedule.name == "adftg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.slug == "adftg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_factory_trigger_schedule.regex == "^[a-zA-Z0-9][^<>*%:.?\\+\\/]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_lake_analytics_account_test" {
    # This test checks to make sure the resource "data_lake_analytics_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_lake_analytics_account.name == "dlatest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.slug == "dla"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_account.regex == "^[a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_lake_analytics_firewall_rule_test" {
    # This test checks to make sure the resource "data_lake_analytics_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.name == "dlfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.slug == "dlfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_analytics_firewall_rule.regex == "^[a-z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_lake_store_test" {
    # This test checks to make sure the resource "data_lake_store" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_lake_store.name == "dlstest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.slug == "dls"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store.regex == "^[a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_lake_store_firewall_rule_test" {
    # This test checks to make sure the resource "data_lake_store_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.name == "dlsfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.slug == "dlsfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_lake_store_firewall_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "data_protection_backup_vault_test" {
    # This test checks to make sure the resource "data_protection_backup_vault" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.data_protection_backup_vault.name == "bvault-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.slug == "bvault"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.data_protection_backup_vault.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "database_migration_project_test" {
    # This test checks to make sure the resource "database_migration_project" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.database_migration_project.name == "migr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.slug == "migr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.max_length == 57
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_project.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "database_migration_service_test" {
    # This test checks to make sure the resource "database_migration_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.database_migration_service.name == "dms-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.slug == "dms"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.max_length == 62
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.database_migration_service.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "databricks_access_connector_test" {
    # This test checks to make sure the resource "databricks_access_connector" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.databricks_access_connector.name == "dbac-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.slug == "dbac"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.max_length == 30
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.databricks_access_connector.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "databricks_cluster_test" {
    # This test checks to make sure the resource "databricks_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.databricks_cluster.name == "dbc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.slug == "dbc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.max_length == 30
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.databricks_cluster.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "databricks_high_concurrency_cluster_test" {
    # This test checks to make sure the resource "databricks_high_concurrency_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.name == "dbhcc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.slug == "dbhcc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.max_length == 30
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.databricks_high_concurrency_cluster.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "databricks_standard_cluster_test" {
    # This test checks to make sure the resource "databricks_standard_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.databricks_standard_cluster.name == "dbsc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.slug == "dbsc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.max_length == 30
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.databricks_standard_cluster.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "databricks_workspace_test" {
    # This test checks to make sure the resource "databricks_workspace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.databricks_workspace.name == "dbw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.slug == "dbw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.max_length == 30
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.databricks_workspace.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dev_test_lab_test" {
    # This test checks to make sure the resource "dev_test_lab" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dev_test_lab.name == "lab-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.slug == "lab"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_lab.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dev_test_linux_virtual_machine_test" {
    # This test checks to make sure the resource "dev_test_linux_virtual_machine" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.name == "labvm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.slug == "labvm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_linux_virtual_machine.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dev_test_windows_virtual_machine_test" {
    # This test checks to make sure the resource "dev_test_windows_virtual_machine" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.name == "labvm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.slug == "labvm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.max_length == 15
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dev_test_windows_virtual_machine.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "disk_encryption_set_test" {
    # This test checks to make sure the resource "disk_encryption_set" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.disk_encryption_set.name == "des-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.slug == "des"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.disk_encryption_set.regex == "^[a-zA-Z0-9_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_a_record_test" {
    # This test checks to make sure the resource "dns_a_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_a_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_a_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_aaaa_record_test" {
    # This test checks to make sure the resource "dns_aaaa_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_aaaa_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_aaaa_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_caa_record_test" {
    # This test checks to make sure the resource "dns_caa_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_caa_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_caa_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_cname_record_test" {
    # This test checks to make sure the resource "dns_cname_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_cname_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_cname_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_mx_record_test" {
    # This test checks to make sure the resource "dns_mx_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_mx_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_mx_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_ns_record_test" {
    # This test checks to make sure the resource "dns_ns_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_ns_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_ns_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_private_resolver_test" {
    # This test checks to make sure the resource "dns_private_resolver" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_private_resolver.name == "dnspr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.slug == "dnspr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_private_resolver.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_ptr_record_test" {
    # This test checks to make sure the resource "dns_ptr_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_ptr_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_ptr_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_txt_record_test" {
    # This test checks to make sure the resource "dns_txt_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_txt_record.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_txt_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "dns_zone_test" {
    # This test checks to make sure the resource "dns_zone" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.dns_zone.name == "dns-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.slug == "dns"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.dns_zone.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_domain_test" {
    # This test checks to make sure the resource "eventgrid_domain" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_domain.name == "egd-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.slug == "egd"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_domain_topic_test" {
    # This test checks to make sure the resource "eventgrid_domain_topic" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_domain_topic.name == "egdt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.slug == "egdt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_domain_topic.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_event_subscription_test" {
    # This test checks to make sure the resource "eventgrid_event_subscription" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_event_subscription.name == "egs-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.slug == "egs"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_event_subscription.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_namespace_test" {
    # This test checks to make sure the resource "eventgrid_namespace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_namespace.name == "evgns-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.slug == "evgns"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_namespace.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_system_topic_test" {
    # This test checks to make sure the resource "eventgrid_system_topic" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_system_topic.name == "egst-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.slug == "egst"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_system_topic.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventgrid_topic_test" {
    # This test checks to make sure the resource "eventgrid_topic" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventgrid_topic.name == "egt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.slug == "egt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventgrid_topic.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_test" {
    # This test checks to make sure the resource "eventhub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub.name == "evh-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.slug == "evh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_authorization_rule_test" {
    # This test checks to make sure the resource "eventhub_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_authorization_rule.name == "ehar-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.slug == "ehar"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_cluster_test" {
    # This test checks to make sure the resource "eventhub_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_cluster.name == "evhcl-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.slug == "evhcl"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.min_length == 6
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_cluster.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_consumer_group_test" {
    # This test checks to make sure the resource "eventhub_consumer_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_consumer_group.name == "ehcg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.slug == "ehcg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_consumer_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_namespace_test" {
    # This test checks to make sure the resource "eventhub_namespace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_namespace.name == "ehn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.slug == "ehn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_namespace_authorization_rule_test" {
    # This test checks to make sure the resource "eventhub_namespace_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.name == "ehnar-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.slug == "ehnar"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "eventhub_namespace_disaster_recovery_config_test" {
    # This test checks to make sure the resource "eventhub_namespace_disaster_recovery_config" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.name == "ehdr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.slug == "ehdr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.eventhub_namespace_disaster_recovery_config.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "express_route_circuit_test" {
    # This test checks to make sure the resource "express_route_circuit" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.express_route_circuit.name == "erc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.slug == "erc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.express_route_circuit.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "express_route_gateway_test" {
    # This test checks to make sure the resource "express_route_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.express_route_gateway.name == "ergw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.slug == "ergw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.express_route_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "fabric_capacity_test" {
    # This test checks to make sure the resource "fabric_capacity" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.fabric_capacity.name == "fctest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.slug == "fc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.scope == "region"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.fabric_capacity.regex == "^[a-z][a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_test" {
    # This test checks to make sure the resource "firewall" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall.name == "fw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall.slug == "fw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_application_rule_collection_test" {
    # This test checks to make sure the resource "firewall_application_rule_collection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_application_rule_collection.name == "fwapp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.slug == "fwapp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_application_rule_collection.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_ip_configuration_test" {
    # This test checks to make sure the resource "firewall_ip_configuration" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_ip_configuration.name == "fwipconf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.slug == "fwipconf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_ip_configuration.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_nat_rule_collection_test" {
    # This test checks to make sure the resource "firewall_nat_rule_collection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_nat_rule_collection.name == "fwnatrc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.slug == "fwnatrc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_nat_rule_collection.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_network_rule_collection_test" {
    # This test checks to make sure the resource "firewall_network_rule_collection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_network_rule_collection.name == "fwnetrc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.slug == "fwnetrc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_network_rule_collection.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_policy_test" {
    # This test checks to make sure the resource "firewall_policy" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_policy.name == "afwp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.slug == "afwp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "firewall_policy_rule_collection_group_test" {
    # This test checks to make sure the resource "firewall_policy_rule_collection_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.name == "fwprcg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.slug == "fwprcg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.firewall_policy_rule_collection_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "frontdoor_test" {
    # This test checks to make sure the resource "frontdoor" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.frontdoor.name == "fd-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.slug == "fd"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.min_length == 5
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "frontdoor_firewall_policy_test" {
    # This test checks to make sure the resource "frontdoor_firewall_policy" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.frontdoor_firewall_policy.name == "fdfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.slug == "fdfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.frontdoor_firewall_policy.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "function_app_test" {
    # This test checks to make sure the resource "function_app" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.function_app.name == "func-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.function_app.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.function_app.slug == "func"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.function_app.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.function_app.max_length == 60
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.function_app.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.function_app.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_hadoop_cluster_test" {
    # This test checks to make sure the resource "hdinsight_hadoop_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.name == "hadoop-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.slug == "hadoop"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hadoop_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_hbase_cluster_test" {
    # This test checks to make sure the resource "hdinsight_hbase_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.name == "hbase-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.slug == "hbase"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_hbase_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_interactive_query_cluster_test" {
    # This test checks to make sure the resource "hdinsight_interactive_query_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.name == "iqr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.slug == "iqr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_interactive_query_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_kafka_cluster_test" {
    # This test checks to make sure the resource "hdinsight_kafka_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.name == "kafka-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.slug == "kafka"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_kafka_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_ml_services_cluster_test" {
    # This test checks to make sure the resource "hdinsight_ml_services_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.name == "mls-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.slug == "mls"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_ml_services_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_rserver_cluster_test" {
    # This test checks to make sure the resource "hdinsight_rserver_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.name == "rsv-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.slug == "rsv"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_rserver_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_spark_cluster_test" {
    # This test checks to make sure the resource "hdinsight_spark_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_spark_cluster.name == "spark-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.slug == "spark"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_spark_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "hdinsight_storm_cluster_test" {
    # This test checks to make sure the resource "hdinsight_storm_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.hdinsight_storm_cluster.name == "storm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.slug == "storm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.max_length == 59
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.hdinsight_storm_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "image_test" {
    # This test checks to make sure the resource "image" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.image.name == "img-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.image.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.image.slug == "img"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.image.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.image.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.image.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.image.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "iotcentral_application_test" {
    # This test checks to make sure the resource "iotcentral_application" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.iotcentral_application.name == "iotapp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.slug == "iotapp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.iotcentral_application.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "iothub_test" {
    # This test checks to make sure the resource "iothub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.iothub.name == "iot-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.iothub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.iothub.slug == "iot"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.iothub.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.iothub.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "iothub_consumer_group_test" {
    # This test checks to make sure the resource "iothub_consumer_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.iothub_consumer_group.name == "iotcg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.slug == "iotcg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.iothub_consumer_group.regex == "^[a-zA-Z0-9-._]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "iothub_dps_test" {
    # This test checks to make sure the resource "iothub_dps" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.iothub_dps.name == "dps-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.slug == "dps"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.scope == "resoureceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps.regex == "^[a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "iothub_dps_certificate_test" {
    # This test checks to make sure the resource "iothub_dps_certificate" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.iothub_dps_certificate.name == "dpscert-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.slug == "dpscert"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.iothub_dps_certificate.regex == "^[a-zA-Z0-9-._]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "ip_group_test" {
    # This test checks to make sure the resource "ip_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.ip_group.name == "ipg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.slug == "ipg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.ip_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "key_vault_test" {
    # This test checks to make sure the resource "key_vault" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.key_vault.name == "kv-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.slug == "kv"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.key_vault.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "key_vault_certificate_test" {
    # This test checks to make sure the resource "key_vault_certificate" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.key_vault_certificate.name == "kvc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.slug == "kvc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.max_length == 127
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_certificate.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "key_vault_key_test" {
    # This test checks to make sure the resource "key_vault_key" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.key_vault_key.name == "kvk-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.slug == "kvk"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.max_length == 127
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_key.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "key_vault_secret_test" {
    # This test checks to make sure the resource "key_vault_secret" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.key_vault_secret.name == "kvs-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.slug == "kvs"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.max_length == 127
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.key_vault_secret.regex == "^[a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "kubernetes_cluster_test" {
    # This test checks to make sure the resource "kubernetes_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.kubernetes_cluster.name == "aks-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.slug == "aks"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.kubernetes_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "kusto_cluster_test" {
    # This test checks to make sure the resource "kusto_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.kusto_cluster.name == "kctest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.slug == "kc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.min_length == 4
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.max_length == 22
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.kusto_cluster.regex == "^[a-z][a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "kusto_database_test" {
    # This test checks to make sure the resource "kusto_database" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.kusto_database.name == "kdb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.slug == "kdb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.kusto_database.regex == "^[a-zA-Z0-9- .]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "kusto_eventhub_data_connection_test" {
    # This test checks to make sure the resource "kusto_eventhub_data_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.name == "kehc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.slug == "kehc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.max_length == 40
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.kusto_eventhub_data_connection.regex == "^[a-zA-Z0-9- .]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "lb_test" {
    # This test checks to make sure the resource "lb" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.lb.name == "lb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.lb.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.lb.slug == "lb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.lb.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.lb.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.lb.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.lb.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "lb_nat_rule_test" {
    # This test checks to make sure the resource "lb_nat_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.lb_nat_rule.name == "lbnatrl-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.slug == "lbnatrl"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.lb_nat_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "lb_rule_test" {
    # This test checks to make sure the resource "lb_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.lb_rule.name == "rule-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.slug == "rule"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.lb_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "linux_virtual_machine_test" {
    # This test checks to make sure the resource "linux_virtual_machine" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.linux_virtual_machine.name == "vm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.slug == "vm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "linux_virtual_machine_scale_set_test" {
    # This test checks to make sure the resource "linux_virtual_machine_scale_set" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.name == "vmss-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.slug == "vmss"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.linux_virtual_machine_scale_set.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "load_test_test" {
    # This test checks to make sure the resource "load_test" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.load_test.name == "lt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.load_test.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.load_test.slug == "lt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.load_test.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.load_test.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.load_test.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.load_test.regex == "^[a-zA-Z][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9|]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "local_network_gateway_test" {
    # This test checks to make sure the resource "local_network_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.local_network_gateway.name == "lgw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.slug == "lgw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.local_network_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "log_analytics_query_pack_test" {
    # This test checks to make sure the resource "log_analytics_query_pack" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.log_analytics_query_pack.name == "pack-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.slug == "pack"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.min_length == 4
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_query_pack.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "log_analytics_workspace_test" {
    # This test checks to make sure the resource "log_analytics_workspace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.log_analytics_workspace.name == "log-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.slug == "log"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.min_length == 4
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.log_analytics_workspace.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "logic_app_integration_account_test" {
    # This test checks to make sure the resource "logic_app_integration_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.logic_app_integration_account.name == "ia-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.slug == "ia"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_integration_account.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._()]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "logic_app_workflow_test" {
    # This test checks to make sure the resource "logic_app_workflow" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.logic_app_workflow.name == "logic-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.slug == "logic"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.logic_app_workflow.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "machine_learning_registry_test" {
    # This test checks to make sure the resource "machine_learning_registry" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.machine_learning_registry.name == "mlr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.slug == "mlr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.max_length == 33
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_registry.regex == "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
        error_message = "'regex' did not match what was expected"
    }
}

run "machine_learning_workspace_test" {
    # This test checks to make sure the resource "machine_learning_workspace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.machine_learning_workspace.name == "mlw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.slug == "mlw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.machine_learning_workspace.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "maintenance_configuration_test" {
    # This test checks to make sure the resource "maintenance_configuration" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.maintenance_configuration.name == "mc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.slug == "mc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.maintenance_configuration.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "managed_disk_test" {
    # This test checks to make sure the resource "managed_disk" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.managed_disk.name == "dsk-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.slug == "dsk"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.managed_disk.regex == "^[a-zA-Z0-9_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "management_group_test" {
    # This test checks to make sure the resource "management_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.management_group.name == "mg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.management_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.management_group.slug == "mg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.management_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.management_group.max_length == 90
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.management_group.scope == "tenant"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.management_group.regex == "^[a-zA-Z0-9-_().]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "maps_account_test" {
    # This test checks to make sure the resource "maps_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.maps_account.name == "map-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.slug == "map"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.max_length == 98
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.maps_account.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mariadb_database_test" {
    # This test checks to make sure the resource "mariadb_database" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mariadb_database.name == "mariadb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.slug == "mariadb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_database.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mariadb_firewall_rule_test" {
    # This test checks to make sure the resource "mariadb_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mariadb_firewall_rule.name == "mariafw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.slug == "mariafw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_firewall_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mariadb_server_test" {
    # This test checks to make sure the resource "mariadb_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mariadb_server.name == "maria-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.slug == "maria"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_server.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mariadb_virtual_network_rule_test" {
    # This test checks to make sure the resource "mariadb_virtual_network_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.name == "mariavn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.slug == "mariavn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mariadb_virtual_network_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_action_group_test" {
    # This test checks to make sure the resource "monitor_action_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_action_group.name == "mag-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.slug == "mag"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_action_group.regex == "^[^%&?\\+\\/]+[^^%&?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_alert_processing_rule_action_group_test" {
    # This test checks to make sure the resource "monitor_alert_processing_rule_action_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.name == "apr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.slug == "apr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_alert_processing_rule_action_group.regex == "^[^<>*{}%&:\\?+/#|]+[^<>*{}%&:\\?+/#| ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_autoscale_setting_test" {
    # This test checks to make sure the resource "monitor_autoscale_setting" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_autoscale_setting.name == "mas-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.slug == "mas"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_autoscale_setting.regex == "^[^<>%&#.,?\\+\\/]+[^<>%&#.,?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_data_collection_endpoint_test" {
    # This test checks to make sure the resource "monitor_data_collection_endpoint" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.name == "dce-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.slug == "dce"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_endpoint.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_data_collection_rule_test" {
    # This test checks to make sure the resource "monitor_data_collection_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_data_collection_rule.name == "dcr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.slug == "dcr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_data_collection_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_diagnostic_setting_test" {
    # This test checks to make sure the resource "monitor_diagnostic_setting" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_diagnostic_setting.name == "mds-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.slug == "mds"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_diagnostic_setting.regex == "^[^*<>%:&?\\+\\/]+[^*<>%:&?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "monitor_scheduled_query_rules_alert_test" {
    # This test checks to make sure the resource "monitor_scheduled_query_rules_alert" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.name == "msqa-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.slug == "msqa"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.monitor_scheduled_query_rules_alert.regex == "^[^*<>%:{}&#.,?\\+\\/]+[^*<>%:{}&#.,?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mssql_database_test" {
    # This test checks to make sure the resource "mssql_database" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mssql_database.name == "sqldb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.slug == "sqldb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mssql_database.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mssql_elasticpool_test" {
    # This test checks to make sure the resource "mssql_elasticpool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mssql_elasticpool.name == "sqlep-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.slug == "sqlep"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mssql_elasticpool.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mssql_job_agent_test" {
    # This test checks to make sure the resource "mssql_job_agent" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mssql_job_agent.name == "sqlja-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.slug == "sqlja"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mssql_job_agent.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mssql_managed_instance_test" {
    # This test checks to make sure the resource "mssql_managed_instance" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mssql_managed_instance.name == "sqlmi-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.slug == "sqlmi"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mssql_managed_instance.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mssql_server_test" {
    # This test checks to make sure the resource "mssql_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mssql_server.name == "sql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.slug == "sql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mssql_server.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mysql_database_test" {
    # This test checks to make sure the resource "mysql_database" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mysql_database.name == "mysqldb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.slug == "mysqldb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mysql_database.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mysql_firewall_rule_test" {
    # This test checks to make sure the resource "mysql_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mysql_firewall_rule.name == "mysqlfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.slug == "mysqlfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mysql_firewall_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mysql_server_test" {
    # This test checks to make sure the resource "mysql_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mysql_server.name == "mysql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.slug == "mysql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mysql_server.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "mysql_virtual_network_rule_test" {
    # This test checks to make sure the resource "mysql_virtual_network_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.mysql_virtual_network_rule.name == "mysqlvn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.slug == "mysqlvn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.mysql_virtual_network_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "nat_gateway_test" {
    # This test checks to make sure the resource "nat_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.nat_gateway.name == "ng-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.slug == "ng"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.nat_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_ddos_protection_plan_test" {
    # This test checks to make sure the resource "network_ddos_protection_plan" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_ddos_protection_plan.name == "ddospp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.slug == "ddospp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_ddos_protection_plan.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_interface_test" {
    # This test checks to make sure the resource "network_interface" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_interface.name == "nic-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.slug == "nic"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_interface.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_manager_test" {
    # This test checks to make sure the resource "network_manager" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_manager.name == "vnm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.slug == "vnm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_manager.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_security_group_test" {
    # This test checks to make sure the resource "network_security_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_security_group.name == "nsg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.slug == "nsg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_security_group_rule_test" {
    # This test checks to make sure the resource "network_security_group_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_security_group_rule.name == "nsgr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.slug == "nsgr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_security_group_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_security_rule_test" {
    # This test checks to make sure the resource "network_security_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_security_rule.name == "nsgr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.slug == "nsgr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_security_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "network_watcher_test" {
    # This test checks to make sure the resource "network_watcher" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.network_watcher.name == "nw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.slug == "nw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.network_watcher.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "notification_hub_test" {
    # This test checks to make sure the resource "notification_hub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.notification_hub.name == "nh-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.slug == "nh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "notification_hub_authorization_rule_test" {
    # This test checks to make sure the resource "notification_hub_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.notification_hub_authorization_rule.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.max_length == 256
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "notification_hub_namespace_test" {
    # This test checks to make sure the resource "notification_hub_namespace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.notification_hub_namespace.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.min_length == 6
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.notification_hub_namespace.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "point_to_site_vpn_gateway_test" {
    # This test checks to make sure the resource "point_to_site_vpn_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.name == "vpngw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.slug == "vpngw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.point_to_site_vpn_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "policy_definition_test" {
    # This test checks to make sure the resource "policy_definition" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.policy_definition.name == "pdef-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.slug == "pdef"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.scope == "tenant"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.policy_definition.regex == "^[^<>*%&:?./+]+[^<>*%&:?./+ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "postgresql_database_test" {
    # This test checks to make sure the resource "postgresql_database" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.postgresql_database.name == "psqldb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.slug == "psqldb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_database.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "postgresql_firewall_rule_test" {
    # This test checks to make sure the resource "postgresql_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.postgresql_firewall_rule.name == "psqlfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.slug == "psqlfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_firewall_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "postgresql_server_test" {
    # This test checks to make sure the resource "postgresql_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.postgresql_server.name == "psql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.slug == "psql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_server.regex == "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "postgresql_virtual_network_rule_test" {
    # This test checks to make sure the resource "postgresql_virtual_network_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.name == "psqlvn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.slug == "psqlvn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.postgresql_virtual_network_rule.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "powerbi_embedded_test" {
    # This test checks to make sure the resource "powerbi_embedded" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.powerbi_embedded.name == "pbi-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.slug == "pbi"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.scope == "region"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.powerbi_embedded.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_a_record_test" {
    # This test checks to make sure the resource "private_dns_a_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_a_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_a_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_aaaa_record_test" {
    # This test checks to make sure the resource "private_dns_aaaa_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_aaaa_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_aaaa_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_cname_record_test" {
    # This test checks to make sure the resource "private_dns_cname_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_cname_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_cname_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_mx_record_test" {
    # This test checks to make sure the resource "private_dns_mx_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_mx_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_mx_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_ptr_record_test" {
    # This test checks to make sure the resource "private_dns_ptr_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_ptr_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_ptr_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_srv_record_test" {
    # This test checks to make sure the resource "private_dns_srv_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_srv_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_srv_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_txt_record_test" {
    # This test checks to make sure the resource "private_dns_txt_record" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_txt_record.name == "pdnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.slug == "pdnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_txt_record.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_zone_test" {
    # This test checks to make sure the resource "private_dns_zone" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_zone.name == "pdns-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.slug == "pdns"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_dns_zone_group_test" {
    # This test checks to make sure the resource "private_dns_zone_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_dns_zone_group.name == "pdnszg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.slug == "pdnszg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_dns_zone_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_endpoint_test" {
    # This test checks to make sure the resource "private_endpoint" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_endpoint.name == "pe-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.slug == "pe"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_endpoint.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_link_service_test" {
    # This test checks to make sure the resource "private_link_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_link_service.name == "pls-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.slug == "pls"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_link_service.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "private_service_connection_test" {
    # This test checks to make sure the resource "private_service_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.private_service_connection.name == "psc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.slug == "psc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.private_service_connection.regex == "^[a-zA-Z0-9][a-zA-Z0-9\\-\\._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "proximity_placement_group_test" {
    # This test checks to make sure the resource "proximity_placement_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.proximity_placement_group.name == "ppg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.slug == "ppg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.proximity_placement_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "public_ip_test" {
    # This test checks to make sure the resource "public_ip" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.public_ip.name == "pip-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.slug == "pip"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.public_ip.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "public_ip_prefix_test" {
    # This test checks to make sure the resource "public_ip_prefix" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.public_ip_prefix.name == "pippf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.slug == "pippf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.public_ip_prefix.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "purview_account_test" {
    # This test checks to make sure the resource "purview_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.purview_account.name == "pview-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.slug == "pview"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.purview_account.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "recovery_services_vault_test" {
    # This test checks to make sure the resource "recovery_services_vault" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.recovery_services_vault.name == "rsv-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.slug == "rsv"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.recovery_services_vault.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "redhat_openshift_cluster_test" {
    # This test checks to make sure the resource "redhat_openshift_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.redhat_openshift_cluster.name == "aro-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.slug == "aro"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.redhat_openshift_cluster.regex == "^[a-zA-Z0-9][a-zA-Z0-9-_.]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "redis_cache_test" {
    # This test checks to make sure the resource "redis_cache" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.redis_cache.name == "redis-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.slug == "redis"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.redis_cache.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "redis_firewall_rule_test" {
    # This test checks to make sure the resource "redis_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.redis_firewall_rule.name == "redisfwtest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.slug == "redisfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.max_length == 256
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.redis_firewall_rule.regex == "^[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "relay_hybrid_connection_test" {
    # This test checks to make sure the resource "relay_hybrid_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.relay_hybrid_connection.name == "rlhc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.slug == "rlhc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.relay_hybrid_connection.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "relay_namespace_test" {
    # This test checks to make sure the resource "relay_namespace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.relay_namespace.name == "rln-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.slug == "rln"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.min_length == 6
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.relay_namespace.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "resource_group_test" {
    # This test checks to make sure the resource "resource_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.resource_group.name == "rg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.slug == "rg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.max_length == 90
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.scope == "subscription"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.resource_group.regex == "^[a-zA-Z0-9-._\\(\\)]+[a-zA-Z0-9-_\\(\\)]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "resource_group_template_deployment_test" {
    # This test checks to make sure the resource "resource_group_template_deployment" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.resource_group_template_deployment.name == "ts-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.slug == "ts"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.max_length == 90
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.resource_group_template_deployment.regex == "^[a-zA-Z0-9-._()]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "role_assignment_test" {
    # This test checks to make sure the resource "role_assignment" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.role_assignment.name == "ra-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.slug == "ra"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.scope == "assignment"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.role_assignment.regex == "^[^%]+[^ %.]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "role_definition_test" {
    # This test checks to make sure the resource "role_definition" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.role_definition.name == "rd-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.slug == "rd"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.scope == "definition"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.role_definition.regex == "^[^%]+[^ %.]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "route_test" {
    # This test checks to make sure the resource "route" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.route.name == "rt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.route.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.route.slug == "rt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.route.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.route.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.route.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.route.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "route_filter_test" {
    # This test checks to make sure the resource "route_filter" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.route_filter.name == "rf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.slug == "rf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.route_filter.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "route_server_test" {
    # This test checks to make sure the resource "route_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.route_server.name == "rtserv-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.route_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.route_server.slug == "rtserv"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.route_server.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.route_server.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.route_server.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.route_server.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "route_table_test" {
    # This test checks to make sure the resource "route_table" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.route_table.name == "route-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.route_table.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.route_table.slug == "route"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.route_table.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.route_table.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.route_table.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.route_table.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "search_service_test" {
    # This test checks to make sure the resource "search_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.search_service.name == "srch-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.search_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.search_service.slug == "srch"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.search_service.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.search_service.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.search_service.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.search_service.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "service_fabric_cluster_test" {
    # This test checks to make sure the resource "service_fabric_cluster" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.service_fabric_cluster.name == "sf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.slug == "sf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.min_length == 4
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.max_length == 23
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.scope == "region"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.service_fabric_cluster.regex == "^[a-z][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_namespace_test" {
    # This test checks to make sure the resource "servicebus_namespace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_namespace.name == "sb-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.slug == "sb"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.min_length == 6
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace.regex == "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_namespace_authorization_rule_test" {
    # This test checks to make sure the resource "servicebus_namespace_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.name == "sbar-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.slug == "sbar"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_namespace_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_queue_test" {
    # This test checks to make sure the resource "servicebus_queue" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_queue.name == "sbq-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.slug == "sbq"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_queue_authorization_rule_test" {
    # This test checks to make sure the resource "servicebus_queue_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.name == "sbqar-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.slug == "sbqar"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_queue_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_subscription_test" {
    # This test checks to make sure the resource "servicebus_subscription" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_subscription.name == "sbs-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.slug == "sbs"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_subscription_rule_test" {
    # This test checks to make sure the resource "servicebus_subscription_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_subscription_rule.name == "sbsr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.slug == "sbsr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_subscription_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_topic_test" {
    # This test checks to make sure the resource "servicebus_topic" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_topic.name == "sbt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.slug == "sbt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.max_length == 260
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "servicebus_topic_authorization_rule_test" {
    # This test checks to make sure the resource "servicebus_topic_authorization_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.name == "dnsrec-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.slug == "dnsrec"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.servicebus_topic_authorization_rule.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "shared_image_test" {
    # This test checks to make sure the resource "shared_image" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.shared_image.name == "si-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.slug == "si"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.shared_image.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "shared_image_gallery_test" {
    # This test checks to make sure the resource "shared_image_gallery" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.shared_image_gallery.name == "sigtest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.slug == "sig"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.shared_image_gallery.regex == "^[a-zA-Z0-9][a-zA-Z0-9.]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "signalr_service_test" {
    # This test checks to make sure the resource "signalr_service" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.signalr_service.name == "sgnlr-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.slug == "sgnlr"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.signalr_service.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "snapshots_test" {
    # This test checks to make sure the resource "snapshots" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.snapshots.name == "snap-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.slug == "snap"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.snapshots.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "sql_elasticpool_test" {
    # This test checks to make sure the resource "sql_elasticpool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.sql_elasticpool.name == "sqlep-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.slug == "sqlep"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.sql_elasticpool.regex == "^[^<>*%:.?\\+\\/]+[^<>*%:.?\\+\\/ ]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "sql_failover_group_test" {
    # This test checks to make sure the resource "sql_failover_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.sql_failover_group.name == "sqlfg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.slug == "sqlfg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.sql_failover_group.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "sql_firewall_rule_test" {
    # This test checks to make sure the resource "sql_firewall_rule" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.sql_firewall_rule.name == "sqlfw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.slug == "sqlfw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.sql_firewall_rule.regex == "^[^<>*%:?\\+\\/]+[^<>*%:.?\\+\\/]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "sql_server_test" {
    # This test checks to make sure the resource "sql_server" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.sql_server.name == "sql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.slug == "sql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.sql_server.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "ssh_public_key_test" {
    # This test checks to make sure the resource "ssh_public_key" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.ssh_public_key.name == "sshkey-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.slug == "sshkey"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.ssh_public_key.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "static_web_app_test" {
    # This test checks to make sure the resource "static_web_app" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.static_web_app.name == "stapp-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.slug == "stapp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.max_length == 40
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.static_web_app.regex == "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_account_test" {
    # This test checks to make sure the resource "storage_account" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_account.name == "sttest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.slug == "st"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.max_length == 24
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_account.regex == "^[a-z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_blob_test" {
    # This test checks to make sure the resource "storage_blob" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_blob.name == "blob-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.slug == "blob"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.max_length == 1024
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_blob.regex == "^[^\\s\\/$#&]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_container_test" {
    # This test checks to make sure the resource "storage_container" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_container.name == "stct-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.slug == "stct"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_container.regex == "^[a-z0-9][a-z0-9-]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_data_lake_gen2_filesystem_test" {
    # This test checks to make sure the resource "storage_data_lake_gen2_filesystem" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.name == "stdl-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.slug == "stdl"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_data_lake_gen2_filesystem.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_queue_test" {
    # This test checks to make sure the resource "storage_queue" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_queue.name == "stq-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.slug == "stq"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_queue.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_share_test" {
    # This test checks to make sure the resource "storage_share" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_share.name == "sts-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.slug == "sts"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_share.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_share_directory_test" {
    # This test checks to make sure the resource "storage_share_directory" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_share_directory.name == "sts-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.slug == "sts"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_share_directory.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "storage_table_test" {
    # This test checks to make sure the resource "storage_table" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.storage_table.name == "stt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.slug == "stt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.storage_table.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_function_javascript_udf_test" {
    # This test checks to make sure the resource "stream_analytics_function_javascript_udf" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.name == "asafunc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.slug == "asafunc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_function_javascript_udf.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_job_test" {
    # This test checks to make sure the resource "stream_analytics_job" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_job.name == "asa-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.slug == "asa"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_job.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_output_blob_test" {
    # This test checks to make sure the resource "stream_analytics_output_blob" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_output_blob.name == "asaoblob-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.slug == "asaoblob"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_blob.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_output_eventhub_test" {
    # This test checks to make sure the resource "stream_analytics_output_eventhub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.name == "asaoeh-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.slug == "asaoeh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_eventhub.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_output_mssql_test" {
    # This test checks to make sure the resource "stream_analytics_output_mssql" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_output_mssql.name == "asaomssql-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.slug == "asaomssql"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_mssql.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_output_servicebus_queue_test" {
    # This test checks to make sure the resource "stream_analytics_output_servicebus_queue" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.name == "asaosbq-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.slug == "asaosbq"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_queue.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_output_servicebus_topic_test" {
    # This test checks to make sure the resource "stream_analytics_output_servicebus_topic" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.name == "asaosbt-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.slug == "asaosbt"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_output_servicebus_topic.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_reference_input_blob_test" {
    # This test checks to make sure the resource "stream_analytics_reference_input_blob" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.name == "asarblob-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.slug == "asarblob"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_reference_input_blob.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_stream_input_blob_test" {
    # This test checks to make sure the resource "stream_analytics_stream_input_blob" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.name == "asaiblob-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.slug == "asaiblob"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_blob.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_stream_input_eventhub_test" {
    # This test checks to make sure the resource "stream_analytics_stream_input_eventhub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.name == "asaieh-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.slug == "asaieh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_eventhub.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "stream_analytics_stream_input_iothub_test" {
    # This test checks to make sure the resource "stream_analytics_stream_input_iothub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.name == "asaiiot-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.slug == "asaiiot"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.stream_analytics_stream_input_iothub.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "subnet_test" {
    # This test checks to make sure the resource "subnet" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.subnet.name == "snet-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.subnet.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.subnet.slug == "snet"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.subnet.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.subnet.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.subnet.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.subnet.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "subnet_service_endpoint_storage_policy_test" {
    # This test checks to make sure the resource "subnet_service_endpoint_storage_policy" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.name == "se-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.slug == "se"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.subnet_service_endpoint_storage_policy.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "synapse_private_link_hub_test" {
    # This test checks to make sure the resource "synapse_private_link_hub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.synapse_private_link_hub.name == "synplh-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.slug == "synplh"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.synapse_private_link_hub.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "synapse_spark_pool_test" {
    # This test checks to make sure the resource "synapse_spark_pool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.synapse_spark_pool.name == "synsptest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.slug == "synsp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.max_length == 32
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.synapse_spark_pool.regex == "^[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "synapse_sql_pool_test" {
    # This test checks to make sure the resource "synapse_sql_pool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.synapse_sql_pool.name == "syndptest"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.dashes == false
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.slug == "syndp"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.max_length == 60
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.synapse_sql_pool.regex == "^[a-zA-Z0-9]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "synapse_workspace_test" {
    # This test checks to make sure the resource "synapse_workspace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.synapse_workspace.name == "synw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.slug == "synw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.max_length == 50
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.synapse_workspace.regex == "^[a-z0-9][a-z0-9-]+[a-z0-9]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "template_deployment_test" {
    # This test checks to make sure the resource "template_deployment" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.template_deployment.name == "deploy-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.slug == "deploy"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.template_deployment.regex == "^[a-zA-Z0-9-._\\(\\)]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "traffic_manager_profile_test" {
    # This test checks to make sure the resource "traffic_manager_profile" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.traffic_manager_profile.name == "traf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.slug == "traf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.scope == "global"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.traffic_manager_profile.regex == "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "user_assigned_identity_test" {
    # This test checks to make sure the resource "user_assigned_identity" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.user_assigned_identity.name == "uai-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.slug == "uai"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.max_length == 128
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.user_assigned_identity.regex == "^[a-zA-Z0-9-_]+$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_desktop_application_group_test" {
    # This test checks to make sure the resource "virtual_desktop_application_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_desktop_application_group.name == "vdag-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.slug == "vdag"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_application_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_desktop_host_pool_test" {
    # This test checks to make sure the resource "virtual_desktop_host_pool" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_desktop_host_pool.name == "vdpool-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.slug == "vdpool"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_host_pool.regex == "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_desktop_scaling_plan_test" {
    # This test checks to make sure the resource "virtual_desktop_scaling_plan" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.name == "vdscaling-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.slug == "vdscaling"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_scaling_plan.regex == "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_desktop_workspace_test" {
    # This test checks to make sure the resource "virtual_desktop_workspace" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_desktop_workspace.name == "vdws-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.slug == "vdws"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.min_length == 3
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.max_length == 63
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_desktop_workspace.regex == "^[a-zA-Z0-9][a-zA-Z0-9-.]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_hub_test" {
    # This test checks to make sure the resource "virtual_hub" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_hub.name == "vhub-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.slug == "vhub"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_hub.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_machine_test" {
    # This test checks to make sure the resource "virtual_machine" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_machine.name == "vm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.slug == "vm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.max_length == 15
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_machine_extension_test" {
    # This test checks to make sure the resource "virtual_machine_extension" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_machine_extension.name == "vmx-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.slug == "vmx"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_extension.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_machine_restore_point_collection_test" {
    # This test checks to make sure the resource "virtual_machine_restore_point_collection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.name == "rpc-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.slug == "rpc"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_restore_point_collection.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_machine_scale_set_test" {
    # This test checks to make sure the resource "virtual_machine_scale_set" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_machine_scale_set.name == "vmss-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.slug == "vmss"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.max_length == 15
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_machine_scale_set_extension_test" {
    # This test checks to make sure the resource "virtual_machine_scale_set_extension" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.name == "vmssx-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.slug == "vmssx"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_machine_scale_set_extension.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_network_test" {
    # This test checks to make sure the resource "virtual_network" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_network.name == "vnet-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.slug == "vnet"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.min_length == 2
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.max_length == 64
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_network_gateway_test" {
    # This test checks to make sure the resource "virtual_network_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_network_gateway.name == "vgw-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.slug == "vgw"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_network_gateway_connection_test" {
    # This test checks to make sure the resource "virtual_network_gateway_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_network_gateway_connection.name == "vcn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.slug == "vcn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_gateway_connection.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_network_peering_test" {
    # This test checks to make sure the resource "virtual_network_peering" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_network_peering.name == "vpeer-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.slug == "vpeer"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_network_peering.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "virtual_wan_test" {
    # This test checks to make sure the resource "virtual_wan" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.virtual_wan.name == "vwan-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.slug == "vwan"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.virtual_wan.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "vpn_gateway_test" {
    # This test checks to make sure the resource "vpn_gateway" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.vpn_gateway.name == "vpng-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.slug == "vpng"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "vpn_gateway_connection_test" {
    # This test checks to make sure the resource "vpn_gateway_connection" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.vpn_gateway_connection.name == "vcn-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.slug == "vcn"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.vpn_gateway_connection.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "vpn_site_test" {
    # This test checks to make sure the resource "vpn_site" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.vpn_site.name == "vst-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.slug == "vst"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.vpn_site.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "web_application_firewall_policy_test" {
    # This test checks to make sure the resource "web_application_firewall_policy" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.web_application_firewall_policy.name == "waf-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.slug == "waf"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "web_application_firewall_policy_rule_group_test" {
    # This test checks to make sure the resource "web_application_firewall_policy_rule_group" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.name == "wafrg-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.slug == "wafrg"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.max_length == 80
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.scope == "parent"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.web_application_firewall_policy_rule_group.regex == "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "windows_virtual_machine_test" {
    # This test checks to make sure the resource "windows_virtual_machine" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.windows_virtual_machine.name == "vm-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.slug == "vm"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.max_length == 15
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}

run "windows_virtual_machine_scale_set_test" {
    # This test checks to make sure the resource "windows_virtual_machine_scale_set" values are as expected.
    command = plan

    variables {
        suffix = [ "test" ]
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.name == "vmss-test"
        error_message = "'name' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.dashes == true
        error_message = "'dashes' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.slug == "vmss"
        error_message = "'slug' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.min_length == 1
        error_message = "'min_length' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.max_length == 15
        error_message = "'max_length' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.scope == "resourceGroup"
        error_message = "'scope' did not match what was expected"
    }

    assert {
        condition     = output.windows_virtual_machine_scale_set.regex == "^[^\\/\"\\[\\]:|<>+=;,?*@&_][^\\/\"\\[\\]:|<>+=;,?*@&]+[^\\/\"\\[\\]:|<>+=;,?*@&.-]$"
        error_message = "'regex' did not match what was expected"
    }
}