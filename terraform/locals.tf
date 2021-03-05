locals {
  rg_name       = "${var.prefix}-rg"
  appplan_name  = "${var.prefix}-appplan"
  function_name = "${var.prefix}-function"
  apim_internal_name     = "${var.prefix}-apim-internal"
  apim_external_name     = "${var.prefix}-apim-external"

  vnet_name                 = "${var.prefix}-vnet"
  function_subnet           = "function"
  apim_internal_subnet               = "apim-internal"
  apim_external_subnet               = "apim-external"
  appgateway_subnet         = "AppGateway"
  appgateway_subnet_iprange = "10.0.2.0/24"
  vnet_iprange              = "10.0.0.0/16"
  function_subnet_iprange   = "10.0.0.0/24"
  apim_internal_subnet_iprange       = "10.0.1.0/24"
  apim_external_subnet_iprange       = "10.0.3.0/24"

  apim_publisher_name  = "Bob McLeek"
  apim_publisher_email = "Bob@memoryleek.co.uk"

  appgateway_publicip                       = "${var.prefix}-appgateway-ip"
  appgateway                                = "${var.prefix}-appgateway"
  appgateway_probe                          = "${var.prefix}-appgateway-probe"
  appgateway_private_ip_address             = "10.0.2.5"
  appgateway_frontend_ip_configuration_name = "${var.prefix}-appgateway-fe-ip"
  appgateway_frontend_port_name             = "${var.prefix}-appgateway-fe-port"
  appgateway_listener_name                  = "${var.prefix}-appgateway-listener"
  appgateway_http_setting_name              = "${var.prefix}-appgateway-http-setting"
  appgateway_backend_pool_name              = "${var.prefix}-appgateway-backend-pool"
  appgateway_ipconfig_name                  = "${var.prefix}-appgateway-ipconfig"
  appgateway_request_routing_rule_name      = "${var.prefix}-appgateway-rule"

  keyvault_name = "${var.prefix}kv"

  apim_internal_sp_app_name = "${var.prefix}-internal-app"
  apim_external_sp_app_name = "${var.prefix}-external-app"

  appgateway_sp_app_name = "${var.prefix}-appgateway-app"

  api_dns_name = "${var.api_dns_a_record_name}.${var.dns_zone_name}"
  devportal_dns_name = "${var.devportal_dns_a_record_name}.${var.dns_zone_name}"

}

data "azurerm_client_config" "current" {}