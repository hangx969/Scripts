# 创建NIC
resource "azurerm_network_interface" "netinterface" {
  name                = "${var.vmname}-nic"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetid # 这里必须要提供subnetid，好让NIC attach上
    private_ip_address_allocation = "Dynamic"
  }
}

# 创建VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmname
  resource_group_name = var.rgname
  location            = var.location
  size                = var.size
  admin_username      = var.localadmin
  admin_password      = var.adminpw
  network_interface_ids = [
    azurerm_network_interface.netinterface.id, # 这里还需给到NIC的ID
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}