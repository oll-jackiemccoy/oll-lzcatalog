output "tgw_id" {
  description = "Transit Gateway ID"
  value       = module.tgw.tgw_id
}
output "ingress_attachment" {
  value       = aws_ec2_transit_gateway_vpc_attachment.ingress.id
}
output "egress_attachment" {
  value       = aws_ec2_transit_gateway_vpc_attachment.egress.id
}
output "ingress_tgw_route_table" {
  value       = aws_ec2_transit_gateway_route_table.ingress.id
}
output "egress_tgw_route_table" {
  value       = aws_ec2_transit_gateway_route_table.egress.id
}
output "egress_private_route_table_ids" {
  description = "Route table IDs for private subnets (one per AZ)"
  value       = module.egress_vpc.private_route_table_ids
}
output "egress_public_route_table_ids" {
  description = "Route table IDs for private subnets (one per AZ)"
  value       = module.egress_vpc.public_route_table_ids
}
output "ingress_vpc_cidr" {
  value       = module.ingress_vpc.vpc_cidr
}
output "ingress_vpc_id" {
  value       = module.ingress_vpc.vpc_id
}
output "ingress_private_route_table_ids" {
  description = "Route table IDs for private subnets (one per AZ)"
  value       = module.ingress_vpc.private_route_table_ids
}
output "ingress_public_route_table_ids" {
  description = "Route table IDs for private subnets (one per AZ)"
  value       = module.ingress_vpc.public_route_table_ids
}
output "ingress_public_subnet_ids" {
  value       = module.ingress_vpc.public_subnet_ids
}