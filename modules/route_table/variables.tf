variable "parameters" {
  description = "Parameters for route tables to be created."
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    bgp_route_propagation_enabled = optional(bool)
    routes = optional(map(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })))
    tags = optional(map(string))
  }))
}

variable "association_parameters" {
  description = "Parameters for  route table to subnet associations to be created."
  type = map(object({
    subnet_id       = string
    route_table_key = string
  }))
}
