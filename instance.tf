# Create instance 1
resource "azurerm_virtual_machine" "git-vm" {
  name                          = "git-vm"
  location                      = var.location_name
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.nic.id]
  vm_size                       = "Standard_D4s_v3"
  delete_os_disk_on_termination = true
  depends_on = [ azurerm_network_interface.nic, azurerm_public_ip.pip ]

  storage_os_disk {
    name              = "git-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "git-vm"
    admin_username = "adminuser"
    admin_password = "password1234!"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }

  tags = local.tag
}
