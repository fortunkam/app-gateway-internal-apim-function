variable location {
    default="uksouth"
}

variable prefix {
    default="mfapim"
}

resource "random_id" "storage_name" {
  keepers = {
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}