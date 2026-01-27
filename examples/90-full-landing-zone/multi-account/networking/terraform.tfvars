tgw_name = "main-tgw"
description = "Main TGW"
amazon_side_asn = 64512
auto_accept_shared_attachments = "disable"
default_route_table_association = "enable"
default_route_table_propagation = "enable"
dns_support = "enable"
vpn_ecmp_support = "enable"
tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}
share_name            = "main-tgw-share"
principal = "arn:aws:organizations::437670317305:organization/o-w5t4cy1z8m"