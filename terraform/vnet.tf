resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [local.vnet_iprange]
}

resource "azurerm_subnet" "functions" {
  name                 = local.function_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [local.function_subnet_iprange]
}


resource "azurerm_subnet" "apim" {
  name                 = local.apim_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [local.apim_subnet_iprange]
}
