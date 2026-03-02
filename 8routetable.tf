
resource "azurerm_route_table" "rt" {
  name                = "vm-rt"
  location            = azurerm_virtual_network.Vnet1.location
  resource_group_name = azurerm_resource_group.rg1.name

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address

  }
}

# Subnets associate to Route table 
resource "azurerm_subnet_route_table_association" "sub1associateroute" {
  subnet_id      = azurerm_subnet.sub1.id
  route_table_id = azurerm_route_table.rt.id
}

