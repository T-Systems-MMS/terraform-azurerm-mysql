/**
 * # mysql
 *
 * This module manages Azure MySQL.
 *
*/

resource "azurerm_mysql_server" "mysql_server" {
  for_each = var.mysql_server

  name                              = local.mysql_server[each.key].name == "" ? each.key : local.mysql_server[each.key].name
  resource_group_name               = local.mysql_server[each.key].resource_group_name
  location                          = local.mysql_server[each.key].location
  sku_name                          = local.mysql_server[each.key].sku_name
  version                           = local.mysql_server[each.key].version
  administrator_login               = local.mysql_server[each.key].administrator_login
  administrator_login_password      = local.mysql_server[each.key].administrator_login_password
  auto_grow_enabled                 = local.mysql_server[each.key].auto_grow_enabled
  backup_retention_days             = local.mysql_server[each.key].backup_retention_days
  create_mode                       = local.mysql_server[each.key].create_mode
  creation_source_server_id         = local.mysql_server[each.key].creation_source_server_id
  geo_redundant_backup_enabled      = local.mysql_server[each.key].geo_redundant_backup_enabled
  infrastructure_encryption_enabled = local.mysql_server[each.key].infrastructure_encryption_enabled
  public_network_access_enabled     = local.mysql_server[each.key].public_network_access_enabled
  restore_point_in_time             = local.mysql_server[each.key].restore_point_in_time
  ssl_enforcement_enabled           = local.mysql_server[each.key].ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = local.mysql_server[each.key].ssl_minimal_tls_version_enforced
  storage_mb                        = local.mysql_server[each.key].storage_mb

  dynamic "identity" {
    for_each = local.mysql_server[each.key].identity != {} ? [1] : []
    content {
      type = local.mysql_server[each.key].identity.type
    }
  }

  dynamic "threat_detection_policy" {
    for_each = local.mysql_server[each.key].threat_detection_policy.enabled == true ? [1] : []
    content {
      enabled                    = local.mysql_server[each.key].threat_detection_policy.enabled
      disabled_alerts            = local.mysql_server[each.key].threat_detection_policy.disabled_alerts
      email_account_admins       = local.mysql_server[each.key].threat_detection_policy.email_account_admins
      email_addresses            = local.mysql_server[each.key].threat_detection_policy.email_addresses
      retention_days             = local.mysql_server[each.key].threat_detection_policy.retention_days
      storage_account_access_key = local.mysql_server[each.key].threat_detection_policy.storage_account_access_key
      storage_endpoint           = local.mysql_server[each.key].threat_detection_policy.storage_endpoint
    }
  }

  tags = local.mysql_server[each.key].tags
}

resource "azurerm_mysql_configuration" "mysql_configuration" {
  for_each = var.mysql_configuration

  name                = local.mysql_configuration[each.key].name == "" ? each.key : local.mysql_configuration[each.key].name
  server_name         = local.mysql_configuration[each.key].server_name
  resource_group_name = local.mysql_configuration[each.key].resource_group_name
  value               = local.mysql_configuration[each.key].value
}

resource "azurerm_mysql_virtual_network_rule" "mysql_virtual_network_rule" {
  for_each = var.mysql_virtual_network_rule

  name                = local.mysql_virtual_network_rule[each.key].name == "" ? each.key : local.mysql_virtual_network_rule[each.key].name
  server_name         = local.mysql_virtual_network_rule[each.key].server_name
  resource_group_name = local.mysql_virtual_network_rule[each.key].resource_group_name
  subnet_id           = local.mysql_virtual_network_rule[each.key].subnet_id
}

resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  for_each = var.mysql_firewall_rule

  name                = local.mysql_firewall_rule[each.key].name == "" ? each.key : local.mysql_firewall_rule[each.key].name
  server_name         = local.mysql_firewall_rule[each.key].server_name
  resource_group_name = local.mysql_firewall_rule[each.key].resource_group_name
  start_ip_address    = local.mysql_firewall_rule[each.key].start_ip_address
  end_ip_address      = local.mysql_firewall_rule[each.key].end_ip_address
}


