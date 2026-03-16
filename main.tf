# ─────────────────────────────────────────────
# Resource Group
# ─────────────────────────────────────────────

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.tags
}

# ─────────────────────────────────────────────
# Remote State Storage
# ─────────────────────────────────────────────

resource "azurerm_storage_account" "tfstate" {
  name                     = "st${var.project_name}tfstate"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }

  allow_nested_items_to_be_public = false

  tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# ─────────────────────────────────────────────
# Networking module
# ─────────────────────────────────────────────

module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  environment        = var.environment
  location           = var.location
  resource_group     = azurerm_resource_group.main.name
  vnet_address_space = var.vnet_address_space
  subnet_prefixes    = var.subnet_prefixes
  tags               = local.tags
}

# ─────────────────────────────────────────────
# Key Vault module
# ─────────────────────────────────────────────

module "keyvault" {
  source = "./modules/keyvault"

  project_name       = var.project_name
  environment        = var.environment
  location           = var.location
  resource_group     = azurerm_resource_group.main.name
  sku                = var.kv_sku
  admin_object_id    = var.kv_admin_object_id
  tags               = local.tags
}

# ─────────────────────────────────────────────
# Locals
# ─────────────────────────────────────────────

locals {
  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
    owner       = var.owner
  }
}
