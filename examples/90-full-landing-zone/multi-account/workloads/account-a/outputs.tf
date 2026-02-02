output "spoke_vpc_id" {
  description = "Spoke VPC ID"
  value       = module.spoke_vpc_a.vpc_id
}
output "spoke_vpc_cidr" {
  description = "Spoke VPC ID"
  value       = module.spoke_vpc_a.vpc_cidr
}
output "spoke_private_subnet_ids" {
  description = "Spoke private subnet IDs"
  value       = module.spoke_vpc_a.private_subnet_ids
}

 output "spoke_tgw_attachment_id" {
 description = "TGW attachment ID for this spoke"
  value       = aws_ec2_transit_gateway_vpc_attachment.spoke_a.id
}

output "shared_tgw_id" {
 description = "Discovered shared TGW ID used for attachment"
 value       = local.shared_tgw_id
}
output "private_route_table_ids" {
  description = "Route table IDs for private subnets (one per AZ)"
  value       = module.spoke_vpc_a.private_route_table_ids
}