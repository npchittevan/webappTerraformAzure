module "resource_group" {
  source = "./modules/resourcegroup"

  resource_group_name = var.resource_group_name
  location            = var.location
}
module "vnet" {
  source = "./modules/vnet"

  resource_group_name = var.resource_group_name
  location            = var.location
  appvnet_name        = var.appvnet_name
  address_space       = var.address_space
    app_subnet_count    = var.app_subnet_count
    network_security_group_rules = var.network_security_group_rules

}