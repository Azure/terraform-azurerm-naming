
output "unique-seed" {
  value = coalesce(var.unique-seed, local.random_safe_generation)
}

output "validation" {
  value = local.validation
}
output "analysis_services_server" {
  value = local.az.analysis_services_server
}

output "api_management" {
  value = local.az.api_management
}

output "app_configuration" {
  value = local.az.app_configuration
}

output "app_service" {
  value = local.az.app_service
}

output "app_service_plan" {
  value = local.az.app_service_plan
}

output "application_gateway" {
  value = local.az.application_gateway
}

output "application_insights" {
  value = local.az.application_insights
}

output "application_security_group" {
  value = local.az.application_security_group
}

output "automation_account" {
  value = local.az.automation_account
}

output "automation_certificate" {
  value = local.az.automation_certificate
}

output "automation_credential" {
  value = local.az.automation_credential
}

output "automation_runbook" {
  value = local.az.automation_runbook
}

output "automation_schedule" {
  value = local.az.automation_schedule
}

output "automation_variable" {
  value = local.az.automation_variable
}

output "availability_set" {
  value = local.az.availability_set
}

output "bastion_host" {
  value = local.az.bastion_host
}

output "batch_account" {
  value = local.az.batch_account
}

output "batch_application" {
  value = local.az.batch_application
}

output "batch_certificate" {
  value = local.az.batch_certificate
}

output "batch_pool" {
  value = local.az.batch_pool
}

output "bot_channel_directline" {
  value = local.az.bot_channel_directline
}

output "bot_channel_email" {
  value = local.az.bot_channel_email
}

output "bot_channel_ms_teams" {
  value = local.az.bot_channel_ms_teams
}

output "bot_channel_slack" {
  value = local.az.bot_channel_slack
}

output "bot_channels_registration" {
  value = local.az.bot_channels_registration
}

output "bot_connection" {
  value = local.az.bot_connection
}

output "bot_web_app" {
  value = local.az.bot_web_app
}

output "cdn_endpoint" {
  value = local.az.cdn_endpoint
}

output "cdn_profile" {
  value = local.az.cdn_profile
}

output "cognitive_account" {
  value = local.az.cognitive_account
}

output "container_group" {
  value = local.az.container_group
}

output "container_registry" {
  value = local.az.container_registry
}

output "container_registry_webhook" {
  value = local.az.container_registry_webhook
}

output "cosmosdb_account" {
  value = local.az.cosmosdb_account
}

output "custom_provider" {
  value = local.az.custom_provider
}

output "dashboard" {
  value = local.az.dashboard
}

output "data_factory" {
  value = local.az.data_factory
}

output "data_factory_dataset_mysql" {
  value = local.az.data_factory_dataset_mysql
}

output "data_factory_dataset_postgresql" {
  value = local.az.data_factory_dataset_postgresql
}

output "data_factory_dataset_sql_server_table" {
  value = local.az.data_factory_dataset_sql_server_table
}

output "data_factory_integration_runtime_managed" {
  value = local.az.data_factory_integration_runtime_managed
}

output "data_factory_linked_service_data_lake_storage_gen2" {
  value = local.az.data_factory_linked_service_data_lake_storage_gen2
}

output "data_factory_linked_service_key_vault" {
  value = local.az.data_factory_linked_service_key_vault
}

output "data_factory_linked_service_mysql" {
  value = local.az.data_factory_linked_service_mysql
}

output "data_factory_linked_service_postgresql" {
  value = local.az.data_factory_linked_service_postgresql
}

output "data_factory_linked_service_sql_server" {
  value = local.az.data_factory_linked_service_sql_server
}

output "data_factory_pipeline" {
  value = local.az.data_factory_pipeline
}

output "data_factory_trigger_schedule" {
  value = local.az.data_factory_trigger_schedule
}

output "data_lake_analytics_account" {
  value = local.az.data_lake_analytics_account
}

output "data_lake_analytics_firewall_rule" {
  value = local.az.data_lake_analytics_firewall_rule
}

output "data_lake_store" {
  value = local.az.data_lake_store
}

output "data_lake_store_firewall_rule" {
  value = local.az.data_lake_store_firewall_rule
}

output "database_migration_project" {
  value = local.az.database_migration_project
}

output "database_migration_service" {
  value = local.az.database_migration_service
}

output "databricks_cluster" {
  value = local.az.databricks_cluster
}

output "databricks_high_concurrency_cluster" {
  value = local.az.databricks_high_concurrency_cluster
}

