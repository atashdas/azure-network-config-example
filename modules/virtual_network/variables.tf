variable "parameters" {
  description = "Parameters for route tables to be created."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = optional(list(string))
    dns_servers         = optional(list(string))
    subnets = optional(map(object({
      name                              = string
      address_prefixes                  = optional(list(string))
      default_outbound_access_enabled   = optional(bool)
      private_endpoint_network_policies = optional(string)
      service_endpoints                 = optional(list(string))
    })))
    tags = optional(map(string))
  }))
}

# variable "route_table_id_map" {
#   description = "map of route table IDs"
#   type        = map(string)
# }

# variable "network_security_group_id_map" {
#   description = "map of network security group IDs"
#   type        = map(string)
# }