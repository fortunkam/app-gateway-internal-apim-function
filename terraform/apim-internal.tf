resource "azurerm_user_assigned_identity" "apim_internal" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = local.apim_internal_sp_app_name
}

resource "azurerm_api_management" "apim_internal" {
  name                = local.apim_internal_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = local.apim_publisher_name
  publisher_email     = local.apim_publisher_email

  sku_name = "Developer_1"

  # identity {
  #   type         = "SystemAssigned, UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.apim_internal.id]
  # }

  identity {
    type         = "SystemAssigned"
  }

  virtual_network_configuration {
    subnet_id = azurerm_subnet.apim_internal.id
  }

  virtual_network_type = "Internal"

  lifecycle {
    ignore_changes = [ 
        hostname_configuration
     ]
  } 
}

resource "azurerm_api_management_custom_domain" "apim_internal" {
  api_management_id = azurerm_api_management.apim_internal.id

  proxy {
    host_name    = local.api_dns_name
    key_vault_id = azurerm_key_vault_certificate.api_cert.secret_id
  }

  developer_portal {
    host_name    = local.devportal_dns_name
    key_vault_id = azurerm_key_vault_certificate.devportal_cert.secret_id
  }

  depends_on = [ azurerm_key_vault_access_policy.apim_internal ]
  lifecycle {
    ignore_changes = all
  } 
}