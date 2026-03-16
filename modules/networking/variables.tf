variable "project_name" {
  description = "Short project identifier"
  type        = string
}

variable "environment" {
  description = "Environment name (dev / staging / prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group" {
  description = "Name of the parent resource group"
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR block for the Virtual Network"
  type        = string
}

variable "subnet_prefixes" {
  description = "CIDR blocks for each subnet"
  type = object({
    app  = string
    data = string
    mgmt = string
  })
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
