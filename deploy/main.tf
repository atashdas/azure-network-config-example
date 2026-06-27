locals {
  root_path = dirname(abspath(path.root))

  is_config_in_yaml = endswith(var.config_file, ".yaml")
  config_file_path  = format("%s/config/%s", local.root_path, var.config_file)
  config_data       = (fileexists(local.config_file_path) ? local.is_config_in_yaml ? yamldecode(file(local.config_file_path)) : jsondecode(file(local.config_file_path)) : {})

  g_location        = try(local.config_data.cloud.global.azure.location, "")
  g_tenant_id       = try(local.config_data.cloud.global.azure.tenant_id, "")
  g_subscription_id = try(local.config_data.cloud.global.azure.subscription_id, "")

  g_resource_group   = try(local.config_data.cloud.global.defaults.resource_group, null)
  g_peering_settings = try(local.config_data.cloud.global.defaults.peering, {})

  g_tags = { for k, v in try(local.config_data.cloud.global.tags, {}) : k => v }
}

check "no_desired_config_file" {
  assert {
    condition     = fileexists(local.config_file_path)
    error_message = "Desired Config file: ${local.config_file_path} is not available!"
  }
}

check "no_location" {
  assert {
    condition     = length(local.g_location) > 0
    error_message = "Azure location is missing in configuration."
  }
}

check "no_subscription_id" {
  assert {
    condition     = length(local.g_subscription_id) > 0
    error_message = "Azure subscription_id is missing in configuration."
  }
}

check "no_tenant_id" {
  assert {
    condition     = length(local.g_tenant_id) > 0
    error_message = "Azure tenant_id is missing in configuration."
  }
}
