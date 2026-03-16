# ─────────────────────────────────────────────────────────────────
# Copy this file to terraform.tfvars and fill in your values.
# terraform.tfvars is excluded from git — never commit real values.
# ─────────────────────────────────────────────────────────────────

subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

project_name = "myproject"
environment  = "dev"
location     = "westeurope"
owner        = "cloud-team"

# Networking
vnet_address_space = "10.0.0.0/16"

subnet_prefixes = {
  app  = "10.0.1.0/24"
  data = "10.0.2.0/24"
  mgmt = "10.0.3.0/24"
}

# Key Vault
kv_sku             = "standard"
kv_admin_object_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # az ad signed-in-user show --query id -o tsv
