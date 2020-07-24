locals {
    rg_name          = "${var.prefix}-rg"
    appplan_name     = "${var.prefix}-appplan"
    function_name    = "${var.prefix}-function"
    apim_name    = "${var.prefix}-apim"

    vnet_name        = "${var.prefix}-vnet"
    function_subnet  = "function"
    apim_subnet      = "apim"
    vnet_iprange = "10.0.0.0/16"
    function_subnet_iprange = "10.0.0.0/24"
    apim_subnet_iprange = "10.0.1.0/24"

    apim_publisher_name = "Bob McLeek"
    apim_publisher_email = "Bob@memoryleek.co.uk"
}