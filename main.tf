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
      type = ocal.mysql_server[each.key].identity.type
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
