locals {
  rg_locks = merge(flatten([
    for rgKey, config in var.parameters : {
      (rgKey) = {
        name       = config.name
        lock_level = config.lock_level
      }
    } if !(try(config.lock_level, null) == null)
  ])...)
}

resource "azurerm_resource_group" "this" {
  for_each = var.parameters

  name     = each.value.name
  location = each.value.location
  tags     = try(each.value.tags, null)
}

resource "azurerm_management_lock" "this" {
  for_each = local.rg_locks

  name       = format("%s-lock", each.value.name)
  scope      = azurerm_resource_group.this[each.key].id
  lock_level = each.value.lock_level
  notes      = each.value.lock_level == null ? null : format("Resource Group %s is locked at %s level.", each.value.name, each.value.lock_level)
}

