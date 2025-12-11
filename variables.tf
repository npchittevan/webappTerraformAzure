variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}
variable "appvnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}
variable "address_space" {
  type = string
}
variable "network_security_group_rules" {
  type = list(object({
    priority               = number
    destination_port_range = string
  }))
}
variable "app_subnet_count" {
  type        = number
  description = "value of total subnets to be created"
}
variable "app_vm_count" {
  type = number
  description = "value"
}