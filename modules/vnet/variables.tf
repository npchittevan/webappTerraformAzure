variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "location" {
  type = string
  description = "Location of the resource group"
}

variable "appvnet_name" {
  type = string
  description = "Name of the Virtual Network"
}

variable "address_space" {
  type = string
}