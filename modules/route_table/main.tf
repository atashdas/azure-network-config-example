locals {
  routes = merge(flatten([
    for rtKey, rtConfig in var.parameters : [
      for routeConfig in try(rtConfig.routes, []) : {
        (format("%s:%s", rtKey, routeConfig.name)) = {
          name                   = routeConfig.name
          address_prefix         = routeConfig.address_prefix
          next_hop_type          = routeConfig.next_hop_type
          next_hop_in_ip_address = try(routeConfig.next_hop_in_ip_address, null)
          route_table_name       = rtConfig.name
          resource_group_name    = rtConfig.resource_group_name
        }
      }
    ]
  ])...)

  nextHopIp_nonVirtualAppliance = merge(flatten([
    for key, rule in local.routes : {
      (key) = {}
    } if rule.next_hop_type != "VirtualAppliance" && try(rule.next_hop_in_ip_address, null) != null
  ])...)
}

check "nextHopIp_nonVirtualAppliance" {
  assert {
    condition     = length(keys(local.nextHopIp_nonVirtualAppliance)) == 0
    error_message = "nextHopIp_nonVirtualAppliance in: ${join(",", keys(local.nextHopIp_nonVirtualAppliance))}!"
  }
}

resource "azurerm_route_table" "this" {
  for_each = var.parameters

  name                          = each.value.name
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  bgp_route_propagation_enabled = try(each.value.bgp_route_propagation_enabled, true)

  tags = each.value.tags
}

resource "azurerm_route" "this" {
  for_each = local.routes

  name                   = each.value.name
  route_table_name       = each.value.route_table_name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
  resource_group_name    = each.value.resource_group_name

  depends_on = [ azurerm_route_table.this ]
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = var.association_parameters

  subnet_id      = each.value.subnet_id
  route_table_id = azurerm_route_table.this[each.value.route_table_key].id

  depends_on = [ azurerm_route_table.this, azurerm_route.this ]
}
