
output "unique-seed" {
  value = coalesce(var.unique-seed, random_string.main.result)
}

// General

output "resource_group" {
  value = {
    name        = join("-", compact([local.prefix, local.az.resource_group, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.resource_group, local.suffix_unique]))
    dashes      = true
    slug        = local.az.resource_group
  }
}

output "policy" {
  value = {
    name        = join("-", compact([local.prefix, local.az.policy, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.policy, local.suffix_unique]))
    dashes      = true
    slug        = local.az.policy
  }
}

output "api_management" {
  value = {
    name        = join("-", compact([local.prefix, local.az.api_management, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.api_management, local.suffix_unique]))
    dashes      = true
    slug        = local.az.api_management
  }
}


// Network

output "virtual_network" {
  value = {
    name        = join("-", compact([local.prefix, local.az.virtual_network, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.virtual_network, local.suffix_unique]))
    dashes      = true
    slug        = local.az.virtual_network
  }
}

output "subnet" {
  value = {
    name        = join("-", compact([local.prefix, local.az.subnet, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.subnet, local.suffix_unique]))
    dashes      = true
    slug        = local.az.subnet
  }
}

output "network_interface" {
  value = {
    name        = join("-", compact([local.prefix, local.az.network_interface, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.network_interface, local.suffix_unique]))
    dashes      = true
    slug        = local.az.network_interface
  }
}

output "public_ip" {
  value = {
    name        = join("-", compact([local.prefix, local.az.public_ip, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.public_ip, local.suffix_unique]))
    dashes      = true
    slug        = local.az.public_ip
  }
}

output "load_balancer_internal" {
  value = {
    name        = join("-", compact([local.prefix, local.az.load_balancer_internal, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.load_balancer_internal, local.suffix_unique]))
    dashes      = true
    slug        = local.az.load_balancer_internal
  }
}

output "load_balancer_external" {
  value = {
    name        = join("-", compact([local.prefix, local.az.load_balancer_external, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.load_balancer_external, local.suffix_unique]))
    dashes      = true
    slug        = local.az.load_balancer_external
  }
}

output "network_security_group" {
  value = {
    name        = join("-", compact([local.prefix, local.az.network_security_group, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.network_security_group, local.suffix_unique]))
    dashes      = true
    slug        = local.az.network_security_group
  }
}

output "application_security_group" {
  value = {
    name        = join("-", compact([local.prefix, local.az.application_security_group, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.application_security_group, local.suffix_unique]))
    dashes      = true
    slug        = local.az.application_security_group
  }
}

output "local_network_gateway" {
  value = {
    name        = join("-", compact([local.prefix, local.az.local_network_gateway, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.local_network_gateway, local.suffix_unique]))
    dashes      = true
    slug        = local.az.local_network_gateway
  }
}

output "virtual_network_gateway" {
  value = {
    name        = join("-", compact([local.prefix, local.az.virtual_network_gateway, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.virtual_network_gateway, local.suffix_unique]))
    dashes      = true
    slug        = local.az.virtual_network_gateway
  }
}

output "vpn_connection" {
  value = {
    name        = join("-", compact([local.prefix, local.az.vpn_connection, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.vpn_connection, local.suffix_unique]))
    dashes      = true
    slug        = local.az.vpn_connection
  }
}

output "application_gateway" {
  value = {
    name        = join("-", compact([local.prefix, local.az.application_gateway, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.application_gateway, local.suffix_unique]))
    dashes      = true
    slug        = local.az.application_gateway
  }
}

output "traffic_manager_profile" {
  value = {
    name        = join("-", compact([local.prefix, local.az.traffic_manager_profile, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.traffic_manager_profile, local.suffix_unique]))
    dashes      = true
    slug        = local.az.traffic_manager_profile
  }
}

output "private_endpoint" {
  value = {
    name        = join("-", compact([local.prefix, local.az.private_endpoint, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.private_endpoint, local.suffix_unique]))
    dashes      = true
    slug        = local.az.private_endpoint
  }
}

output "private_service_connection" {
  value = {
    name        = join("-", compact([local.prefix, local.az.private_service_connection, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.private_service_connection, local.suffix_unique]))
    dashes      = true
    slug        = local.az.private_service_connection
  }
}

