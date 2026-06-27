variable "parameters" {
  description = "Parameters for virtual network peerings to be created."
  type = map(object({
    name                                   = string
    resource_group_name                    = string
    virtual_network_name                   = string
    remote_virtual_network_id              = string
    allow_virtual_network_access           = optional(bool)
    allow_forwarded_traffic                = optional(bool)
    allow_gateway_transit                  = optional(bool)
    local_subnet_names                     = optional(list(string))
    only_ipv6_peering_enabled              = optional(bool)
    peer_complete_virtual_networks_enabled = optional(bool)
    remote_subnet_names                    = optional(list(string))
    use_remote_gateways                    = optional(bool)
  }))
}
