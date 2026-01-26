# VPC (3-AZ) Module

This module provisions a **3-AZ VPC baseline** suitable for landing zone and application environments.

It creates a VPC with **three public subnets** and **three private subnets** (one per AZ), an Internet Gateway, and **one NAT Gateway per AZ** for private egress. Route tables are created per subnet tier/AZ and associated accordingly.

> Availability Zones are selected dynamically from the region using `aws_availability_zones` and the first three regional AZs are used.

---

## What This Module Creates

### Networking
- **1x VPC**
  - DNS support enabled
  - DNS hostnames enabled
- **1x Internet Gateway (IGW)** attached to the VPC

### Subnets (3 AZs)
- **3x Public subnets** (A/B/C)
  - `map_public_ip_on_launch = true`
- **3x Private subnets** (A/B/C)

### Egress (per AZ)
- **3x Elastic IPs** (one per NAT Gateway)
- **3x NAT Gateways** (one per AZ, placed in each public subnet)

### Routing
- **3x Public route tables** (A/B/C)
  - Default route `0.0.0.0/0` → **IGW**
  - Associated to public subnets
- **3x Private route tables** (A/B/C)
  - Default route `0.0.0.0/0` → **NAT Gateway** (same AZ)
  - Associated to private subnets

### Tagging
- All resources are tagged with `var.tags`
- Additional `Name` tags are applied per resource using `var.name_prefix`
- Subnets and route tables include a `Tier` tag (`public` / `private`)

---

## Inputs

All inputs are required unless otherwise noted.

| Name                   | Description                                  | Type            |
|------------------------|----------------------------------------------|-----------------|
| `region`               | AWS region to deploy into                    | `string`        |
| `name_prefix`          | Prefix used for naming resources             | `string`        |
| `tags`                 | Common tags applied to all resources         | `map(string)`   |
| `vpc_cidr`             | CIDR block for the VPC                       | `string`        |
| `public_subnet_cidrs`  | List of **3** public subnet CIDRs (A/B/C)    | `list(string)`  |
| `private_subnet_cidrs` | List of **3** private subnet CIDRs (A/B/C)   | `list(string)`  |

> Note: This module expects **exactly 3** public CIDRs and **exactly 3** private CIDRs.

---
