#resource group 
resource "azurerm_resource_group" "rg1" {
    name = var.rg1_name
    location = var.rg1_loc
}

# virtual network1
resource "azurerm_virtual_network" "Vnet1" {
  name                = var.Vnet1_name
  location            = var.Vnet1_loc
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = var.Vnet1_ip
  depends_on = [ azurerm_resource_group.rg1 ]
}

#subnet1 for VM 
resource "azurerm_subnet" "sub1" {
  name                 = var.sub1_name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = var.sub1_ip
  depends_on = [ azurerm_virtual_network.Vnet1 ]
}

#subnet2 for Load Balancer
resource "azurerm_subnet" "sub2" {
  name                 = var.sub2_name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = var.sub2_ip
}

#subnet3 For Route Table 
resource "azurerm_subnet" "sub3" {
  name                 = var.sub3_name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = var.sub3_ip
}

#subnet4 for Firewall 
resource "azurerm_subnet" "sub4" {
  name                 = var.sub4_name 
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = var.sub4_ip
}





