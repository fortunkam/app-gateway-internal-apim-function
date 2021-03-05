# Create an application
resource "azuread_application" "apim_internal" {
  name = local.apim_internal_sp_app_name
}

# Create a service principal
resource "azuread_service_principal" "apim_internal" {
  application_id = azuread_application.apim_internal.application_id
}

resource "azuread_application" "apim_external" {
  name = local.apim_external_sp_app_name
}

# Create a service principal
resource "azuread_service_principal" "apim_external" {
  application_id = azuread_application.apim_external.application_id
}

resource "azuread_application" "appgateway" {
  name = local.appgateway_sp_app_name
}

# Create a service principal
resource "azuread_service_principal" "appgateway" {
  application_id = azuread_application.appgateway.application_id
}