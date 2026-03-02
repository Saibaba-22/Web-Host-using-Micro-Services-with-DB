
# 1 Load balancer 
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = azurerm_virtual_network.Vnet1.location
  resource_group_name = azurerm_resource_group.rg1.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.piplb.id
  }
}

# 2 Backend pools
resource "azurerm_lb_backend_address_pool" "backendpool" {
  name            = var.backendpool_name
  loadbalancer_id = azurerm_lb.lb.id
}

# 3 Health Probes
resource "azurerm_lb_probe" "healthprobe" {
  name            = var.healthprobe_name
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 5000
}


# 4 Load balancer rules 
resource "azurerm_lb_rule" "http" {
  name                           = "http"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 5000
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendpool.id]
  probe_id                       = azurerm_lb_probe.healthprobe.id
}
