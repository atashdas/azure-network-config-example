output "nsg_id_map" {
  description = "Map of NSG IDs"
  value = merge(flatten([
    for k, v in azurerm_network_security_group.this : { (k) = v.id }
  ])...)
}
