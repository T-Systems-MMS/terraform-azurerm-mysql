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

