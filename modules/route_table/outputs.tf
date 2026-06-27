output "rt_id_map" {
  description = "Map of route table IDs"
  value = merge(flatten([
    for k, v in azurerm_route_table.this : { (k) = v.id }
  ])...)
}

# output "next_hop_ip_non_virtual_appliance" {
#   value = local.next_hop_ip_non_virtual_appliance
# }
# output "routes" {
#   value = local.routes
# }
