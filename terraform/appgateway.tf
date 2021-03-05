resource "azurerm_public_ip" "gateway" {
  name                = local.appgateway_publicip
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = local.appgateway_sp_app_name
}



resource "azurerm_application_gateway" "appgateway" {
  name                = local.appgateway
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.appgateway.id
    ]
  }

  ssl_certificate {
    name = local.api_dns_name
    key_vault_secret_id = azurerm_key_vault_certificate.api_cert.secret_id
  }

  gateway_ip_configuration {
    name      = local.appgateway_ipconfig_name
    subnet_id = azurerm_subnet.appgateway.id
  }

  frontend_port {
    name = local.appgateway_frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.appgateway_frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.gateway.id
  }

  probe {
      name = local.appgateway_probe
      protocol = "Https"
      interval = 30
      path = "/status-0123456789abcdef"
      unhealthy_threshold = 8
      timeout = 120
      host = local.api_dns_name
  }

  backend_address_pool {
    name = local.appgateway_backend_pool_name
    ip_addresses = [
        azurerm_api_management.apim_internal.private_ip_addresses[0]
    ]
  }

  trusted_root_certificate {
    name = "api_auth_cert"
    data = azurerm_key_vault_certificate.api_cert.certificate_data_base64
  }

  backend_http_settings {
    name                  = local.appgateway_http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 180
    probe_name              = local.appgateway_probe
    trusted_root_certificate_names = [ "api_auth_cert" ]
    host_name = local.api_dns_name
  }

  http_listener {
    name                           = local.appgateway_listener_name
    frontend_ip_configuration_name = local.appgateway_frontend_ip_configuration_name
    frontend_port_name             = local.appgateway_frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name = local.api_dns_name
    host_names = [ local.api_dns_name ]
    require_sni = true
  }

  request_routing_rule {
    name                       = local.appgateway_request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.appgateway_listener_name
    backend_address_pool_name  = local.appgateway_backend_pool_name
    backend_http_settings_name = local.appgateway_http_setting_name
  }

  depends_on = [ azurerm_key_vault_access_policy.appgateway_sp ]
}