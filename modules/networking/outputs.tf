output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.main.name
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value = {
    app  = azurerm_subnet.app.id
    data = azurerm_subnet.data.id
    mgmt = azurerm_subnet.mgmt.id
  }
}

output "nsg_ids" {
  description = "Map of NSG names to their IDs"
  value = {
    app  = azurerm_network_security_group.app.id
    data = azurerm_network_security_group.data.id
    mgmt = azurerm_network_security_group.mgmt.id
  }
}
