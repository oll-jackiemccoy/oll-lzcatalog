# VPC Public (3-AZ) Module

This module provisions a **3-AZ VPC public networking baseline** suitable for landing zone foundations and simple internet-facing workloads.

It creates a VPC with **three public subnets** (one per Availability Zone), an Internet Gateway, and a shared public route table with a default route to the internet.

> Availability Zones are selected dynamically from the region using `aws_availability_zones`, and the first three **regional** AZs are used.

---

## What This Module Creates

### Networking

* **1x VPC**

  * DNS support enabled
  * DNS hostnames enabled
* **1x Internet Gateway (IGW)** attached to the VPC

### Subnets (3 AZs)

* **3x Public subnets** (A/B/C)

  * One subnet per AZ
  * `map_public_ip_on_launch = true`
  * Tagged with `Tier = public`

### Routing

* **1x Public route table**

  * Default route `0.0.0.0/0` → **Internet Gateway**
  * Associated to the public subnet tier

### Tagging

* All resources are tagged with `var.tags`
* Additional `Name` tags are applied per resource using `var.name_prefix`
* Public subnets and the route table include a `Tier = public` tag

---

## Inputs

All inputs are required unless otherwise noted.

| Name                  | Description                               | Type           |
| --------------------- | ----------------------------------------- | -------------- |
| `name_prefix`         | Prefix used for naming resources          | `string`       |
| `tags`                | Common tags applied to all resources      | `map(string)`  |
| `vpc_cidr`            | CIDR block for the VPC                    | `string`       |
| `public_subnet_cidrs` | List of **3** public subnet CIDRs (A/B/C) | `list(string)` |

> Note: This module expects **exactly 3** public subnet CIDRs.

---

## Notes

* This module provides **public networking only**
* No private subnets, NAT Gateways, or per-AZ route tables are created
* Intended as a **foundational or example module**, or as a base to extend with additional networking tiers
