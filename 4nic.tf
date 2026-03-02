# Network Interface Card 
resource "azurerm_network_interface" "nic1" {
    name = var.nic1_name
    location = azurerm_virtual_network.Vnet1.location
    resource_group_name = azurerm_resource_group.rg1.name

    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.sub1.id
      private_ip_address_allocation = "Dynamic" 

#      Attach public IP id to NIC for VM 
#      public_ip_address_id = azurerm_public_ip.pip1.id
  }
}

# NIC to Load Balancer Backend Pool assign 
resource "azurerm_network_interface_backend_address_pool_association" "nic1lb" {
  network_interface_id    = azurerm_network_interface.nic1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
}


