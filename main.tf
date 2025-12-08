module "resource_group" {
  source = "./modules/resourcegroup"

  resource_group_name = var.resource_group_name
  location            = var.location
}