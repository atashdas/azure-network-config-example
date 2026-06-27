locals {
  subnets = merge(flatten([
    for vnetKey, vnetConfig in var.parameters : [
      for snetConfig in try(vnetConfig.subnets, {}) : {
        (format("%s:%s", vnetKey, snetConfig.name)) = {
          resource_group_name               = vnetConfig.resource_group_name
          name                              = snetConfig.name
          virtual_network_name              = vnetConfig.name
          address_prefixes                  = snetConfig.address_prefixes
          default_outbound_access_enabled   = snetConfig.default_outbound_access_enabled
          private_endpoint_network_policies = snetConfig.private_endpoint_network_policies
          service_endpoints                 = snetConfig.service_endpoints
        }
      }
    ]
  ])...)
}

resource "azurerm_virtual_network" "this" {
  for_each = var.parameters

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  virtual_network_name              = each.value.virtual_network_name
  address_prefixes                  = each.value.address_prefixes
  default_outbound_access_enabled   = each.value.default_outbound_access_enabled
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
  service_endpoints                 = each.value.service_endpoints

  depends_on = [ azurerm_virtual_network.this ]
}