output "databricks_standard_cluster" {
  value = local.az.databricks_standard_cluster
}

output "databricks_workspace" {
  value = local.az.databricks_workspace
}

output "dev_test_lab" {
  value = local.az.dev_test_lab
}

output "dev_test_linux_virtual_machine" {
  value = local.az.dev_test_linux_virtual_machine
}

output "dev_test_windows_virtual_machine" {
  value = local.az.dev_test_windows_virtual_machine
}

output "disk_encryption_set" {
  value = local.az.disk_encryption_set
}

output "dns_a_record" {
  value = local.az.dns_a_record
}

output "dns_aaaa_record" {
  value = local.az.dns_aaaa_record
}

output "dns_caa_record" {
  value = local.az.dns_caa_record
}

output "dns_cname_record" {
  value = local.az.dns_cname_record
}

output "dns_mx_record" {
  value = local.az.dns_mx_record
}

output "dns_ns_record" {
  value = local.az.dns_ns_record
}

output "dns_ptr_record" {
  value = local.az.dns_ptr_record
}

output "dns_txt_record" {
  value = local.az.dns_txt_record
}

output "dns_zone" {
  value = local.az.dns_zone
}

output "eventgrid_domain" {
  value = local.az.eventgrid_domain
}

output "eventgrid_domain_topic" {
  value = local.az.eventgrid_domain_topic
}

output "eventgrid_event_subscription" {
  value = local.az.eventgrid_event_subscription
}

output "eventgrid_topic" {
  value = local.az.eventgrid_topic
}

output "eventhub" {
  value = local.az.eventhub
}

output "eventhub_authorization_rule" {
  value = local.az.eventhub_authorization_rule
}

output "eventhub_consumer_group" {
  value = local.az.eventhub_consumer_group
}

output "eventhub_namespace" {
  value = local.az.eventhub_namespace
}

output "eventhub_namespace_authorization_rule" {
  value = local.az.eventhub_namespace_authorization_rule
}

output "eventhub_namespace_disaster_recovery_config" {
  value = local.az.eventhub_namespace_disaster_recovery_config
}

output "express_route_circuit" {
  value = local.az.express_route_circuit
}

output "express_route_gateway" {
  value = local.az.express_route_gateway
}

output "firewall" {
  value = local.az.firewall
}

output "firewall_application_rule_collection" {
  value = local.az.firewall_application_rule_collection
}

output "firewall_ip_configuration" {
  value = local.az.firewall_ip_configuration
}

output "firewall_nat_rule_collection" {
  value = local.az.firewall_nat_rule_collection
}

output "firewall_network_rule_collection" {
  value = local.az.firewall_network_rule_collection
}

output "frontdoor" {
  value = local.az.frontdoor
}

output "frontdoor_firewall_policy" {
  value = local.az.frontdoor_firewall_policy
}

output "function_app" {
  value = local.az.function_app
}

output "hdinsight_hadoop_cluster" {
  value = local.az.hdinsight_hadoop_cluster
}

output "hdinsight_hbase_cluster" {
  value = local.az.hdinsight_hbase_cluster
}

output "hdinsight_interactive_query_cluster" {
  value = local.az.hdinsight_interactive_query_cluster
}

output "hdinsight_kafka_cluster" {
  value = local.az.hdinsight_kafka_cluster
}

output "hdinsight_ml_services_cluster" {
  value = local.az.hdinsight_ml_services_cluster
}

output "hdinsight_rserver_cluster" {
  value = local.az.hdinsight_rserver_cluster
}

output "hdinsight_spark_cluster" {
  value = local.az.hdinsight_spark_cluster
}

output "hdinsight_storm_cluster" {
  value = local.az.hdinsight_storm_cluster
}

output "image" {
  value = local.az.image
}

output "iotcentral_application" {
  value = local.az.iotcentral_application
}

output "iothub" {
  value = local.az.iothub
}

output "iothub_consumer_group" {
  value = local.az.iothub_consumer_group
}

output "iothub_dps" {
  value = local.az.iothub_dps
}

output "iothub_dps_certificate" {
  value = local.az.iothub_dps_certificate
}

output "key_vault" {
  value = local.az.key_vault
}

output "key_vault_certificate" {
  value = local.az.key_vault_certificate
}

output "key_vault_key" {
  value = local.az.key_vault_key
}

output "key_vault_secret" {
  value = local.az.key_vault_secret
}

output "kubernetes_cluster" {
  value = local.az.kubernetes_cluster
}

output "kusto_cluster" {
  value = local.az.kusto_cluster
}

