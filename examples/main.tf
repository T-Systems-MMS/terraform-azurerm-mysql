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
