tgw_name = "main-tgw"
description = "Main TGW"
amazon_side_asn = 64512
auto_accept_shared_attachments = "enable"
default_route_table_association = "disable"
default_route_table_propagation = "disable"
dns_support = "enable"
vpn_ecmp_support = "enable"

share_name            = "main-tgw-share"
principal = "arn:aws:organizations::437670317305:organization/o-w5t4cy1z8m"

region = "us-east-1"
ingress_prefix = "ingress"
ingress_vpc_cidr = "10.22.0.0/20"
ingress_public_subnet_cidrs  = ["10.22.0.0/24", "10.22.1.0/24", "10.22.2.0/24"]
ingress_private_subnet_cidrs = ["10.22.4.0/23", "10.22.6.0/23", "10.22.8.0/23"]
egress_vpc_cidr = "10.23.0.0/19"
egress_public_subnet_cidrs  = ["10.23.12.0/23", "10.23.14.0/23", "10.23.16.0/23"]
egress_private_subnet_cidrs = ["10.23.0.0/22", "10.23.4.0/22", "10.23.8.0/22"]
egress_prefix = "egress"
spokes_prefix = "spokes"

tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}