output "kusto_database" {
  value = local.az.kusto_database
}

output "kusto_eventhub_data_connection" {
  value = local.az.kusto_eventhub_data_connection
}

output "lb" {
  value = local.az.lb
}

output "lb_nat_rule" {
  value = local.az.lb_nat_rule
}

output "linux_function_app" {
  value = local.az.linux_function_app
}

output "linux_virtual_machine" {
  value = local.az.linux_virtual_machine
}

output "linux_virtual_machine_scale_set" {
  value = local.az.linux_virtual_machine_scale_set
}

output "local_network_gateway" {
  value = local.az.local_network_gateway
}

output "log_analytics_workspace" {
  value = local.az.log_analytics_workspace
}

output "logic_app_workflow" {
  value = local.az.logic_app_workflow
}

output "machine_learning_workspace" {
  value = local.az.machine_learning_workspace
}

output "managed_disk" {
  value = local.az.managed_disk
}

output "maps_account" {
  value = local.az.maps_account
}

output "mariadb_database" {
  value = local.az.mariadb_database
}

output "mariadb_firewall_rule" {
  value = local.az.mariadb_firewall_rule
}

output "mariadb_server" {
  value = local.az.mariadb_server
}

output "mariadb_virtual_network_rule" {
  value = local.az.mariadb_virtual_network_rule
}

output "mssql_database" {
  value = local.az.mssql_database
}

output "mssql_elasticpool" {
  value = local.az.mssql_elasticpool
}

output "mssql_server" {
  value = local.az.mssql_server
}

output "mysql_database" {
  value = local.az.mysql_database
}

output "mysql_firewall_rule" {
  value = local.az.mysql_firewall_rule
}

output "mysql_server" {
  value = local.az.mysql_server
}

output "mysql_virtual_network_rule" {
  value = local.az.mysql_virtual_network_rule
}

output "network_ddos_protection_plan" {
  value = local.az.network_ddos_protection_plan
}

output "network_interface" {
  value = local.az.network_interface
}

output "network_security_group" {
  value = local.az.network_security_group
}

output "network_security_group_rule" {
  value = local.az.network_security_group_rule
}

output "network_security_rule" {
  value = local.az.network_security_rule
}

output "network_watcher" {
  value = local.az.network_watcher
}

output "notification_hub" {
  value = local.az.notification_hub
}

output "notification_hub_authorization_rule" {
  value = local.az.notification_hub_authorization_rule
}

output "notification_hub_namespace" {
  value = local.az.notification_hub_namespace
}

output "point_to_site_vpn_gateway" {
  value = local.az.point_to_site_vpn_gateway
}

output "postgresql_database" {
  value = local.az.postgresql_database
}

output "postgresql_firewall_rule" {
  value = local.az.postgresql_firewall_rule
}

output "postgresql_server" {
  value = local.az.postgresql_server
}

output "postgresql_virtual_network_rule" {
  value = local.az.postgresql_virtual_network_rule
}

output "powerbi_embedded" {
  value = local.az.powerbi_embedded
}

output "private_dns_a_record" {
  value = local.az.private_dns_a_record
}

output "private_dns_aaaa_record" {
  value = local.az.private_dns_aaaa_record
}

output "private_dns_cname_record" {
  value = local.az.private_dns_cname_record
}

output "private_dns_mx_record" {
  value = local.az.private_dns_mx_record
}

output "private_dns_ptr_record" {
  value = local.az.private_dns_ptr_record
}

output "private_dns_srv_record" {
  value = local.az.private_dns_srv_record
}

output "private_dns_txt_record" {
  value = local.az.private_dns_txt_record
}

output "private_dns_zone" {
  value = local.az.private_dns_zone
}

output "private_dns_zone_group" {
  value = local.az.private_dns_zone_group
}

output "private_endpoint" {
  value = local.az.private_endpoint
}

output "private_link_service" {
  value = local.az.private_link_service
}

output "private_service_connection" {
  value = local.az.private_service_connection
}

output "proximity_placement_group" {
  value = local.az.proximity_placement_group
}

output "public_ip" {
  value = local.az.public_ip
}

output "public_ip_prefix" {
  value = local.az.public_ip_prefix
}

output "redis_cache" {
  value = local.az.redis_cache
}

output "redis_firewall_rule" {
  value = local.az.redis_firewall_rule
}

output "relay_hybrid_connection" {
  value = local.az.relay_hybrid_connection
}

output "relay_namespace" {
  value = local.az.relay_namespace
}

output "resource_group" {
  value = local.az.resource_group
}

