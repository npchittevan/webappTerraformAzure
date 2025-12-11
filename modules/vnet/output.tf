output "network_interface_private_ip_addresses" {
    description = "Private IP addresses of the network interfaces"
    value       = azurerm_network_interface.network_interface[*].private_ip_address
}