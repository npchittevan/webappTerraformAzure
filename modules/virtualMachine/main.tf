resource "azurerm_linux_virtual_machine" "appvm" {
  count               = var.app_vm_count
  name                = "app-vm${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password = "admin@12345"
  custom_data = data.local_file.cloudinit.content_base64


  network_interface_ids = [
    var.virtual_network_interface_ids[count.index]
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
data "local_file" "cloudinit" {
  filename = "./modules/virtualMachine/cloudinit"  
}