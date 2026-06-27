output "vnet_id_map" {
  description = "Map of virtual network IDs"
  value = merge(flatten([
    for k, v in azurerm_virtual_network.this : {(k) = v.id}
  ])...)
}

output "subnet_id_map" {
  description = "Map of subnet IDs"
  value = merge(flatten([
    for k, v in azurerm_subnet.this : {(k) = v.id}
  ])...)
}