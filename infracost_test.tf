provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_linux_virtual_machine" "infracost_test_instance" {
  location            = "eastus"
  name                = "infracost-test-instance"
  resource_group_name = "test"
  admin_username      = "testuser"
  admin_password      = "Testpa5s"

  size = "Standard_F16s" # <<<<<<<<<< Try changing this to Standard_F16s_v2 to compare the costs

  tags = {
    Name        = "infracost-test-instance"
    Environment = "production"
    Service     = "web-app"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface_ids = [
    "/subscriptions/123/resourceGroups/testrg/providers/Microsoft.Network/networkInterfaces/testnic",
  ]

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04-LTS"
    version = "latest"
  }
}

resource "azurerm_service_plan" "infracost_test_plan" {
  location            = "eastus"
  name                = "infracost-test-plan"
  resource_group_name = "test_resource_group"
  os_type             = "Windows"

  sku_name     = "P1v2"
  worker_count = 4 # <<<<<<<<<< Try changing this to 8 to compare the costs

  tags = {
    Name        = "infracost-test-plan"
    Environment = "Prod"
    Service     = "web-app"
  }
}

resource "azurerm_linux_function_app" "infracost_test_function" {
  location                   = "eastus"
  name                       = "infracost-test-function"
  resource_group_name        = "test"
  service_plan_id            = "/subscriptions/123/resourceGroups/testrg/providers/Microsoft.Web/serverFarms/serverFarmValue"
  storage_account_name       = "test"
  storage_account_access_key = "test"
  site_config {}

  tags = {
    Name        = "infracost-test-function"
    Environment = "Prod"
  }
}
