variable "mysql_server" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_configuration" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_virtual_network_rule" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_firewall_rule" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
  default = {
    # resource definition
    mysql_server = {
      name                              = ""
      administrator_login               = null
      administrator_login_password      = null
      auto_grow_enabled                 = true
      backup_retention_days             = 7
      create_mode                       = "Default"
      creation_source_server_id         = null
      geo_redundant_backup_enabled      = false
      infrastructure_encryption_enabled = false
      public_network_access_enabled     = true
      restore_point_in_time             = null
      ssl_enforcement_enabled           = true
      ssl_minimal_tls_version_enforced  = "TLS1_2"
      identity                          = {}
      threat_detection_policy = {
        enabled                    = false
        disabled_alerts            = null
        email_account_admins       = null
        email_addresses            = null
        retention_days             = null
        storage_account_access_key = null
        storage_endpoint           = null
      }
      tags = {}
    }
    mysql_configuration = {
      name = ""
    }
    mysql_virtual_network_rule = {
      name = ""
    }
    mysql_firewall_rule = {
      name = ""
    }
  }

  # compare and merge custom and default values
  mysql_server_values = {
    for mysql_server in keys(var.mysql_server) :
    mysql_server => merge(local.default.mysql_server, var.mysql_server[mysql_server])
  }

  # merge all custom and default values
  mysql_server = {
    for mysql_server in keys(var.mysql_server) :
    mysql_server => merge(
      local.mysql_server_values[mysql_server],
      {
        for config in [
          "identity",
          "threat_detection_policy"
        ] :
        config => merge(local.default.mysql_server[config], local.mysql_server_values[mysql_server][config])
      }
    )
  }
  mysql_configuration = {
    for mysql_configuration in keys(var.mysql_configuration) :
    mysql_configuration => merge(local.default.mysql_configuration, var.mysql_configuration[mysql_configuration])
  }
  mysql_virtual_network_rule = {
    for mysql_virtual_network_rule in keys(var.mysql_virtual_network_rule) :
    mysql_virtual_network_rule => merge(local.default.mysql_virtual_network_rule, var.mysql_virtual_network_rule[mysql_virtual_network_rule])
  }
  mysql_firewall_rule = {
    for mysql_firewall_rule in keys(var.mysql_firewall_rule) :
    mysql_firewall_rule => merge(local.default.mysql_firewall_rule, var.mysql_firewall_rule[mysql_firewall_rule])
  }
}