output "firewall" {
  value = {
    name        = join("-", compact([local.prefix, local.az.firewall, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.firewall, local.suffix_unique]))
    dashes      = true
    slug        = local.az.firewall
  }
}

output "firewall_ip_configuration" {
  value = {
    name        = join("-", compact([local.prefix, local.az.firewall_ip_configuration, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.firewall_ip_configuration, local.suffix_unique]))
    dashes      = true
    slug        = local.az.firewall_ip_configuration
  }
}

// Compute and Web

output "virtual_machine" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.virtual_machine, local.suffix_safe])), 0, 15)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.virtual_machine, local.suffix_unique_safe])), 0, 15)
    dashes      = false
    slug        = local.az.virtual_machine
  }
}

output "virtual_machine_linux" {
  value = {
    name        = substr(join("", compact([local.prefix, local.az.virtual_machine, local.suffix])), 0, 64)
    name_unique = substr(join("", compact([local.prefix, local.az.virtual_machine, local.suffix_unique])), 0, 64)
    dashes      = false
    slug        = local.az.virtual_machine
  }
}

output "virtual_machine_scale_set" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.virtual_machine_scale_set, local.suffix_safe])), 0, 15)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.virtual_machine_scale_set, local.suffix_unique_safe])), 0, 15)
    dashes      = false
    slug        = local.az.virtual_machine_scale_set
  }
}

output "virtual_machine_scale_set_linux" {
  value = {
    name        = substr(join("", compact([local.prefix, local.az.virtual_machine_scale_set, local.suffix])), 0, 64)
    name_unique = substr(join("", compact([local.prefix, local.az.virtual_machine_scale_set, local.suffix_unique])), 0, 64)
    dashes      = false
    slug        = local.az.virtual_machine_scale_set
  }
}

output "availability_set" {
  value = {
    name        = join("-", compact([local.prefix, local.az.availability_set, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.availability_set, local.suffix_unique]))
    dashes      = true
    slug        = local.az.availability_set
  }
}

output "vm_storage_account" {
  value = {
    name        = substr(join("", compact([local.prefix, local.az.traffic_manager_profile, local.suffix])), 0, 24)
    name_unique = substr(join("", compact([local.prefix, local.az.traffic_manager_profile, local.suffix_unique])), 0, 24)
    dashes      = true
    slug        = local.az.traffic_manager_profile
  }
}

output "azure_arc_connected_machine" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_arc_connected_machine, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_arc_connected_machine, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_arc_connected_machine
  }
}

output "container_instance" {
  value = {
    name        = join("-", compact([local.prefix, local.az.container_instance, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.container_instance, local.suffix_unique]))
    dashes      = true
    slug        = local.az.container_instance
  }
}

output "aks_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.aks_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.aks_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.aks_cluster
  }
}

output "service_fabric" {
  value = {
    name        = join("-", compact([local.prefix, local.az.service_fabric, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.service_fabric, local.suffix_unique]))
    dashes      = true
    slug        = local.az.service_fabric
  }
}

output "app_service_environment" {
  value = {
    name        = join("-", compact([local.prefix, local.az.app_service_environment, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.app_service_environment, local.suffix_unique]))
    dashes      = true
    slug        = local.az.app_service_environment
  }
}

output "app_service_plan" {
  value = {
    name        = join("-", compact([local.prefix, local.az.app_service_plan, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.app_service_plan, local.suffix_unique]))
    dashes      = true
    slug        = local.az.app_service_plan
  }
}

output "web_app" {
  value = {
    name        = join("-", compact([local.prefix, local.az.web_app, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.web_app, local.suffix_unique]))
    dashes      = true
    slug        = local.az.web_app
  }
}

output "function_app" {
  value = {
    name        = join("-", compact([local.prefix, local.az.function_app, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.function_app, local.suffix_unique]))
    dashes      = true
    slug        = local.az.function_app
  }
}

output "cloud_service" {
  value = {
    name        = join("-", compact([local.prefix, local.az.cloud_service, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.cloud_service, local.suffix_unique]))
    dashes      = true
    slug        = local.az.cloud_service
  }
}

output "notification_hubs" {
  value = {
    name        = join("-", compact([local.prefix, local.az.notification_hubs, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.notification_hubs, local.suffix_unique]))
    dashes      = true
    slug        = local.az.notification_hubs
  }
}

