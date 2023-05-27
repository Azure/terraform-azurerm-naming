# Azure Naming

This module helps you to keep consistency on your resources names for Terraform The goal of this module it is that for each resource that requires a name in Terraform you would be easily able to compose this name using this module and this will keep the consistency in your repositories.

# Usage

For every resource in `terraform_azurerm` just remove the `azurerm` part of the module and use the `name` property of this output.

example for `azurerm_resource_group` you can use :

```tf
module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "test" ]
}
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = "West Europe"
}
```

if you want this to be unique for this module and not shared with other instances of this module you can use `name_unique`

```tf
module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "test" ]
}
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name_unique
  location = "West Europe"
}
```
Other advanced usages will be explained in the [Advanced usage](#advanced-usage) part of this docs.

# Internals

## Prerequisites and setup

- Install [tflint](https://github.com/terraform-linters/tflint) as suitable for your OS.

- Run `make install` in the root directory of the repo.

## Modifying resources

The resources are automatically generated using `go` to change the generation please change the file on the `templates` folder. To add a new resource, including its definition in the file `resourceDefinition.json`, and it will be automatically generated when `main.go` is run.

# Current implementation

You can find a list bellow of all the resources that are currently implemented. To get a list of the ones that are missing implementation you can check at [Missing resources](docs/missing_resources.md) the resources that have no documentation about their limitation on naming currently on Microsoft docs are on the [Not defined](docs/not_defined.md) list.


# Advanced usage


## Output

Each one of the resources emits the name of the resource and other properties:

| Property | Type | Description |
| ----- |----- | ---- |
| name | string | name of the resource including respective suffixes and prefixes applied |
| name_unique | string | same as the name but with random chars added for uniqueness |
| dashes | bool | if these resources support dashes |
| slug | string | letters to identify this resource among others |
| min_length | integer | Minimum length required for this resource name |
| max_length | integer | Maximum length allowed for this resource name |
| scope | string | scope which this name needs to be unique, such as `resourcegroup` or `global`  |
| regex | string | Terraform compatible version of the regex |

### Example Output

Every resource will have an output with the following format:

```go
postgresql_server = {
      name        = "pre-fix-psql-su-fix"
      name_unique = "pre-fix-psql-su-fix-asdfg"
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
    }
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_string.first_letter](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | It is not recommended that you use prefix by azure you should be using a suffix for your resources. | `list(string)` | `[]` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | It is recommended that you specify a suffix for consistency. please use only lowercase characters when possible | `list(string)` | `[]` | no |
| <a name="input_unique-include-numbers"></a> [unique-include-numbers](#input\_unique-include-numbers) | If you want to include numbers in the unique generation | `bool` | `true` | no |
| <a name="input_unique-length"></a> [unique-length](#input\_unique-length) | Max length of the uniqueness suffix to be added | `number` | `4` | no |
| <a name="input_unique-seed"></a> [unique-seed](#input\_unique-seed) | Custom value for the random characters to be used | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analysis_services_server"></a> [analysis\_services\_server](#output\_analysis\_services\_server) | Analysis Services Server |
| <a name="output_api_management"></a> [api\_management](#output\_api\_management) | Api Management |
| <a name="output_app_configuration"></a> [app\_configuration](#output\_app\_configuration) | App Configuration |
| <a name="output_app_service"></a> [app\_service](#output\_app\_service) | App Service |
| <a name="output_app_service_plan"></a> [app\_service\_plan](#output\_app\_service\_plan) | App Service Plan |
| <a name="output_application_gateway"></a> [application\_gateway](#output\_application\_gateway) | Application Gateway |
| <a name="output_application_insights"></a> [application\_insights](#output\_application\_insights) | Application Insights |
| <a name="output_application_security_group"></a> [application\_security\_group](#output\_application\_security\_group) | Application Security Group |
| <a name="output_automation_account"></a> [automation\_account](#output\_automation\_account) | Automation Account |
| <a name="output_automation_certificate"></a> [automation\_certificate](#output\_automation\_certificate) | Automation Certificate |
| <a name="output_automation_credential"></a> [automation\_credential](#output\_automation\_credential) | Automation Credential |
| <a name="output_automation_runbook"></a> [automation\_runbook](#output\_automation\_runbook) | Automation Runbook |
| <a name="output_automation_schedule"></a> [automation\_schedule](#output\_automation\_schedule) | Automation Schedule |
| <a name="output_automation_variable"></a> [automation\_variable](#output\_automation\_variable) | Automation Variable |
| <a name="output_availability_set"></a> [availability\_set](#output\_availability\_set) | Availability Set |
| <a name="output_bastion_host"></a> [bastion\_host](#output\_bastion\_host) | Bastion Host |
| <a name="output_batch_account"></a> [batch\_account](#output\_batch\_account) | Batch Account |
| <a name="output_batch_application"></a> [batch\_application](#output\_batch\_application) | Batch Application |
| <a name="output_batch_certificate"></a> [batch\_certificate](#output\_batch\_certificate) | Batch Certificate |
| <a name="output_batch_pool"></a> [batch\_pool](#output\_batch\_pool) | Batch Pool |
| <a name="output_bot_channel_directline"></a> [bot\_channel\_directline](#output\_bot\_channel\_directline) | Bot Channel Directline |
| <a name="output_bot_channel_email"></a> [bot\_channel\_email](#output\_bot\_channel\_email) | Bot Channel Email |
| <a name="output_bot_channel_ms_teams"></a> [bot\_channel\_ms\_teams](#output\_bot\_channel\_ms\_teams) | Bot Channel Ms Teams |
| <a name="output_bot_channel_slack"></a> [bot\_channel\_slack](#output\_bot\_channel\_slack) | Bot Channel Slack |
| <a name="output_bot_channels_registration"></a> [bot\_channels\_registration](#output\_bot\_channels\_registration) | Bot Channels Registration |
| <a name="output_bot_connection"></a> [bot\_connection](#output\_bot\_connection) | Bot Connection |
| <a name="output_bot_web_app"></a> [bot\_web\_app](#output\_bot\_web\_app) | Bot Web App |
| <a name="output_cdn_endpoint"></a> [cdn\_endpoint](#output\_cdn\_endpoint) | Cdn Endpoint |
| <a name="output_cdn_profile"></a> [cdn\_profile](#output\_cdn\_profile) | Cdn Profile |
| <a name="output_cognitive_account"></a> [cognitive\_account](#output\_cognitive\_account) | Cognitive Account |
| <a name="output_container_group"></a> [container\_group](#output\_container\_group) | Container Group |
| <a name="output_container_registry"></a> [container\_registry](#output\_container\_registry) | Container Registry |
| <a name="output_container_registry_webhook"></a> [container\_registry\_webhook](#output\_container\_registry\_webhook) | Container Registry Webhook |
| <a name="output_cosmosdb_account"></a> [cosmosdb\_account](#output\_cosmosdb\_account) | Cosmosdb Account |
| <a name="output_cosmosdb_cassandra_cluster"></a> [cosmosdb\_cassandra\_cluster](#output\_cosmosdb\_cassandra\_cluster) | Cosmosdb Cassandra Cluster |
| <a name="output_cosmosdb_cassandra_datacenter"></a> [cosmosdb\_cassandra\_datacenter](#output\_cosmosdb\_cassandra\_datacenter) | Cosmosdb Cassandra Datacenter |
| <a name="output_cosmosdb_postgres"></a> [cosmosdb\_postgres](#output\_cosmosdb\_postgres) | Cosmosdb Postgres |
| <a name="output_custom_provider"></a> [custom\_provider](#output\_custom\_provider) | Custom Provider |
| <a name="output_dashboard"></a> [dashboard](#output\_dashboard) | Dashboard |
| <a name="output_data_factory"></a> [data\_factory](#output\_data\_factory) | Data Factory |
| <a name="output_data_factory_dataset_mysql"></a> [data\_factory\_dataset\_mysql](#output\_data\_factory\_dataset\_mysql) | Data Factory Dataset Mysql |
| <a name="output_data_factory_dataset_postgresql"></a> [data\_factory\_dataset\_postgresql](#output\_data\_factory\_dataset\_postgresql) | Data Factory Dataset Postgresql |
| <a name="output_data_factory_dataset_sql_server_table"></a> [data\_factory\_dataset\_sql\_server\_table](#output\_data\_factory\_dataset\_sql\_server\_table) | Data Factory Dataset Sql Server Table |
| <a name="output_data_factory_integration_runtime_managed"></a> [data\_factory\_integration\_runtime\_managed](#output\_data\_factory\_integration\_runtime\_managed) | Data Factory Integration Runtime Managed |
| <a name="output_data_factory_linked_service_data_lake_storage_gen2"></a> [data\_factory\_linked\_service\_data\_lake\_storage\_gen2](#output\_data\_factory\_linked\_service\_data\_lake\_storage\_gen2) | Data Factory Linked Service Data Lake Storage Gen2 |
| <a name="output_data_factory_linked_service_key_vault"></a> [data\_factory\_linked\_service\_key\_vault](#output\_data\_factory\_linked\_service\_key\_vault) | Data Factory Linked Service Key Vault |
| <a name="output_data_factory_linked_service_mysql"></a> [data\_factory\_linked\_service\_mysql](#output\_data\_factory\_linked\_service\_mysql) | Data Factory Linked Service Mysql |
| <a name="output_data_factory_linked_service_postgresql"></a> [data\_factory\_linked\_service\_postgresql](#output\_data\_factory\_linked\_service\_postgresql) | Data Factory Linked Service Postgresql |
| <a name="output_data_factory_linked_service_sql_server"></a> [data\_factory\_linked\_service\_sql\_server](#output\_data\_factory\_linked\_service\_sql\_server) | Data Factory Linked Service Sql Server |
| <a name="output_data_factory_pipeline"></a> [data\_factory\_pipeline](#output\_data\_factory\_pipeline) | Data Factory Pipeline |
| <a name="output_data_factory_trigger_schedule"></a> [data\_factory\_trigger\_schedule](#output\_data\_factory\_trigger\_schedule) | Data Factory Trigger Schedule |
| <a name="output_data_lake_analytics_account"></a> [data\_lake\_analytics\_account](#output\_data\_lake\_analytics\_account) | Data Lake Analytics Account |
| <a name="output_data_lake_analytics_firewall_rule"></a> [data\_lake\_analytics\_firewall\_rule](#output\_data\_lake\_analytics\_firewall\_rule) | Data Lake Analytics Firewall Rule |
| <a name="output_data_lake_store"></a> [data\_lake\_store](#output\_data\_lake\_store) | Data Lake Store |
| <a name="output_data_lake_store_firewall_rule"></a> [data\_lake\_store\_firewall\_rule](#output\_data\_lake\_store\_firewall\_rule) | Data Lake Store Firewall Rule |
| <a name="output_database_migration_project"></a> [database\_migration\_project](#output\_database\_migration\_project) | Database Migration Project |
| <a name="output_database_migration_service"></a> [database\_migration\_service](#output\_database\_migration\_service) | Database Migration Service |
| <a name="output_databricks_cluster"></a> [databricks\_cluster](#output\_databricks\_cluster) | Databricks Cluster |
| <a name="output_databricks_high_concurrency_cluster"></a> [databricks\_high\_concurrency\_cluster](#output\_databricks\_high\_concurrency\_cluster) | Databricks High Concurrency Cluster |
| <a name="output_databricks_standard_cluster"></a> [databricks\_standard\_cluster](#output\_databricks\_standard\_cluster) | Databricks Standard Cluster |
| <a name="output_databricks_workspace"></a> [databricks\_workspace](#output\_databricks\_workspace) | Databricks Workspace |
| <a name="output_dev_test_lab"></a> [dev\_test\_lab](#output\_dev\_test\_lab) | Dev Test Lab |
| <a name="output_dev_test_linux_virtual_machine"></a> [dev\_test\_linux\_virtual\_machine](#output\_dev\_test\_linux\_virtual\_machine) | Dev Test Linux Virtual Machine |
| <a name="output_dev_test_windows_virtual_machine"></a> [dev\_test\_windows\_virtual\_machine](#output\_dev\_test\_windows\_virtual\_machine) | Dev Test Windows Virtual Machine |
| <a name="output_disk_encryption_set"></a> [disk\_encryption\_set](#output\_disk\_encryption\_set) | Disk Encryption Set |
| <a name="output_dns_a_record"></a> [dns\_a\_record](#output\_dns\_a\_record) | Dns A Record |
| <a name="output_dns_aaaa_record"></a> [dns\_aaaa\_record](#output\_dns\_aaaa\_record) | Dns Aaaa Record |
| <a name="output_dns_caa_record"></a> [dns\_caa\_record](#output\_dns\_caa\_record) | Dns Caa Record |
| <a name="output_dns_cname_record"></a> [dns\_cname\_record](#output\_dns\_cname\_record) | Dns Cname Record |
| <a name="output_dns_mx_record"></a> [dns\_mx\_record](#output\_dns\_mx\_record) | Dns Mx Record |
| <a name="output_dns_ns_record"></a> [dns\_ns\_record](#output\_dns\_ns\_record) | Dns Ns Record |
| <a name="output_dns_ptr_record"></a> [dns\_ptr\_record](#output\_dns\_ptr\_record) | Dns Ptr Record |
| <a name="output_dns_txt_record"></a> [dns\_txt\_record](#output\_dns\_txt\_record) | Dns Txt Record |
| <a name="output_dns_zone"></a> [dns\_zone](#output\_dns\_zone) | Dns Zone |
| <a name="output_eventgrid_domain"></a> [eventgrid\_domain](#output\_eventgrid\_domain) | Eventgrid Domain |
| <a name="output_eventgrid_domain_topic"></a> [eventgrid\_domain\_topic](#output\_eventgrid\_domain\_topic) | Eventgrid Domain Topic |
| <a name="output_eventgrid_event_subscription"></a> [eventgrid\_event\_subscription](#output\_eventgrid\_event\_subscription) | Eventgrid Event Subscription |
| <a name="output_eventgrid_topic"></a> [eventgrid\_topic](#output\_eventgrid\_topic) | Eventgrid Topic |
| <a name="output_eventhub"></a> [eventhub](#output\_eventhub) | Eventhub |
| <a name="output_eventhub_authorization_rule"></a> [eventhub\_authorization\_rule](#output\_eventhub\_authorization\_rule) | Eventhub Authorization Rule |
| <a name="output_eventhub_consumer_group"></a> [eventhub\_consumer\_group](#output\_eventhub\_consumer\_group) | Eventhub Consumer Group |
| <a name="output_eventhub_namespace"></a> [eventhub\_namespace](#output\_eventhub\_namespace) | Eventhub Namespace |
| <a name="output_eventhub_namespace_authorization_rule"></a> [eventhub\_namespace\_authorization\_rule](#output\_eventhub\_namespace\_authorization\_rule) | Eventhub Namespace Authorization Rule |
| <a name="output_eventhub_namespace_disaster_recovery_config"></a> [eventhub\_namespace\_disaster\_recovery\_config](#output\_eventhub\_namespace\_disaster\_recovery\_config) | Eventhub Namespace Disaster Recovery Config |
| <a name="output_express_route_circuit"></a> [express\_route\_circuit](#output\_express\_route\_circuit) | Express Route Circuit |
| <a name="output_express_route_gateway"></a> [express\_route\_gateway](#output\_express\_route\_gateway) | Express Route Gateway |
| <a name="output_firewall"></a> [firewall](#output\_firewall) | Firewall |
| <a name="output_firewall_application_rule_collection"></a> [firewall\_application\_rule\_collection](#output\_firewall\_application\_rule\_collection) | Firewall Application Rule Collection |
| <a name="output_firewall_ip_configuration"></a> [firewall\_ip\_configuration](#output\_firewall\_ip\_configuration) | Firewall Ip Configuration |
| <a name="output_firewall_nat_rule_collection"></a> [firewall\_nat\_rule\_collection](#output\_firewall\_nat\_rule\_collection) | Firewall Nat Rule Collection |
| <a name="output_firewall_network_rule_collection"></a> [firewall\_network\_rule\_collection](#output\_firewall\_network\_rule\_collection) | Firewall Network Rule Collection |
| <a name="output_firewall_policy"></a> [firewall\_policy](#output\_firewall\_policy) | Firewall Policy |
| <a name="output_firewall_policy_rule_collection_group"></a> [firewall\_policy\_rule\_collection\_group](#output\_firewall\_policy\_rule\_collection\_group) | Firewall Policy Rule Collection Group |
| <a name="output_frontdoor"></a> [frontdoor](#output\_frontdoor) | Frontdoor |
| <a name="output_frontdoor_firewall_policy"></a> [frontdoor\_firewall\_policy](#output\_frontdoor\_firewall\_policy) | Frontdoor Firewall Policy |
| <a name="output_function_app"></a> [function\_app](#output\_function\_app) | Function App |
| <a name="output_hdinsight_hadoop_cluster"></a> [hdinsight\_hadoop\_cluster](#output\_hdinsight\_hadoop\_cluster) | Hdinsight Hadoop Cluster |
| <a name="output_hdinsight_hbase_cluster"></a> [hdinsight\_hbase\_cluster](#output\_hdinsight\_hbase\_cluster) | Hdinsight Hbase Cluster |
| <a name="output_hdinsight_interactive_query_cluster"></a> [hdinsight\_interactive\_query\_cluster](#output\_hdinsight\_interactive\_query\_cluster) | Hdinsight Interactive Query Cluster |
| <a name="output_hdinsight_kafka_cluster"></a> [hdinsight\_kafka\_cluster](#output\_hdinsight\_kafka\_cluster) | Hdinsight Kafka Cluster |
| <a name="output_hdinsight_ml_services_cluster"></a> [hdinsight\_ml\_services\_cluster](#output\_hdinsight\_ml\_services\_cluster) | Hdinsight Ml Services Cluster |
| <a name="output_hdinsight_rserver_cluster"></a> [hdinsight\_rserver\_cluster](#output\_hdinsight\_rserver\_cluster) | Hdinsight Rserver Cluster |
| <a name="output_hdinsight_spark_cluster"></a> [hdinsight\_spark\_cluster](#output\_hdinsight\_spark\_cluster) | Hdinsight Spark Cluster |
| <a name="output_hdinsight_storm_cluster"></a> [hdinsight\_storm\_cluster](#output\_hdinsight\_storm\_cluster) | Hdinsight Storm Cluster |
| <a name="output_image"></a> [image](#output\_image) | Image |
| <a name="output_iotcentral_application"></a> [iotcentral\_application](#output\_iotcentral\_application) | Iotcentral Application |
| <a name="output_iothub"></a> [iothub](#output\_iothub) | Iothub |
| <a name="output_iothub_consumer_group"></a> [iothub\_consumer\_group](#output\_iothub\_consumer\_group) | Iothub Consumer Group |
| <a name="output_iothub_dps"></a> [iothub\_dps](#output\_iothub\_dps) | Iothub Dps |
| <a name="output_iothub_dps_certificate"></a> [iothub\_dps\_certificate](#output\_iothub\_dps\_certificate) | Iothub Dps Certificate |
| <a name="output_key_vault"></a> [key\_vault](#output\_key\_vault) | Key Vault |
| <a name="output_key_vault_certificate"></a> [key\_vault\_certificate](#output\_key\_vault\_certificate) | Key Vault Certificate |
| <a name="output_key_vault_key"></a> [key\_vault\_key](#output\_key\_vault\_key) | Key Vault Key |
| <a name="output_key_vault_secret"></a> [key\_vault\_secret](#output\_key\_vault\_secret) | Key Vault Secret |
| <a name="output_kubernetes_cluster"></a> [kubernetes\_cluster](#output\_kubernetes\_cluster) | Kubernetes Cluster |
| <a name="output_kusto_cluster"></a> [kusto\_cluster](#output\_kusto\_cluster) | Kusto Cluster |
| <a name="output_kusto_database"></a> [kusto\_database](#output\_kusto\_database) | Kusto Database |
| <a name="output_kusto_eventhub_data_connection"></a> [kusto\_eventhub\_data\_connection](#output\_kusto\_eventhub\_data\_connection) | Kusto Eventhub Data Connection |
| <a name="output_lb"></a> [lb](#output\_lb) | Lb |
| <a name="output_lb_nat_rule"></a> [lb\_nat\_rule](#output\_lb\_nat\_rule) | Lb Nat Rule |
| <a name="output_linux_virtual_machine"></a> [linux\_virtual\_machine](#output\_linux\_virtual\_machine) | Linux Virtual Machine |
| <a name="output_linux_virtual_machine_scale_set"></a> [linux\_virtual\_machine\_scale\_set](#output\_linux\_virtual\_machine\_scale\_set) | Linux Virtual Machine Scale Set |
| <a name="output_local_network_gateway"></a> [local\_network\_gateway](#output\_local\_network\_gateway) | Local Network Gateway |
| <a name="output_log_analytics_workspace"></a> [log\_analytics\_workspace](#output\_log\_analytics\_workspace) | Log Analytics Workspace |
| <a name="output_monitor_action_group"></a> [monitor\_action\_group]
(#output\_monitor\_action\_group) | Alerts Action group |
| <a name="output_monitor_scheduled_query_rules_alert"></a> [monitor\_scheduled\_query\_rules\_alert]
(#output\_monitor\_scheduled\_query\_rules\_alert) | Alerts scheduled query rules  |
| <a name="output_monitor_autoscale_setting"></a> [monitor\_autoscale\_setting]
(#output\_monitor\_autoscale\_setting) | Autoscale Setting |
| <a name="output_monitor_diagnostic_setting"></a> [monitor\_diagnostic\_setting]
(#output\_monitor\_diagnostic\_setting) | Siagnostic setting |
| <a name="output_logic_app_workflow"></a> [logic\_app\_workflow](#output\_logic\_app\_workflow) | Logic App Workflow |
| <a name="output_machine_learning_workspace"></a> [machine\_learning\_workspace](#output\_machine\_learning\_workspace) | Machine Learning Workspace |
| <a name="output_managed_disk"></a> [managed\_disk](#output\_managed\_disk) | Managed Disk |
| <a name="output_maps_account"></a> [maps\_account](#output\_maps\_account) | Maps Account |
| <a name="output_mariadb_database"></a> [mariadb\_database](#output\_mariadb\_database) | Mariadb Database |
| <a name="output_mariadb_firewall_rule"></a> [mariadb\_firewall\_rule](#output\_mariadb\_firewall\_rule) | Mariadb Firewall Rule |
| <a name="output_mariadb_server"></a> [mariadb\_server](#output\_mariadb\_server) | Mariadb Server |
| <a name="output_mariadb_virtual_network_rule"></a> [mariadb\_virtual\_network\_rule](#output\_mariadb\_virtual\_network\_rule) | Mariadb Virtual Network Rule |
| <a name="output_mssql_database"></a> [mssql\_database](#output\_mssql\_database) | Mssql Database |
| <a name="output_mssql_elasticpool"></a> [mssql\_elasticpool](#output\_mssql\_elasticpool) | Mssql Elasticpool |
| <a name="output_mssql_server"></a> [mssql\_server](#output\_mssql\_server) | Mssql Server |
| <a name="output_mysql_database"></a> [mysql\_database](#output\_mysql\_database) | Mysql Database |
| <a name="output_mysql_firewall_rule"></a> [mysql\_firewall\_rule](#output\_mysql\_firewall\_rule) | Mysql Firewall Rule |
| <a name="output_mysql_server"></a> [mysql\_server](#output\_mysql\_server) | Mysql Server |
| <a name="output_mysql_virtual_network_rule"></a> [mysql\_virtual\_network\_rule](#output\_mysql\_virtual\_network\_rule) | Mysql Virtual Network Rule |
| <a name="output_network_ddos_protection_plan"></a> [network\_ddos\_protection\_plan](#output\_network\_ddos\_protection\_plan) | Network Ddos Protection Plan |
| <a name="output_network_interface"></a> [network\_interface](#output\_network\_interface) | Network Interface |
| <a name="output_network_security_group"></a> [network\_security\_group](#output\_network\_security\_group) | Network Security Group |
| <a name="output_network_security_group_rule"></a> [network\_security\_group\_rule](#output\_network\_security\_group\_rule) | Network Security Group Rule |
| <a name="output_network_security_rule"></a> [network\_security\_rule](#output\_network\_security\_rule) | Network Security Rule |
| <a name="output_network_watcher"></a> [network\_watcher](#output\_network\_watcher) | Network Watcher |
| <a name="output_notification_hub"></a> [notification\_hub](#output\_notification\_hub) | Notification Hub |
| <a name="output_notification_hub_authorization_rule"></a> [notification\_hub\_authorization\_rule](#output\_notification\_hub\_authorization\_rule) | Notification Hub Authorization Rule |
| <a name="output_notification_hub_namespace"></a> [notification\_hub\_namespace](#output\_notification\_hub\_namespace) | Notification Hub Namespace |
| <a name="output_point_to_site_vpn_gateway"></a> [point\_to\_site\_vpn\_gateway](#output\_point\_to\_site\_vpn\_gateway) | Point To Site Vpn Gateway |
| <a name="output_postgresql_database"></a> [postgresql\_database](#output\_postgresql\_database) | Postgresql Database |
| <a name="output_postgresql_firewall_rule"></a> [postgresql\_firewall\_rule](#output\_postgresql\_firewall\_rule) | Postgresql Firewall Rule |
| <a name="output_postgresql_server"></a> [postgresql\_server](#output\_postgresql\_server) | Postgresql Server |
| <a name="output_postgresql_virtual_network_rule"></a> [postgresql\_virtual\_network\_rule](#output\_postgresql\_virtual\_network\_rule) | Postgresql Virtual Network Rule |
| <a name="output_powerbi_embedded"></a> [powerbi\_embedded](#output\_powerbi\_embedded) | Powerbi Embedded |
| <a name="output_private_dns_a_record"></a> [private\_dns\_a\_record](#output\_private\_dns\_a\_record) | Private Dns A Record |
| <a name="output_private_dns_aaaa_record"></a> [private\_dns\_aaaa\_record](#output\_private\_dns\_aaaa\_record) | Private Dns Aaaa Record |
| <a name="output_private_dns_cname_record"></a> [private\_dns\_cname\_record](#output\_private\_dns\_cname\_record) | Private Dns Cname Record |
| <a name="output_private_dns_mx_record"></a> [private\_dns\_mx\_record](#output\_private\_dns\_mx\_record) | Private Dns Mx Record |
| <a name="output_private_dns_ptr_record"></a> [private\_dns\_ptr\_record](#output\_private\_dns\_ptr\_record) | Private Dns Ptr Record |
| <a name="output_private_dns_srv_record"></a> [private\_dns\_srv\_record](#output\_private\_dns\_srv\_record) | Private Dns Srv Record |
| <a name="output_private_dns_txt_record"></a> [private\_dns\_txt\_record](#output\_private\_dns\_txt\_record) | Private Dns Txt Record |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | Private Dns Zone |
| <a name="output_private_dns_zone_group"></a> [private\_dns\_zone\_group](#output\_private\_dns\_zone\_group) | Private Dns Zone Group |
| <a name="output_private_endpoint"></a> [private\_endpoint](#output\_private\_endpoint) | Private Endpoint |
| <a name="output_private_link_service"></a> [private\_link\_service](#output\_private\_link\_service) | Private Link Service |
| <a name="output_private_service_connection"></a> [private\_service\_connection](#output\_private\_service\_connection) | Private Service Connection |
| <a name="output_proximity_placement_group"></a> [proximity\_placement\_group](#output\_proximity\_placement\_group) | Proximity Placement Group |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public Ip |
| <a name="output_public_ip_prefix"></a> [public\_ip\_prefix](#output\_public\_ip\_prefix) | Public Ip Prefix |
| <a name="output_recovery_services_vault"></a> [recovery\_services\_vault](#output\_recovery\_services\_vault) | Recovery Services Vault |
| <a name="output_redis_cache"></a> [redis\_cache](#output\_redis\_cache) | Redis Cache |
| <a name="output_redis_firewall_rule"></a> [redis\_firewall\_rule](#output\_redis\_firewall\_rule) | Redis Firewall Rule |
| <a name="output_relay_hybrid_connection"></a> [relay\_hybrid\_connection](#output\_relay\_hybrid\_connection) | Relay Hybrid Connection |
| <a name="output_relay_namespace"></a> [relay\_namespace](#output\_relay\_namespace) | Relay Namespace |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | Resource Group |
| <a name="output_role_assignment"></a> [role\_assignment](#output\_role\_assignment) | Role Assignment |
| <a name="output_role_definition"></a> [role\_definition](#output\_role\_definition) | Role Definition |
| <a name="output_route"></a> [route](#output\_route) | Route |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | Route Table |
| <a name="output_search_service"></a> [search\_service](#output\_search\_service) | Search Service |
| <a name="output_service_fabric_cluster"></a> [service\_fabric\_cluster](#output\_service\_fabric\_cluster) | Service Fabric Cluster |
| <a name="output_servicebus_namespace"></a> [servicebus\_namespace](#output\_servicebus\_namespace) | Servicebus Namespace |
| <a name="output_servicebus_namespace_authorization_rule"></a> [servicebus\_namespace\_authorization\_rule](#output\_servicebus\_namespace\_authorization\_rule) | Servicebus Namespace Authorization Rule |
| <a name="output_servicebus_queue"></a> [servicebus\_queue](#output\_servicebus\_queue) | Servicebus Queue |
| <a name="output_servicebus_queue_authorization_rule"></a> [servicebus\_queue\_authorization\_rule](#output\_servicebus\_queue\_authorization\_rule) | Servicebus Queue Authorization Rule |
| <a name="output_servicebus_subscription"></a> [servicebus\_subscription](#output\_servicebus\_subscription) | Servicebus Subscription |
| <a name="output_servicebus_subscription_rule"></a> [servicebus\_subscription\_rule](#output\_servicebus\_subscription\_rule) | Servicebus Subscription Rule |
| <a name="output_servicebus_topic"></a> [servicebus\_topic](#output\_servicebus\_topic) | Servicebus Topic |
| <a name="output_servicebus_topic_authorization_rule"></a> [servicebus\_topic\_authorization\_rule](#output\_servicebus\_topic\_authorization\_rule) | Servicebus Topic Authorization Rule |
| <a name="output_shared_image"></a> [shared\_image](#output\_shared\_image) | Shared Image |
| <a name="output_shared_image_gallery"></a> [shared\_image\_gallery](#output\_shared\_image\_gallery) | Shared Image Gallery |
| <a name="output_signalr_service"></a> [signalr\_service](#output\_signalr\_service) | Signalr Service |
| <a name="output_snapshots"></a> [snapshots](#output\_snapshots) | Snapshots |
| <a name="output_sql_elasticpool"></a> [sql\_elasticpool](#output\_sql\_elasticpool) | Sql Elasticpool |
| <a name="output_sql_failover_group"></a> [sql\_failover\_group](#output\_sql\_failover\_group) | Sql Failover Group |
| <a name="output_sql_firewall_rule"></a> [sql\_firewall\_rule](#output\_sql\_firewall\_rule) | Sql Firewall Rule |
| <a name="output_sql_server"></a> [sql\_server](#output\_sql\_server) | Sql Server |
| <a name="output_storage_account"></a> [storage\_account](#output\_storage\_account) | Storage Account |
| <a name="output_storage_blob"></a> [storage\_blob](#output\_storage\_blob) | Storage Blob |
| <a name="output_storage_container"></a> [storage\_container](#output\_storage\_container) | Storage Container |
| <a name="output_storage_data_lake_gen2_filesystem"></a> [storage\_data\_lake\_gen2\_filesystem](#output\_storage\_data\_lake\_gen2\_filesystem) | Storage Data Lake Gen2 Filesystem |
| <a name="output_storage_queue"></a> [storage\_queue](#output\_storage\_queue) | Storage Queue |
| <a name="output_storage_share"></a> [storage\_share](#output\_storage\_share) | Storage Share |
| <a name="output_storage_share_directory"></a> [storage\_share\_directory](#output\_storage\_share\_directory) | Storage Share Directory |
| <a name="output_storage_table"></a> [storage\_table](#output\_storage\_table) | Storage Table |
| <a name="output_stream_analytics_function_javascript_udf"></a> [stream\_analytics\_function\_javascript\_udf](#output\_stream\_analytics\_function\_javascript\_udf) | Stream Analytics Function Javascript Udf |
| <a name="output_stream_analytics_job"></a> [stream\_analytics\_job](#output\_stream\_analytics\_job) | Stream Analytics Job |
| <a name="output_stream_analytics_output_blob"></a> [stream\_analytics\_output\_blob](#output\_stream\_analytics\_output\_blob) | Stream Analytics Output Blob |
| <a name="output_stream_analytics_output_eventhub"></a> [stream\_analytics\_output\_eventhub](#output\_stream\_analytics\_output\_eventhub) | Stream Analytics Output Eventhub |
| <a name="output_stream_analytics_output_mssql"></a> [stream\_analytics\_output\_mssql](#output\_stream\_analytics\_output\_mssql) | Stream Analytics Output Mssql |
| <a name="output_stream_analytics_output_servicebus_queue"></a> [stream\_analytics\_output\_servicebus\_queue](#output\_stream\_analytics\_output\_servicebus\_queue) | Stream Analytics Output Servicebus Queue |
| <a name="output_stream_analytics_output_servicebus_topic"></a> [stream\_analytics\_output\_servicebus\_topic](#output\_stream\_analytics\_output\_servicebus\_topic) | Stream Analytics Output Servicebus Topic |
| <a name="output_stream_analytics_reference_input_blob"></a> [stream\_analytics\_reference\_input\_blob](#output\_stream\_analytics\_reference\_input\_blob) | Stream Analytics Reference Input Blob |
| <a name="output_stream_analytics_stream_input_blob"></a> [stream\_analytics\_stream\_input\_blob](#output\_stream\_analytics\_stream\_input\_blob) | Stream Analytics Stream Input Blob |
| <a name="output_stream_analytics_stream_input_eventhub"></a> [stream\_analytics\_stream\_input\_eventhub](#output\_stream\_analytics\_stream\_input\_eventhub) | Stream Analytics Stream Input Eventhub |
| <a name="output_stream_analytics_stream_input_iothub"></a> [stream\_analytics\_stream\_input\_iothub](#output\_stream\_analytics\_stream\_input\_iothub) | Stream Analytics Stream Input Iothub |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | Subnet |
| <a name="output_template_deployment"></a> [template\_deployment](#output\_template\_deployment) | Template Deployment |
| <a name="output_traffic_manager_profile"></a> [traffic\_manager\_profile](#output\_traffic\_manager\_profile) | Traffic Manager Profile |
| <a name="output_unique-seed"></a> [unique-seed](#output\_unique-seed) | n/a |
| <a name="output_user_assigned_identity"></a> [user\_assigned\_identity](#output\_user\_assigned\_identity) | User Assigned Identity |
| <a name="output_validation"></a> [validation](#output\_validation) | n/a |
| <a name="output_virtual_machine"></a> [virtual\_machine](#output\_virtual\_machine) | Virtual Machine |
| <a name="output_virtual_machine_extension"></a> [virtual\_machine\_extension](#output\_virtual\_machine\_extension) | Virtual Machine Extension |
| <a name="output_virtual_machine_scale_set"></a> [virtual\_machine\_scale\_set](#output\_virtual\_machine\_scale\_set) | Virtual Machine Scale Set |
| <a name="output_virtual_machine_scale_set_extension"></a> [virtual\_machine\_scale\_set\_extension](#output\_virtual\_machine\_scale\_set\_extension) | Virtual Machine Scale Set Extension |
| <a name="output_virtual_network"></a> [virtual\_network](#output\_virtual\_network) | Virtual Network |
| <a name="output_virtual_network_gateway"></a> [virtual\_network\_gateway](#output\_virtual\_network\_gateway) | Virtual Network Gateway |
| <a name="output_virtual_network_gateway_connection"></a> [virtual\_network\_gateway\_connection](#output\_virtual\_network\_gateway\_connection) | Virtual Network Gateway Connection |
| <a name="output_virtual_network_peering"></a> [virtual\_network\_peering](#output\_virtual\_network\_peering) | Virtual Network Peering |
| <a name="output_virtual_wan"></a> [virtual\_wan](#output\_virtual\_wan) | Virtual Wan |
| <a name="output_windows_virtual_machine"></a> [windows\_virtual\_machine](#output\_windows\_virtual\_machine) | Windows Virtual Machine |
| <a name="output_windows_virtual_machine_scale_set"></a> [windows\_virtual\_machine\_scale\_set](#output\_windows\_virtual\_machine\_scale\_set) | Windows Virtual Machine Scale Set |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
