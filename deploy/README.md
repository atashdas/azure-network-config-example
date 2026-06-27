# deploy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.77 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ../modules/network_security_group | n/a |
| <a name="module_peering"></a> [peering](#module\_peering) | ../modules/virtual_network_peering | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../modules/resource_group | n/a |
| <a name="module_rt"></a> [rt](#module\_rt) | ../modules/route_table | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ../modules/virtual_network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_config_file"></a> [config\_file](#input\_config\_file) | The config filename. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
