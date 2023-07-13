# terraform-azurerm-mysql

This module is deprecated. You can find the currently version here [https://registry.terraform.io/modules/T-Systems-MMS/container/azurerm/latest](https://registry.terraform.io/modules/telekom-mms/database/azurerm/latest).

<!-- BEGIN_TF_DOCS -->
# mysql

This module manages Azure MySQL.

<-- This file is autogenerated, please do not change. -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.0 |
| azurerm | >=3.11.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=3.11.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_mysql_configuration.mysql_configuration | resource |
| azurerm_mysql_database.mysql_database | resource |
| azurerm_mysql_firewall_rule.mysql_firewall_rule | resource |
| azurerm_mysql_server.mysql_server | resource |
| azurerm_mysql_virtual_network_rule.mysql_virtual_network_rule | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| mysql_configuration | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_database | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_firewall_rule | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_server | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_virtual_network_rule | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| mysql_database | azurerm_mysql_database results |
| mysql_server | azurerm_mysql_server results |

## Examples

```hcl
module "mysql" {
  source = "registry.terraform.io/T-Systems-MMS/mysql/azurerm"
  mysql_server = {
    service-db = {
      location                     = "westeurope"
      resource_group_name          = "service-rg"
      version                      = "5.7"
      sku_name                     = "GP_Gen5_2"
      storage_mb                   = 112640
      administrator_login          = "mysqlroot"
      administrator_login_password = "password"
      tags = {
        service = "service_name"
      }
    }
  }
  mysql_configuration = {
    service = {
      slow_query_log = "On"
    }
  }
  mysql_virtual_network_rule = {
    db-subnet = {
      resource_group_name = "service-rg"
      server_name         = module.mysql.mysql_server["service-db"].name
      subnet_id           = module.network.subnet.db-subnet.id
    }
  }
  mysql_firewall_rule = {
    proxy = {
      resource_group_name = "service-rg"
      server_name         = module.mysql.mysql_server["service-db"].name
      start_ip_address    = "127.0.0.1"
      end_ip_address      = "127.0.0.2"
    }
  }
}
```
<!-- END_TF_DOCS -->
