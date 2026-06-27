# network_security_group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.77 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.77 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_association_parameters"></a> [association\_parameters](#input\_association\_parameters) | Parameters for network security group to subnet associations to be created. | <pre>map(object({<br/>    subnet_id                  = string<br/>    network_security_group_key = string<br/>  }))</pre> | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for network security groups to be created. | <pre>map(object({<br/>    name                = string<br/>    location            = string<br/>    resource_group_name = string<br/>    rules = optional(map(object({<br/>      name                                       = string<br/>      protocol                                   = string<br/>      description                                = optional(string)<br/>      priority                                   = number<br/>      direction                                  = string<br/>      access                                     = string<br/>      source_port_ranges                         = list(string)<br/>      destination_port_ranges                    = list(string)<br/>      source_address_prefix                      = optional(string)<br/>      destination_address_prefix                 = optional(string)<br/>      source_address_prefixes                    = optional(list(string))<br/>      destination_address_prefixes               = optional(list(string))<br/>      source_application_security_group_ids      = optional(list(string))<br/>      destination_application_security_group_ids = optional(list(string))<br/>    })))<br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_nsg_id_map"></a> [nsg\_id\_map](#output\_nsg\_id\_map) | Map of NSG IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
