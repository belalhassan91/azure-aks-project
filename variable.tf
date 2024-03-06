####################
# Service Principal
####################
variable "PROJECT_CLIENT_ID" {
  type    = string
  default = null
}
variable "PROJECT_SUBSCRIPTION_ID" {
  type    = string
  default = null
}
variable "PROJECT_TENANT_ID" {
  type    = string
  default = null
}
variable "PROJECT_CLIENT_SECRET" {
  type    = string
  default = null
}
####################
# Global Variable
####################
variable "create_resource_group" {
  type     = bool
  default  = true
  nullable = false
}
variable "location" {
  default = "uaenorth"
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "project_name" {
  type    = string
  default = null
}
####################
# Virtual Network variabe
####################

variable "aks_vn_cidr" {
  type    = string
  default = "10.52.0.0/16"
}

variable "aks_subnet_cidr" {
  type    = string
  default = "10.52.0.0/24"
}

variable "aks_gateway_cidr" {
  type    = string
  default = "10.52.1.0/24"
}

####################
# AKS variabe
####################
variable "cluster_name" {
  type    = string
  default = null
}

variable "kubernetes_version" {
  type    = string
  default = "1.28"
}

variable "os_disk_size_gb" {
  type    = number
  default = 60
}

variable "agents_max_pods" {
  type    = number
  default = 50
}

variable "aks_enable_auto_scaling" {
  type    = bool
  default = null
}

variable "aks_agents_count" {
  type    = number
  default = null
}

variable "aks_agents_min_count" {
  type    = number
  default = null
}

variable "aks_agents_max_count" {
  type    = number
  default = null
}

variable "aks_agents_size" {
  type    = string
  default = null
}

###################
variable "mycontext" {
  type    = string
  default = null
}