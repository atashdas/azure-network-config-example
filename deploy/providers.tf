provider "azurerm" {
  features {}
  subscription_id = local.g_subscription_id
  tenant_id       = local.g_tenant_id
}
