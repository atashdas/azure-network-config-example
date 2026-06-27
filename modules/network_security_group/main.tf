locals {
  nsgRules = merge(flatten([
    for nsgKey, nsgConfig in var.parameters : [
      for ruleConfig in try(nsgConfig.rules, []) : {
        (format("%s:%s", nsgKey, ruleConfig.name)) = {
          name                                       = ruleConfig.name
          protocol                                   = ruleConfig.protocol
          description                                = try(ruleConfig.description, null)
          priority                                   = ruleConfig.priority
          direction                                  = ruleConfig.direction
          access                                     = ruleConfig.access
          security_group_name                        = nsgConfig.name
          resource_group_name                        = nsgConfig.resource_group_name
          source_port_ranges                         = ruleConfig.source_port_ranges
          destination_port_ranges                    = ruleConfig.destination_port_ranges
          source_address_prefix                      = try(ruleConfig.source_address_prefix, null)
          destination_address_prefix                 = try(ruleConfig.destination_address_prefix, null)
          source_address_prefixes                    = try(ruleConfig.source_address_prefixes, null)
          destination_address_prefixes               = try(ruleConfig.destination_address_prefixes, null)
          source_application_security_group_ids      = try(ruleConfig.source_application_security_group_ids, null)
          destination_application_security_group_ids = try(ruleConfig.destination_application_security_group_ids, null)
        }
      }
    ]
  ])...)

  null_source_address_prefix = merge(flatten([
    for key, rule in local.nsgRules : {
      (key) = {}
    } if rule.source_address_prefix == null && rule.source_address_prefixes == null
  ])...)

  null_destination_address_prefix = merge(flatten([
    for key, rule in local.nsgRules : {
      (key) = {}
    } if rule.destination_address_prefix == null && rule.destination_address_prefixes == null
  ])...)
}

check "null_source_address_prefix" {
  assert {
    condition     = length(keys(local.null_source_address_prefix)) == 0
    error_message = "null_source_address_prefix in: ${join(",", keys(local.null_source_address_prefix))}!"
  }
}

check "null_destination_address_prefix" {
  assert {
    condition     = length(keys(local.null_destination_address_prefix)) == 0
    error_message = "null_destination_address_prefix in: ${join(",", keys(local.null_destination_address_prefix))}!"
  }
}

resource "azurerm_network_security_group" "this" {
  for_each = var.parameters

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tags = each.value.tags
}
resource "azurerm_network_security_rule" "this" {
  for_each = local.nsgRules

  name                                       = each.value.name
  priority                                   = each.value.priority
  direction                                  = each.value.direction
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_ranges                         = each.value.source_port_ranges
  destination_port_ranges                    = each.value.destination_port_ranges
  source_address_prefix                      = each.value.source_address_prefix
  destination_address_prefix                 = each.value.destination_address_prefix
  source_address_prefixes                    = each.value.source_address_prefixes
  destination_address_prefixes               = each.value.destination_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  resource_group_name                        = each.value.resource_group_name
  network_security_group_name                = each.value.security_group_name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.association_parameters

  subnet_id                 = each.value.subnet_id
  network_security_group_id = azurerm_network_security_group.this[each.value.network_security_group_key].id
}