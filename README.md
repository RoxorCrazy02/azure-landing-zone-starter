# azure-landing-zone-starter

A minimal but production-ready Azure Landing Zone built with Terraform.  
Designed as a clean, opinionated starting point for cloud teams adopting Infrastructure as Code on Azure.

---

## What this deploys

| Resource | Purpose |
|---|---|
| Resource Group | Logical container for all resources |
| Virtual Network + Subnets | Segmented network (app / data / mgmt) |
| Storage Account | Remote backend for Terraform state |
| Key Vault | Centralized secrets and key management |

---

## Project structure

```
azure-landing-zone-starter/
├── README.md
├── main.tf                   # Root module — orchestrates all modules
├── variables.tf              # Input variable declarations
├── outputs.tf                # Exposed output values
├── terraform.tfvars.example  # Example variable values (safe to commit)
├── providers.tf              # Azure provider + backend configuration
└── modules/
    ├── networking/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── keyvault/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.50
- An active Azure subscription
- Contributor role on the target subscription

---

## Quick start

### 1. Authenticate to Azure

```bash
az login
az account set --subscription "<your-subscription-id>"
```

### 2. Create the remote state storage (one-time setup)

```bash
az group create --name rg-tfstate --location westeurope
az storage account create \
  --name stterraformstate \
  --resource-group rg-tfstate \
  --sku Standard_LRS \
  --allow-blob-public-access false
az storage container create \
  --name tfstate \
  --account-name stterraformstate
```

### 3. Configure your variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### 4. Deploy

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## Input variables

| Name | Type | Default | Description |
|---|---|---|---|
| `environment` | string | `dev` | Environment name (dev / staging / prod) |
| `location` | string | `westeurope` | Azure region |
| `project_name` | string | — | Short project identifier |
| `vnet_address_space` | string | `10.0.0.0/16` | VNet CIDR block |
| `subscription_id` | string | — | Target Azure subscription ID |

---

## Tagging strategy

All resources are tagged consistently:

```hcl
tags = {
  environment = var.environment
  project     = var.project_name
  managed_by  = "terraform"
  owner       = "cloud-team"
}
```

---

## Security considerations

- Terraform state is stored remotely in Azure Blob Storage with versioning
- Key Vault has soft-delete and purge protection enabled
- No public blob access on the state storage account
- `terraform.tfvars` is excluded via `.gitignore` — never commit secrets

---

## Author

**RoxorCrazy02** — Senior Cloud Architect  

---

## License
MIT