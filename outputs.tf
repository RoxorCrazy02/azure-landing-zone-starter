# ─────────────────────────────────────────────
# Resource Group
# ─────────────────────────────────────────────

output "resource_group_name" {
  description = "Name of the main resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the main resource group"
  value       = azurerm_resource_group.main.id
}

# ─────────────────────────────────────────────
# Networking
# ─────────────────────────────────────────────

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = module.networking.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = module.networking.subnet_ids
}

# ─────────────────────────────────────────────
# Key Vault
# ─────────────────────────────────────────────

output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = module.keyvault.key_vault_id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.keyvault.key_vault_uri
}

# ─────────────────────────────────────────────
# State Storage
# ─────────────────────────────────────────────

output "tfstate_storage_account" {
  description = "Name of the storage account used for Terraform state"
  value       = azurerm_storage_account.tfstate.name
}
