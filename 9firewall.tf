
# Azure Firewall 
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = azurerm_virtual_network.Vnet1.location
  resource_group_name = azurerm_resource_group.rg1.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.sub4.id
    public_ip_address_id = azurerm_public_ip.firewallpip.id
  }

# Firewall Policy id associate 
  firewall_policy_id = azurerm_firewall_policy.fwpolicy.id

}

# Azure Firewall Policy 
resource "azurerm_firewall_policy" "fwpolicy" {
  name                = var.fwpolicy_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_virtual_network.Vnet1.location
}

resource "azurerm_firewall_policy_rule_collection_group" "firewallrule" {
  name               = var.firewallrule_name
  firewall_policy_id = azurerm_firewall_policy.fwpolicy.id
  priority           = 500

# DNAT Rules
  nat_rule_collection {
    name     = "login"
    action   = "Dnat"
    priority = 200
#    rule_type = "dnat"

    rule {
      name                   = "ssh"
      source_addresses       = ["*"]
      destination_address    = azurerm_public_ip.firewallpip.ip_address
      destination_ports      = ["22"]
      protocols              = ["TCP"]
      translated_address     = "10.1.1.4"  # VM private IP
      translated_port        = "22"
    }
        rule {
      name                   = "ittoweb"
      source_addresses       = ["*"]
      destination_address    = azurerm_public_ip.firewallpip.ip_address
      destination_ports      = ["5000"]
      protocols              = ["TCP"]
      translated_address     = "10.1.1.4"  # VM private IP
      translated_port        = "5000"
    }

  }

# Network Rules 
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 400
    action   = "Allow"
        rule {
      name                  = "allow5000"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["10.1.1.4"]
      destination_ports     = ["5000"]
    }

  }

}

