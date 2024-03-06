resource "random_string" "acr_suffix" {
  length  = 8
  numeric = true
  special = false
  upper   = false
}

resource "azurerm_container_registry" "acr" {
  location            = local.resource_group.location
  name                = "${var.project_name}reg${random_string.acr_suffix.result}"
  resource_group_name = local.resource_group.name
  sku                 = "Premium"
  admin_enabled       = true
  retention_policy {
    days    = 7
    enabled = true
  }
}

data "azurerm_subscription" "current" {
}

module "aks" {
  source                        = "Azure/aks/azurerm"
  version                       = "7.5.0"
  prefix                        = "${var.project_name}"
  resource_group_name           = local.resource_group.name
  kubernetes_version            = "1.28" # don't specify the patch version!
  automatic_channel_upgrade     = "patch"
  identity_type                 = "SystemAssigned"
  vnet_subnet_id                = azurerm_subnet.aks-subnet.id
  network_plugin                = "azure"
  network_policy                = "azure"
  os_disk_size_gb               = 60
  sku_tier                      = "Standard"
  rbac_aad                      = false
  temporary_name_for_rotation   = "nodepooltemp"
  agents_max_pods               = 50
  enable_auto_scaling           = var.aks_enable_auto_scaling
  agents_count                  = var.aks_agents_count
  agents_min_count              = var.aks_agents_min_count
  agents_max_count              = var.aks_agents_max_count
  agents_size                   = var.aks_agents_size
  ingress_application_gateway_enabled = true
  ingress_application_gateway_name = "${var.project_name}-ingress-appgateway"
  ingress_application_gateway_subnet_id = azurerm_subnet.gateway-subnet.id
  attached_acr_id_map = { 
    acr = azurerm_container_registry.acr.id 
  }
  monitor_metrics = {
    annotations_allowed = null
    labels_allowed      = null
  }
  depends_on = [ azurerm_container_registry.acr,azurerm_resource_group.main ]
}