output "notification_hubs_namespace" {
  value = {
    name        = join("-", compact([local.prefix, local.az.notification_hubs_namespace, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.notification_hubs_namespace, local.suffix_unique]))
    dashes      = true
    slug        = local.az.notification_hubs_namespace
  }
}

// Databases

output "sql_server" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_sql_database_server, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_sql_database_server, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_sql_database_server
  }
}

output "sql_database" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_sql_database, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_sql_database, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_sql_database
  }
}

output "cosmos_db" {
  value = {
    name        = join("-", compact([local.prefix, local.az.cosmos_db, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.cosmos_db, local.suffix_unique]))
    dashes      = true
    slug        = local.az.cosmos_db
  }
}

output "redis_cache" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_cache_redis, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_cache_redis, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_cache_redis
  }
}

output "mysql" {
  value = {
    name        = join("-", compact([local.prefix, local.az.mysql_database, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.mysql_database, local.suffix_unique]))
    dashes      = true
    slug        = local.az.mysql_database
  }
}

output "postgre" {
  value = {
    name        = join("-", compact([local.prefix, local.az.postgre_database, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.postgre_database, local.suffix_unique]))
    dashes      = true
    slug        = local.az.postgre_database
  }
}

output "data_warehouse" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_data_warehouse, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_data_warehouse, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_data_warehouse
  }
}

output "synapse" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_synapse_analytics, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_synapse_analytics, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_synapse_analytics
  }
}

output "sql_server_strech_database" {
  value = {
    name        = join("-", compact([local.prefix, local.az.sql_server_strech_database, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.sql_server_strech_database, local.suffix_unique]))
    dashes      = true
    slug        = local.az.sql_server_strech_database
  }
}

// Storage

output "storage_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.storage_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.storage_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.storage_account
  }
}

output "storagesimple" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.azure_storsimple, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.azure_storsimple, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.azure_storsimple
  }
}

// AI + Machine Learning

output "cognitive_search" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_cognitive_search, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_cognitive_search, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_cognitive_search
  }
}

output "cognitive_services" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_cognitive_services, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_cognitive_services, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_cognitive_services
  }
}

output "machine_learning_workspace" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_machine_learning_workspace, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_machine_learning_workspace, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_machine_learning_workspace
  }
}

// Analytics and IoT

output "analysis_services_server" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_analysis_services_server, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_analysis_services_server, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_analysis_services_server
  }
}

output "databricks_workspace" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_databricks_workspace, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_databricks_workspace, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_databricks_workspace
  }
}

output "stream_analytics" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_stream_analytics, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_stream_analytics, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_stream_analytics
  }
}

output "data_factory" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_data_factory, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_data_factory, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_data_factory
  }
}

output "data_lake_store_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.data_lake_store_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.data_lake_store_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.data_lake_store_account
  }
}

output "data_lake_analytics_account" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.data_lake_analytics_account, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.data_lake_analytics_account, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.data_lake_analytics_account
  }
}

output "data_lake_file_system" {
  value = {
    name        = substr(join("", compact([local.prefix_safe, local.az.data_lake_file_system, local.suffix_safe])), 0, 24)
    name_unique = substr(join("", compact([local.prefix_safe, local.az.data_lake_file_system, local.suffix_unique_safe])), 0, 24)
    dashes      = false
    slug        = local.az.data_lake_file_system
  }
}

output "event_hub" {
  value = {
    name        = join("-", compact([local.prefix, local.az.event_hub, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.event_hub, local.suffix_unique]))
    dashes      = true
    slug        = local.az.event_hub
  }
}

output "event_hub_namespace" {
  value = {
    name        = join("-", compact([local.prefix, local.az.event_hub_namespace, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.event_hub_namespace, local.suffix_unique]))
    dashes      = true
    slug        = local.az.event_hub_namespace
  }
}

output "event_hub_namespace_authorization_rule" {
  value = {
    name        = join("-", compact([local.prefix, local.az.event_hub_namespace_authorization_rule, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.event_hub_namespace_authorization_rule, local.suffix_unique]))
    dashes      = true
    slug        = local.az.event_hub_namespace_authorization_rule
  }
}

output "event_hub_authorization_rule" {
  value = {
    name        = join("-", compact([local.prefix, local.az.event_hub_authorization_rule, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.event_hub_authorization_rule, local.suffix_unique]))
    dashes      = true
    slug        = local.az.event_hub_authorization_rule
  }
}

