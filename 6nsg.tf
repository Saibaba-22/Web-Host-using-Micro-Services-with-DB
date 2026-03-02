# Network Security Group 
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg1_name
  location            = azurerm_virtual_network.Vnet1.location
  resource_group_name = azurerm_resource_group.rg1.name

# For VM Login 
  security_rule {
    name                       = "allowssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

# For Website to Webserver
  security_rule {
    name                        = "WebsitetoWebserver"
    priority                    = 102
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "5000"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }


}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.sub1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

