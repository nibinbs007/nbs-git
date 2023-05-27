#create security group
resource "azurerm_network_security_group" "nsg" {
    name = "nsg"
    location = var.location_name
    resource_group_name = var.resource_group_name
    tags = local.tag
    security_rule {
    name                       = "allow_for_me"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "202.166.43.187"
    destination_address_prefix = "*"
  }

}
#create vnet
resource "azurerm_virtual_network" "cmt-git" {
    name = "cmt-git"
    location = var.location_name
    resource_group_name = var.resource_group_name
    address_space = [lookup(var.address_space,1)]
    tags = local.tag
}

#create subnet
resource "azurerm_subnet" "sub_git" {
    name = "sub_git" 
    virtual_network_name = azurerm_virtual_network.cmt-git.name
    resource_group_name = var.resource_group_name
    address_prefixes = [lookup(var.address_space,2)]
}

#associate security group
resource "azurerm_subnet_network_security_group_association" "asg" {
    subnet_id = azurerm_subnet.sub_git.id
    network_security_group_id = azurerm_network_security_group.nsg.id
    depends_on = [ azurerm_network_security_group.nsg, azurerm_subnet.sub_git ]
  
}
#create public IP
resource "azurerm_public_ip" "pip" {
    name = "pip"
    resource_group_name = var.resource_group_name
    location = var.location_name
    allocation_method = "Dynamic"
    tags = local.tag
}
#create network interface
resource "azurerm_network_interface" "nic" {
    name = "nic"
    location = var.location_name
    resource_group_name = var.resource_group_name
    ip_configuration {
      name = "priv"
      subnet_id = azurerm_subnet.sub_git.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.pip.id
    }
  
}