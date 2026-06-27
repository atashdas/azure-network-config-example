# virtual_network_peering

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
| [azurerm_virtual_network_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for virtual network peerings to be created. | <pre>map(object({<br/>    name                                   = string<br/>    resource_group_name                    = string<br/>    virtual_network_name                   = string<br/>    remote_virtual_network_id              = string<br/>    allow_virtual_network_access           = optional(bool)<br/>    allow_forwarded_traffic                = optional(bool)<br/>    allow_gateway_transit                  = optional(bool)<br/>    local_subnet_names                     = optional(list(string))<br/>    only_ipv6_peering_enabled              = optional(bool)<br/>    peer_complete_virtual_networks_enabled = optional(bool)<br/>    remote_subnet_names                    = optional(list(string))<br/>    use_remote_gateways                    = optional(bool)<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
