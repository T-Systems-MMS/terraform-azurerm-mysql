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
variable "mysql_database" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

variable "mysql_flexible_server" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_flexible_server_configuration" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_flexible_server_firewall_rule" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_flexible_database" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
  default = {
    # resource definition for mysql server
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
    mysql_database = {
      name      = ""
      charset   = "utf8"
      collation = "utf8_unicode_ci"
    }

    # resource definition for mysql flexible server
    mysql_flexible_server = {
      name                              = ""
      zone                              = 1
      create_mode                       = "Default"
      source_server_id                  = null
      replication_role                  = null
      administrator_login               = null
      administrator_password            = null
      backup_retention_days             = 7
      delegated_subnet_id               = null
      geo_redundant_backup_enabled      = false
      point_in_time_restore_time_in_utc = null
      private_dns_zone_id               = null
      high_availability = {
        mode                      = ""
        standby_availability_zone = 2
      }
      maintenance_window = {}
      storage            = {}
      tags               = {}
    }
    mysql_flexible_server_configuration = {
      name = ""
    }
    mysql_flexible_server_firewall_rule = {
      name = ""
    }
    mysql_flexible_database = {
      name      = ""
      charset   = "utf8"
      collation = "utf8_unicode_ci"
    }
  }

  # compare and merge custom and default values
  mysql_server_values = {
    for mysql_server in keys(var.mysql_server) :
    mysql_server => merge(local.default.mysql_server, var.mysql_server[mysql_server])
  }

  mysql_flexible_server_values = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(local.default.mysql_flexible_server, var.mysql_flexible_server[mysql_flexible_server])
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
  mysql_database = {
    for mysql_database in keys(var.mysql_database) :
    mysql_database => merge(local.default.mysql_database, var.mysql_database[mysql_database])
  }

  mysql_flexible_server = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(
      local.mysql_flexible_server_values[mysql_flexible_server],
      {
        for config in [
          "high_availability",
          "maintenance_window",
          "storage"
        ] :
        config => merge(local.default.mysql_flexible_server[config], local.mysql_flexible_server_values[mysql_flexible_server][config])
      }
    )
  }
  mysql_flexible_server_configuration = {
    for mysql_flexible_server_configuration in keys(var.mysql_flexible_server_configuration) :
    mysql_flexible_server_configuration => merge(local.default.mysql_flexible_server_configuration, var.mysql_flexible_server_configuration[mysql_flexible_server_configuration])
  }
  mysql_flexible_server_firewall_rule = {
    for mysql_flexible_server_firewall_rule in keys(var.mysql_flexible_server_firewall_rule) :
    mysql_flexible_server_firewall_rule => merge(local.default.mysql_flexible_server_firewall_rule, var.mysql_flexible_server_firewall_rule[mysql_flexible_server_firewall_rule])
  }
  mysql_flexible_database = {
    for mysql_flexible_database in keys(var.mysql_flexible_database) :
    mysql_flexible_database => merge(local.default.mysql_flexible_database, var.mysql_flexible_database[mysql_flexible_database])
  }
}
