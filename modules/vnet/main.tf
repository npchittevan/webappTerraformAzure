resource "azurerm_network_security_group" "aapnsg" {
  name                = "app-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "appvnet" {
  name                = var.appvnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.aapnsg.id
  } 
}