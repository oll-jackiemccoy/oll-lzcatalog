tgw_name = "main-tgw"
description = "Main TGW"
amazon_side_asn = 64512
auto_accept_shared_attachments = "disable"
default_route_table_association = "disable"
default_route_table_propagation = "disable"
dns_support = "enable"
vpn_ecmp_support = "enable"
tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}
share_name            = "main-tgw-share"
principal = "arn:aws:organizations::437670317305:organization/o-w5t4cy1z8m"

region = "us-east-1"
name_prefix = "ingress"
vpc_cidr = "10.22.0.0/20"
public_subnet_cidrs  = ["10.22.0.0/24", "10.22.1.0/24", "10.22.2.0/24"]
private_subnet_cidrs = ["10.22.4.0/23", "10.22.6.0/23", "10.22.8.0/23"]