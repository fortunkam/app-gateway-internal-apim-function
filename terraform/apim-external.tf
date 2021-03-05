resource "azurerm_user_assigned_identity" "apim_external" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = local.apim_external_sp_app_name
}

resource "azurerm_api_management" "apim_external" {
  name                = local.apim_external_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = local.apim_publisher_name
  publisher_email     = local.apim_publisher_email

  sku_name = "Developer_1"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.apim_external.id]
  }

  virtual_network_configuration {
    subnet_id = azurerm_subnet.apim_external.id
  }

  virtual_network_type = "External"
}
