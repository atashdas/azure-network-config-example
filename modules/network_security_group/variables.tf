variable "parameters" {
  description = "Parameters for network security groups to be created."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    rules = optional(map(object({
      name                                       = string
      protocol                                   = string
      description                                = optional(string)
      priority                                   = number
      direction                                  = string
      access                                     = string
      source_port_ranges                         = list(string)
      destination_port_ranges                    = list(string)
      source_address_prefix                      = optional(string)
      destination_address_prefix                 = optional(string)
      source_address_prefixes                    = optional(list(string))
      destination_address_prefixes               = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
    })))
    tags = optional(map(string))
  }))
}

variable "association_parameters" {
  description = "Parameters for network security group to subnet associations to be created."
  type = map(object({
    subnet_id = string
    network_security_group_key = string
  }))
}