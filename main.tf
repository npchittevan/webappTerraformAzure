module "resource_group" {
  source = "./modules/resourcegroup"

  resource_group_name = var.resource_group_name
  location            = var.location
}
module "vnet" {
  source = "./modules/vnet"

  resource_group_name          = var.resource_group_name
  location                     = var.location
  appvnet_name                 = var.appvnet_name
  address_space                = var.address_space
  app_subnet_count             = var.app_subnet_count
  network_security_group_rules = var.network_security_group_rules
  depends_on                   = [module.resource_group]
}

module "machines" {
  source = "./modules/virtualMachine"

  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_vm_count                  = var.app_vm_count
  virtual_network_interface_ids = module.virtual_network.virtual_network_interface_ids
  depends_on                    = [module.vnet]
}

module "loadbalancer" {
  source                               = "./modules/loadbalancer"
  app_subnet_count                     = var.app_subnet_count
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  network_interface_private_ip_address = module.vnet.network_interface_private_ip_addresses
  depends_on                           = [module.resource_group]
}