output "role_assignment" {
  value = local.az.role_assignment
}

output "role_definition" {
  value = local.az.role_definition
}

output "route" {
  value = local.az.route
}

output "route_table" {
  value = local.az.route_table
}

output "service_fabric_cluster" {
  value = local.az.service_fabric_cluster
}

output "servicebus_namespace" {
  value = local.az.servicebus_namespace
}

output "servicebus_namespace_authorization_rule" {
  value = local.az.servicebus_namespace_authorization_rule
}

output "servicebus_queue" {
  value = local.az.servicebus_queue
}

output "servicebus_queue_authorization_rule" {
  value = local.az.servicebus_queue_authorization_rule
}

output "servicebus_subscription" {
  value = local.az.servicebus_subscription
}

output "servicebus_subscription_rule" {
  value = local.az.servicebus_subscription_rule
}

output "servicebus_topic" {
  value = local.az.servicebus_topic
}

output "servicebus_topic_authorization_rule" {
  value = local.az.servicebus_topic_authorization_rule
}

output "shared_image" {
  value = local.az.shared_image
}

output "shared_image_gallery" {
  value = local.az.shared_image_gallery
}

output "signalr_service" {
  value = local.az.signalr_service
}

output "snapshots" {
  value = local.az.snapshots
}

output "sql_elasticpool" {
  value = local.az.sql_elasticpool
}

output "sql_failover_group" {
  value = local.az.sql_failover_group
}

output "sql_firewall_rule" {
  value = local.az.sql_firewall_rule
}

output "sql_server" {
  value = local.az.sql_server
}

output "storage_account" {
  value = local.az.storage_account
}

output "storage_blob" {
  value = local.az.storage_blob
}

output "storage_container" {
  value = local.az.storage_container
}

output "storage_data_lake_gen2_filesystem" {
  value = local.az.storage_data_lake_gen2_filesystem
}

output "storage_queue" {
  value = local.az.storage_queue
}

output "storage_share" {
  value = local.az.storage_share
}

output "storage_share_directory" {
  value = local.az.storage_share_directory
}

output "storage_table" {
  value = local.az.storage_table
}

output "stream_analytics_function_javascript_udf" {
  value = local.az.stream_analytics_function_javascript_udf
}

output "stream_analytics_job" {
  value = local.az.stream_analytics_job
}

output "stream_analytics_output_blob" {
  value = local.az.stream_analytics_output_blob
}

output "stream_analytics_output_eventhub" {
  value = local.az.stream_analytics_output_eventhub
}

output "stream_analytics_output_mssql" {
  value = local.az.stream_analytics_output_mssql
}

output "stream_analytics_output_servicebus_queue" {
  value = local.az.stream_analytics_output_servicebus_queue
}

output "stream_analytics_output_servicebus_topic" {
  value = local.az.stream_analytics_output_servicebus_topic
}

output "stream_analytics_reference_input_blob" {
  value = local.az.stream_analytics_reference_input_blob
}

output "stream_analytics_stream_input_blob" {
  value = local.az.stream_analytics_stream_input_blob
}

output "stream_analytics_stream_input_eventhub" {
  value = local.az.stream_analytics_stream_input_eventhub
}

output "stream_analytics_stream_input_iothub" {
  value = local.az.stream_analytics_stream_input_iothub
}

output "subnet" {
  value = local.az.subnet
}

output "synapse_workspace" {
  value = local.az.synapse_workspace
}

output "template_deployment" {
  value = local.az.template_deployment
}

output "traffic_manager_profile" {
  value = local.az.traffic_manager_profile
}

output "user_assigned_identity" {
  value = local.az.user_assigned_identity
}

output "virtual_machine" {
  value = local.az.virtual_machine
}

output "virtual_machine_extension" {
  value = local.az.virtual_machine_extension
}

output "virtual_machine_scale_set" {
  value = local.az.virtual_machine_scale_set
}

output "virtual_machine_scale_set_extension" {
  value = local.az.virtual_machine_scale_set_extension
}

output "virtual_network" {
  value = local.az.virtual_network
}

output "virtual_network_gateway" {
  value = local.az.virtual_network_gateway
}

output "virtual_network_peering" {
  value = local.az.virtual_network_peering
}

output "virtual_wan" {
  value = local.az.virtual_wan
}

output "windows_function_app" {
  value = local.az.windows_function_app
}
output "windows_virtual_machine" {
  value = local.az.windows_virtual_machine
}

output "windows_virtual_machine_scale_set" {
  value = local.az.windows_virtual_machine_scale_set
}


