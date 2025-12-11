variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "app_vm_count" {
  type        = number
  description = "value"
}

variable "virtual_network_interface_ids" {
  type        = list(string)
  description = "This will hold the virtual network interfaces ids"
}