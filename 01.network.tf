resource "random_id" "name_unique" {
  byte_length = 4
}

resource "azurerm_resource_group" "main" {
  count = var.create_resource_group ? 1 : 0

  location = var.location
  name     = coalesce(var.resource_group_name,"-rg")
}

locals {
  resource_group = {
    name     = var.create_resource_group ? azurerm_resource_group.main[0].name : var.resource_group_name
    location = var.location
  }
}

resource "azurerm_virtual_network" "aks" {
  address_space       = [var.aks_vn_cidr]
  location            = local.resource_group.location
  name                = "${var.project_name}-vn"
  resource_group_name = local.resource_group.name
}

resource "azurerm_subnet" "aks-subnet" {
  address_prefixes                               = [var.aks_subnet_cidr]
  name                                           = "aks-sn"
  resource_group_name                            = local.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.aks.name
}

resource "azurerm_subnet" "gateway-subnet" {
  address_prefixes                               = [var.aks_gateway_cidr]
  name                                           = "ingress-appgateway-sn"
  resource_group_name                            = local.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.aks.name
}