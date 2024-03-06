terraform {
  required_version = ">=1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.51, < 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
    grafana = {
      source = "grafana/grafana"
      version = "2.8.0"
    }
    azapi = {
      source  = "Azure/azapi"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }  
  }
  subscription_id   = "${var.PROJECT_SUBSCRIPTION_ID}"
  tenant_id         = "${var.PROJECT_TENANT_ID}"
  client_id         = "${var.PROJECT_CLIENT_ID}"
  client_secret     = "${var.PROJECT_CLIENT_SECRET}"
}

provider "random" {}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.mycontext
}