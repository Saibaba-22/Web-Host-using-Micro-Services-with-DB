# For 1st time allot to VM and create Web app and DB 
# Once configuration and setup is done 
# Allot this public ip to Load Balancer and 
# VM to Load balancer Backend Pool 
resource "azurerm_public_ip" "piplb" {
    name = var.pip1_name
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_virtual_network.Vnet1.location
    allocation_method = "Static"
    sku               = "Standard"

    tags = {
        environment = " production "
    }
}

#public IP for firewall
resource "azurerm_public_ip" "firewallpip" {
  name                = var.firewallpip_name
  location            = azurerm_virtual_network.Vnet1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

/*
pip1 - Load Balancer
pip2 - firewall 
*/
