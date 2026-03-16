# ─────────────────────────────────────────────
# Global
# ─────────────────────────────────────────────

variable "subscription_id" {
  description = "Azure Subscription ID where resources will be deployed"
  type        = string
}

variable "environment" {
  description = "Environment name — used in resource names and tags (dev / staging / prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Short project identifier — used as prefix in all resource names"
  type        = string

  validation {
    condition     = length(var.project_name) <= 12 && can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must be lowercase alphanumeric with hyphens, max 12 characters."
  }
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "westeurope"
}

variable "owner" {
  description = "Team or person responsible for this infrastructure"
  type        = string
  default     = "cloud-team"
}

# ─────────────────────────────────────────────
# Networking
# ─────────────────────────────────────────────

variable "vnet_address_space" {
  description = "CIDR block for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "CIDR blocks for each subnet"
  type = object({
    app  = string
    data = string
    mgmt = string
  })
  default = {
    app  = "10.0.1.0/24"
    data = "10.0.2.0/24"
    mgmt = "10.0.3.0/24"
  }
}

# ─────────────────────────────────────────────
# Key Vault
# ─────────────────────────────────────────────

variable "kv_sku" {
  description = "Key Vault SKU (standard or premium)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.kv_sku)
    error_message = "kv_sku must be either standard or premium."
  }
}

variable "kv_admin_object_id" {
  description = "Azure AD Object ID of the user or service principal granted Key Vault admin access"
  type        = string
}
