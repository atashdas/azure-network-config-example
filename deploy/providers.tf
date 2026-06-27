terraform {
  required_version = "> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.77"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = local.g_subscription_id
  tenant_id       = local.g_tenant_id
}
