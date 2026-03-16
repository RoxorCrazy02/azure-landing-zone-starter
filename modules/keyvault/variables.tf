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

variable "sku" {
  description = "Key Vault SKU (standard or premium)"
  type        = string
  default     = "standard"
}

variable "admin_object_id" {
  description = "Azure AD Object ID granted Key Vault admin access"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
