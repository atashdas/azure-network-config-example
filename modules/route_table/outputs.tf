output "rt_id_map" {
  description = "Map of route table IDs"
  value = merge(flatten([
    for k, v in azurerm_route_table.this : { (k) = v.id }
  ])...)
}

output "nextHopIp_nonVirtualAppliance" {
  value = local.nextHopIp_nonVirtualAppliance
}
output "routes" {
  value = local.routes
}