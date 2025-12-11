output "network_interface_private_ip_addresses" {
  description = "Private IP addresses of the network interfaces"
  value       = azurerm_network_interface.network_interface[*].private_ip_address
}
output "virtual_network_interface_ids" {
  description = "IDs of the virtual network interfaces"
  value       = azurerm_network_interface.network_interface[*].id
}
output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.appvnet.id
}