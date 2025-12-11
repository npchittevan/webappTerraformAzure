resource "azurerm_public_ip" "lb-public-ip" {
  name                = "app-lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_lb" "loadbalancer" {
  name                = "app-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name                 = "frontend_ip"
    public_ip_address_id = azurerm_public_ip.lb-public-ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend-pool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "backend_pool"
}
resource "azurerm_lb_backend_address_pool_address" "appvmaddress" {
  count                   = var.app_subnet_count
  name                    = "machine${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend-pool.id
  ip_address              = var.network_interface_private_ip_address[count.index]
}

resource "azurerm_lb_probe" "probeA" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "probeA"
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "http-rule"
  protocol                       = "TCP"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend_ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend-pool.id]
  probe_id                       = azurerm_lb_probe.probeA.id
}