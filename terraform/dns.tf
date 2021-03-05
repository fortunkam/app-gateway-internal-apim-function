data "azurerm_dns_zone" "dns" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
}

resource "azurerm_dns_a_record" "api" {
  name                = var.api_dns_a_record_name
  zone_name           = data.azurerm_dns_zone.dns.name
  resource_group_name = var.dns_resource_group_name
  ttl                 = 120
  records             = [azurerm_public_ip.gateway.ip_address]
}

resource "azurerm_dns_a_record" "devportal" {
  name                = var.devportal_dns_a_record_name
  zone_name           = data.azurerm_dns_zone.dns.name
  resource_group_name = var.dns_resource_group_name
  ttl                 = 120
  records             = [azurerm_public_ip.gateway.ip_address]
}