locals {
  vnets = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for vnetKey, vnetConfig in try(netConfig.vnets, {}) : {
        (vnetKey) = {
          name                = vnetKey
          location            = lookup(vnetConfig, "location", try(netConfig.location, local.g_location))
          resource_group_name = lookup(vnetConfig, "resource_group", try(netConfig.resource_group, local.g_resource_group))
          address_space       = lookup(vnetConfig, "address_space", null)
          tags                = merge(lookup(vnetConfig, "tags", {}), try(netConfig.tags, {}), local.g_tags)
          subnets = merge(flatten([
            for snetKey, snetConfig in try(vnetConfig.subnets, {}) : {
              (format("%s:%s", vnetKey, snetKey)) = {
                name                              = snetKey
                address_prefixes                  = lookup(snetConfig, "address_prefixes", null)
                default_outbound_access_enabled   = lookup(snetConfig, "default_outbound_access_enabled", null)
                private_endpoint_network_policies = lookup(snetConfig, "private_endpoint_network_policies", null)
                service_endpoints                 = lookup(snetConfig, "service_endpoints", null)
              }
            }
          ])...)
        }
      }
    ]
  ])...)

  peerings = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for vnetKey, vnetConfig in try(netConfig.vnets, {}) : [
        for prngKey, prngConfig in try(vnetConfig.peerings, {}) : {
          (format("%s:%s", vnetKey, prngKey)) = {
            name                                   = prngKey
            resource_group_name                    = lookup(vnetConfig, "resource_group", try(netConfig.resource_group, local.g_resource_group))
            virtual_network_name                   = vnetKey
            remote_virtual_network_id              = module.vnet.vnet_id_map[vnetKey]
            allow_virtual_network_access           = lookup(prngConfig, "allow_virtual_network_access", try(local.g_peering_settings.allow_virtual_network_access, null))
            allow_forwarded_traffic                = lookup(prngConfig, "allow_virtual_network_access", try(local.g_peering_settings.allow_forwarded_traffic, null))
            allow_gateway_transit                  = lookup(prngConfig, "allow_gateway_transit", try(local.g_peering_settings.allow_gateway_transit, null))
            local_subnet_names                     = lookup(prngConfig, "local_subnet_names", try(local.g_peering_settings.local_subnet_names, null))
            only_ipv6_peering_enabled              = lookup(prngConfig, "only_ipv6_peering_enabled", try(local.g_peering_settings.only_ipv6_peering_enabled, null))
            peer_complete_virtual_networks_enabled = lookup(prngConfig, "peer_complete_virtual_networks_enabled", try(local.g_peering_settings.peer_complete_virtual_networks_enabled, null))
            remote_subnet_names                    = lookup(prngConfig, "remote_subnet_names", try(local.g_peering_settings.remote_subnet_names, null))
            use_remote_gateways                    = lookup(prngConfig, "use_remote_gateways", try(local.g_peering_settings.use_remote_gateways, null))
          }
        }
      ]
    ]
  ])...)

  nsgs = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for nsgKey, nsgConfig in try(netConfig.network_security_groups, {}) : {
        (format("%s:%s", netKey, nsgKey)) = {
          name                = nsgKey
          location            = lookup(nsgConfig, "location", try(netConfig.location, local.g_location))
          resource_group_name = lookup(nsgConfig, "resource_group", try(netConfig.resource_group, local.g_resource_group))
          tags                = merge(lookup(nsgConfig, "tags", {}), try(netConfig.tags, {}), local.g_tags)
          rules = merge(flatten([
            for ruleKey, ruleConfig in try(nsgConfig.rules, {}) : {
              (format("%s:%s:%s", netKey, nsgKey, ruleKey)) = {
                name                                       = ruleKey
                protocol                                   = ruleConfig.protocol
                description                                = try(ruleConfig.description, null)
                priority                                   = ruleConfig.priority
                direction                                  = ruleConfig.direction
                access                                     = ruleConfig.access
                source_port_ranges                         = ruleConfig.source_port_ranges
                destination_port_ranges                    = ruleConfig.destination_port_ranges
                source_address_prefix                      = try(ruleConfig.source_address_prefix, null)
                destination_address_prefix                 = try(ruleConfig.destination_address_prefix, null)
                source_address_prefixes                    = try(ruleConfig.source_address_prefixes, null)
                destination_address_prefixes               = try(ruleConfig.destination_address_prefixes, null)
                source_application_security_group_ids      = try(ruleConfig.source_application_security_group_ids, null)
                destination_application_security_group_ids = try(ruleConfig.destination_application_security_group_ids, null)
              }
            }
          ])...)
        }
      }
    ]
  ])...)
  nsg_assoc = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for nsgKey, nsgConfig in try(netConfig.network_security_groups, {}) : [
        for snetKey in try(nsgConfig.subnet_keys, []) : {
          (format("%s:%s:%s", netKey, nsgKey, snetKey)) = {
            subnet_id                  = module.vnet.subnet_id_map[snetKey]
            network_security_group_key = format("%s:%s", netKey, nsgKey)
          }
        }
      ]
    ]
  ])...)

  rts = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for rtKey, rtConfig in try(netConfig.route_tables, {}) : {
        (format("%s:%s", netKey, rtKey)) = {
          name                          = rtKey
          location                      = lookup(rtConfig, "location", try(netConfig.location, local.g_location))
          resource_group_name           = lookup(rtConfig, "resource_group", try(netConfig.resource_group, local.g_resource_group))
          tags                          = merge(lookup(rtConfig, "tags", {}), try(netConfig.tags, {}), local.g_tags)
          bgp_route_propagation_enabled = try(rtConfig.bgp_route_propagation_enabled, null)
          routes = merge(flatten([
            for routeKey, routeConfig in try(rtConfig.routes, {}) : {
              (format("%s:%s:%s", netKey, rtKey, routeKey)) = {
                name                   = routeKey
                address_prefix         = routeConfig.address_prefix
                next_hop_type          = routeConfig.next_hop_type
                next_hop_in_ip_address = try(routeConfig.next_hop_in_ip_address, null)
              }
            }
          ])...)
        }
      }
    ]
  ])...)
  rt_assoc = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      for rtKey, rtConfig in try(netConfig.route_tables, {}) : [
        for snetKey in try(rtConfig.subnet_keys, []) : {
          (format("%s:%s:%s", netKey, rtKey, snetKey)) = {
            subnet_id       = module.vnet.subnet_id_map[snetKey]
            route_table_key = format("%s:%s", netKey, rtKey)
          }
        }
      ]
    ]
  ])...)

  rgs = merge(flatten([
    for rgKey, rgConfig in try(local.config_data.cloud.resource_groups, {}) : {
      (format("%s:%s", try(rgConfig.location, local.g_location), rgKey)) = {
        name       = rgKey
        location   = try(rgConfig.location, local.g_location)
        lock_level = try(rgConfig.lock_level, null)
        tags       = merge(lookup(rgConfig, "tags", {}), local.g_tags)
      }
    } if try(rgConfig.location, null) != null && local.g_location != null
  ])...)
  net_rgs = merge(flatten([
    for netKey, netConfig in try(local.config_data.cloud.networks, {}) : [
      try(netConfig.resource_group, null) != null ? {
        (format("%s:%s", try(netConfig.location, local.g_location), netConfig.resource_group)) = {
          name     = netConfig.resource_group
          location = try(netConfig.location, local.g_location)
          tags     = merge(try(netConfig.tags, {}), local.g_tags)
        }
      } : null
    ] if try(netConfig.location, local.g_location) != null
  ])...)
  vnet_rgs = merge(flatten([
    for key, config in local.vnets : {
      (format("%s:%s", config.location, config.resource_group_name)) = {
        name     = config.resource_group_name
        location = config.location
        tags     = config.tags
      }
    } if config.location != null
  ])...)
  nsg_rgs = merge(flatten([
    for key, config in local.nsgs : {
      (format("%s:%s", config.location, config.resource_group_name)) = {
        name     = config.resource_group_name
        location = config.location
        tags     = config.tags
      }
    } if config.location != null
  ])...)
  rt_rgs = merge(flatten([
    for key, config in local.rts : {
      (format("%s:%s", config.location, config.resource_group_name)) = {
        name     = config.resource_group_name
        location = config.location
        tags     = config.tags
      }
    } if config.location != null
  ])...)
  g_rg = local.g_location != "" && local.g_resource_group == null ? null : {
    (format("%s:%s", local.g_location, local.g_resource_group)) = {
      name     = local.g_resource_group
      location = local.g_location
      tags     = local.g_tags
    }
  }
  all_rgs = merge(local.rgs, local.net_rgs, local.vnet_rgs, local.nsg_rgs, local.rt_rgs, local.g_rg)
}

module "rg" {
  source     = "../modules/resource_group"
  parameters = local.all_rgs
}

module "vnet" {
  source     = "../modules/virtual_network"
  parameters = local.vnets
  depends_on = [module.rg]
}

module "peering" {
  source     = "../modules/virtual_network_peering"
  parameters = local.peerings
  depends_on = [module.vnet]
}

module "rt" {
  source                 = "../modules/route_table"
  parameters             = local.rts
  association_parameters = local.rt_assoc
  depends_on             = [module.vnet]
}

module "nsg" {
  source                 = "../modules/network_security_group"
  parameters             = local.nsgs
  association_parameters = local.nsg_assoc
  depends_on             = [module.vnet]
}
