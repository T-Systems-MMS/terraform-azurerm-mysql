output "mysql_server" {
  description = "azurerm_mysql_server results"
  value = {
    for mysql_server in keys(azurerm_mysql_server.mysql_server) :
    mysql_server => {
      id                  = azurerm_mysql_server.mysql_server[mysql_server].id
      name                = azurerm_mysql_server.mysql_server[mysql_server].name
      fqdn                = azurerm_mysql_server.mysql_server[mysql_server].fqdn
      administrator_login = azurerm_mysql_server.mysql_server[mysql_server].administrator_login
    }
  }
}

output "mysql_database" {
  description = "azurerm_mysql_database results"
  value = {
    for mysql_database in keys(azurerm_mysql_database.mysql_database) :
    mysql_database => {
      id          = azurerm_mysql_database.mysql_database[mysql_database].id
      name        = azurerm_mysql_database.mysql_database[mysql_database].name
      server_name = azurerm_mysql_database.mysql_database[mysql_database].server_name
    }
  }
}

output "mysql_flexible_server" {
  description = "azurerm_mysql_flexible_server results"
  value = {
    for mysql_flexible_server in keys(azurerm_mysql_flexible_server.mysql_flexible_server) :
    mysql_flexible_server => {
      id                  = azurerm_mysql_flexible_server.mysql_flexible_server[mysql_flexible_server].id
      name                = azurerm_mysql_flexible_server.mysql_flexible_server[mysql_flexible_server].name
      fqdn                = azurerm_mysql_flexible_server.mysql_flexible_server[mysql_flexible_server].fqdn
      administrator_login = azurerm_mysql_flexible_server.mysql_flexible_server[mysql_flexible_server].administrator_login
    }
  }
}

output "mysql_flexible_database" {
  description = "azurerm_mysql_flexible_database results"
  value = {
    for mysql_flexible_database in keys(azurerm_mysql_flexible_database.mysql_flexible_database) :
    mysql_flexible_database => {
      id          = azurerm_mysql_flexible_database.mysql_flexible_database[mysql_flexible_database].id
      name        = azurerm_mysql_flexible_database.mysql_flexible_database[mysql_flexible_database].name
      server_name = azurerm_mysql_flexible_database.mysql_flexible_database[mysql_flexible_database].server_name
    }
  }
}
