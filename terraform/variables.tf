variable location {
  default = "uksouth"
}

variable prefix {
  default = "mfa"
}

variable email_address {
}

variable cert_client_id {
}

variable cert_client_secret {
}

variable cert_common_name {
}

variable dns_resource_group_name {
}

variable dns_zone_name {
}

variable api_dns_a_record_name {
}

variable devportal_dns_a_record_name {
}

resource "random_id" "storage_name" {
  keepers = {
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}