output "hdinsights_hadoop_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_hadoop_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_hadoop_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_hadoop_cluster
  }
}

output "hdinsights_hbase_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_hbase_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_hbase_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_hbase_cluster
  }
}

output "hdinsights_kafka_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_kafka_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_kafka_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_kafka_cluster
  }
}

output "hdinsights_spark_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_spark_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_spark_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_spark_cluster
  }
}

output "hdinsights_storm_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_storm_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_storm_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_storm_cluster
  }
}

output "hdinsights_ml_services_cluster" {
  value = {
    name        = join("-", compact([local.prefix, local.az.hdinsights_ml_services_cluster, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.hdinsights_ml_services_cluster, local.suffix_unique]))
    dashes      = true
    slug        = local.az.hdinsights_ml_services_cluster
  }
}

output "iot_hub" {
  value = {
    name        = join("-", compact([local.prefix, local.az.iot_hub, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.iot_hub, local.suffix_unique]))
    dashes      = true
    slug        = local.az.iot_hub
  }
}

// Integration

output "logic_apps" {
  value = {
    name        = join("-", compact([local.prefix, local.az.logic_apps, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.logic_apps, local.suffix_unique]))
    dashes      = true
    slug        = local.az.logic_apps
  }
}

output "service_bus" {
  value = {
    name        = join("-", compact([local.prefix, local.az.service_bus, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.service_bus, local.suffix_unique]))
    dashes      = true
    slug        = local.az.service_bus
  }
}

output "service_bus_queue" {
  value = {
    name        = join("-", compact([local.prefix, local.az.service_bus_queue, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.service_bus_queue, local.suffix_unique]))
    dashes      = true
    slug        = local.az.service_bus_queue
  }
}

output "service_bus_topic" {
  value = {
    name        = join("-", compact([local.prefix, local.az.service_bus_topic, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.service_bus_topic, local.suffix_unique]))
    dashes      = true
    slug        = local.az.service_bus_topic
  }
}

output "automation_account" {
  value = {
    name        = join("-", compact([local.prefix, local.az.automation_account, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.automation_account, local.suffix_unique]))
    dashes      = true
    slug        = local.az.automation_account
  }
}

// Managment and governance

output "blueprint" {
  value = {
    name        = join("-", compact([local.prefix, local.az.blueprint, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.blueprint, local.suffix_unique]))
    dashes      = true
    slug        = local.az.blueprint
  }
}

output "key_vault" {
  value = {
    name        = join("-", compact([local.prefix, local.az.key_vault, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.key_vault, local.suffix_unique]))
    dashes      = true
    slug        = local.az.key_vault
  }
}

output "key_vault_key" {
  value = {
    name        = join("-", compact([local.prefix, local.az.key_vault_key, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.key_vault_key, local.suffix_unique]))
    dashes      = true
    slug        = local.az.key_vault_key
  }
}

output "log_analytics_workspace" {
  value = {
    name        = join("-", compact([local.prefix, local.az.log_analytics_workspace, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.log_analytics_workspace, local.suffix_unique]))
    dashes      = true
    slug        = local.az.log_analytics_workspace
  }
}

output "application_insights" {
  value = {
    name        = join("-", compact([local.prefix, local.az.application_insights, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.application_insights, local.suffix_unique]))
    dashes      = true
    slug        = local.az.application_insights
  }
}

output "recovery_services_vault" {
  value = {
    name        = join("-", compact([local.prefix, local.az.recovery_services_vault, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.recovery_services_vault, local.suffix_unique]))
    dashes      = true
    slug        = local.az.recovery_services_vault
  }
}

//Migration

output "migrate_project" {
  value = {
    name        = join("-", compact([local.prefix, local.az.azure_migrate_project, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.azure_migrate_project, local.suffix_unique]))
    dashes      = true
    slug        = local.az.azure_migrate_project
  }
}

output "database_migration_service_instance" {
  value = {
    name        = join("-", compact([local.prefix, local.az.database_migration_service_instance, local.suffix]))
    name_unique = join("-", compact([local.prefix, local.az.database_migration_service_instance, local.suffix_unique]))
    dashes      = true
    slug        = local.az.database_migration_service_instance
  }
}
