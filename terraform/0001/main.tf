# Definición provider azurerm (Azure) y versión

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.13.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c9f11e84-e410-46cd-82xe-xxxxxxxxxxxx"
  client_id = "62p71c17-03q2-4234-9795-xxxxxxxxxxxx"
  client_secret = "rvFpTmn_3KCOtZv.jzoK9Ox3H-xxxxxxxx"
  tenant_id = "899789xd-202f-44b4-9583-xxxxxxxxxxxx"
}

# Creación de grupo de recursos

resource "azurerm_resource_group" "rg" {
    name = "lab_0001"
    location = var.location

    tags = {
        environment = "lab_0001"
    }
}

# Creación de cuenta de almacenamiento

resource "azurerm_storage_account" "stAccount" {
    name = "salab0001"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "lab_0001"
    }

}
