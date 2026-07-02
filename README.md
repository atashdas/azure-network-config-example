Creates an azure hub-spoke network with resource groups, vnets, subnets, route tables and network security groups per configuration in a YAML or JSON configuration file. This implementation demonstrates a **configuration-first** approach to Azure network provisioning where a YAML or JSON configuration defines **what** needs to be deployed, and a generic Terraform module describes **how** this is deployed.

This approach makes Azure network provisioning accessible to network engineers who understand topology but not Terraform syntax, integrates naturally with change management and GitOps practices, and scales from a simple hub-with-one-spoke to a complex multi-region, multi-hub enterprise network. The configuration file becomes a machine-readable network architecture document.

The repository follows the configuration-first pattern:
```
azure-network-config-example/
├── config/             # Network topology configuration — the network engineer's interface
├── deploy/             # Terraform entry point
├── modules/            # Reusable Terraform modules for Azure network resources
├── run.sh              # Execution wrapper
└── .pre-commit-config.yaml
```
The modules directory encapsulates the Azure-specific implementation of each network concept. The config directory is where the network topology is expressed in architecture terms.

The document schema defines  `global`, `resource_groups` and `networks` elements at the root level. Azure specifics, default values and common tags are defined under the global section, resource groups and associated locks are listed next, and network resources are detailed under the final element (note resource groups mentioned elsewhere but not listed under `resource_groups` element are also created at the default location). 

The `networks` element lists groups of related network objects (route tables, NSGs and vNets) together. The vNets details the virtual networks and their subnets and any network peerings to be created. Thus the hub and spoke network definitions within this schema becomes detailing the hub and individual spoke groups of network objects as appropriate.

This configuration reads as a network architecture document. A network engineer can review it and immediately understand the topology: hub location, spoke layouts, subnet assignments, routing, and security rules. The schema maps to networking concepts — not to Azure resource types — making it accessible to the network team without Terraform expertise.