resource "azurerm_mysql_database" "mysql_database" {
  for_each = var.mysql_database

  name                = local.mysql_database[each.key].name == "" ? each.key : local.mysql_database[each.key].name
  server_name         = local.mysql_database[each.key].server_name
  resource_group_name = local.mysql_database[each.key].resource_group_name
  charset             = local.mysql_database[each.key].charset
  collation           = local.mysql_database[each.key].collation
}

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  for_each = var.mysql_flexible_server

  name                              = local.mysql_flexible_server[each.key].name == "" ? each.key : local.mysql_flexible_server[each.key].name
  resource_group_name               = local.mysql_flexible_server[each.key].resource_group_name
  location                          = local.mysql_flexible_server[each.key].location
  sku_name                          = local.mysql_flexible_server[each.key].sku_name
  version                           = local.mysql_flexible_server[each.key].version
  zone                              = local.mysql_flexible_server[each.key].zone
  source_server_id                  = local.mysql_flexible_server[each.key].source_server_id
  replication_role                  = local.mysql_flexible_server[each.key].replication_role
  administrator_login               = local.mysql_flexible_server[each.key].administrator_login
  administrator_password            = local.mysql_flexible_server[each.key].administrator_password
  backup_retention_days             = local.mysql_flexible_server[each.key].backup_retention_days
  create_mode                       = local.mysql_flexible_server[each.key].create_mode
  delegated_subnet_id               = local.mysql_flexible_server[each.key].delegated_subnet_id
  geo_redundant_backup_enabled      = local.mysql_flexible_server[each.key].geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = local.mysql_flexible_server[each.key].point_in_time_restore_time_in_utc
  private_dns_zone_id               = local.mysql_flexible_server[each.key].private_dns_zone_id

  dynamic "high_availability" {
    for_each = local.mysql_flexible_server[each.key].high_availability.mode != "" ? [1] : []
    content {
      mode                      = local.mysql_flexible_server[each.key].high_availability.mode
      standby_availability_zone = local.mysql_flexible_server[each.key].high_availability.standby_availability_zone
    }
  }

  dynamic "maintenance_window" {
    for_each = local.mysql_flexible_server[each.key].maintenance_window != {} ? [1] : []
    content {
      day_of_week  = local.mysql_flexible_server[each.key].maintenance_window.day_of_week
      start_hour   = local.mysql_flexible_server[each.key].maintenance_window.start_hour
      start_minute = local.mysql_flexible_server[each.key].maintenance_window.start_minute
    }
  }

  dynamic "storage" {
    for_each = local.mysql_flexible_server[each.key].storage != {} ? [1] : []
    content {
      auto_grow_enabled = local.mysql_flexible_server[each.key].storage.auto_grow_enabled
      iops              = local.mysql_flexible_server[each.key].storage.iops
      size_gb           = local.mysql_flexible_server[each.key].storage.size_gb
    }
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }

  tags = local.mysql_flexible_server[each.key].tags
}

resource "azurerm_mysql_flexible_server_configuration" "mysql_flexible_server_configuration" {
  for_each = var.mysql_flexible_server_configuration

  name                = local.mysql_flexible_server_configuration[each.key].name == "" ? each.key : local.mysql_flexible_server_configuration[each.key].name
  server_name         = local.mysql_flexible_server_configuration[each.key].server_name
  resource_group_name = local.mysql_flexible_server_configuration[each.key].resource_group_name
  value               = local.mysql_flexible_server_configuration[each.key].value
}

resource "azurerm_mysql_flexible_server_firewall_rule" "mysql_flexible_server_firewall_rule" {
  for_each = var.mysql_flexible_server_firewall_rule

  name                = local.mysql_flexible_server_firewall_rule[each.key].name == "" ? each.key : local.mysql_flexible_server_firewall_rule[each.key].name
  server_name         = local.mysql_flexible_server_firewall_rule[each.key].server_name
  resource_group_name = local.mysql_flexible_server_firewall_rule[each.key].resource_group_name
  start_ip_address    = local.mysql_flexible_server_firewall_rule[each.key].start_ip_address
  end_ip_address      = local.mysql_flexible_server_firewall_rule[each.key].end_ip_address
}

resource "azurerm_mysql_flexible_database" "mysql_flexible_database" {
  for_each = var.mysql_flexible_database

  name                = local.mysql_flexible_database[each.key].name == "" ? each.key : local.mysql_database[each.key].name
  server_name         = local.mysql_flexible_database[each.key].server_name
  resource_group_name = local.mysql_flexible_database[each.key].resource_group_name
  charset             = local.mysql_flexible_database[each.key].charset
  collation           = local.mysql_flexible_database[each.key].collation
}
