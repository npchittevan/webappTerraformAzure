variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}
variable "app_subnet_count" {
  type = string
  description = "total subnet count"
}
variable "network_interface_private_ip_address" {
  type=list(string) 
  description = "This is the private IP addresses of the network interfaces attached to the virtual machines"
}
