# virtual_network

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
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for virtual networks to be created. | <pre>map(object({<br/>    name                = string<br/>    location            = string<br/>    resource_group_name = string<br/>    address_space       = optional(list(string))<br/>    subnets = optional(map(object({<br/>      name                              = string<br/>      address_prefixes                  = optional(list(string))<br/>      default_outbound_access_enabled   = optional(bool)<br/>      private_endpoint_network_policies = optional(string)<br/>      service_endpoints                 = optional(list(string))<br/>    })))<br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_subnet_id_map"></a> [subnet\_id\_map](#output\_subnet\_id\_map) | Map of subnet IDs |
| <a name="output_vnet_id_map"></a> [vnet\_id\_map](#output\_vnet\_id\_map) | Map of virtual network IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
