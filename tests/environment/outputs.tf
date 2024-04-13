output "workspace_id" {
  value = local.workspace_id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "virtual_network_id_1" {
  value = azurerm_virtual_network.vnet_1.id
}

output "virtual_network_id_2" {
  value = azurerm_virtual_network.vnet_2.id
}
