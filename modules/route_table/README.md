# route_table

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
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_association_parameters"></a> [association\_parameters](#input\_association\_parameters) | Parameters for  route table to subnet associations to be created. | <pre>map(object({<br/>    subnet_id       = string<br/>    route_table_key = string<br/>  }))</pre> | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for route tables to be created. | <pre>map(object({<br/>    name                          = string<br/>    location                      = string<br/>    resource_group_name           = string<br/>    bgp_route_propagation_enabled = optional(bool)<br/>    routes = optional(map(object({<br/>      name                   = string<br/>      address_prefix         = string<br/>      next_hop_type          = string<br/>      next_hop_in_ip_address = optional(string)<br/>    })))<br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_rt_id_map"></a> [rt\_id\_map](#output\_rt\_id\_map) | Map of route table IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
