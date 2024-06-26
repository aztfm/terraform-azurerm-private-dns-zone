resource "azurerm_resource_group" "rg" {
  name     = local.workspace_id
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet_1" {
  name                = "${local.workspace_id}1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags
  address_space       = ["10.1.0.0/24"]
}

resource "azurerm_virtual_network" "vnet_2" {
  name                = "${local.workspace_id}2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags
  address_space       = ["10.2.0.0/24"]
}
