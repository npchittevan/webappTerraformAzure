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
}

resource "azurerm_subnet" "appsubnet" {
  count = var.app_subnet_count
  name                 = "app-subnet-${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.appvnet.name
  address_prefixes     = [cidrsubnet( var.address_space, 8, count.index )]
}

resource "azurerm_public_ip" "public_ipaddress" {
    count = var.app_subnet_count
  name                = "app-public-ip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"     
}

resource "azurem_network_interface" "network_interface" {
    count = var.app_subnet_count
  name                = "app-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.appsubnet[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ipaddress[count.index].id
  }  
}
resource "azurerm_network_security_group" "appnsg" {
  name                = "app-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "security_rule" {
    for_each = toset(var.network_security_group_rules)
    content {   
      name                       = "rule-${security_rule.value.priority}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  
}
resource "azurerm_network_interface_security_group_association" "nsg_association" {
    count = var.app_subnet_count
  network_interface_id      = azurem_network_interface.network_interface[count.index].id
  network_security_group_id = azurerm_network_security_group.aapnsg.id
}