output "vpc_id" {
  value = aws_vpc.ingress_vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.ingress_vpc.cidr_block
}
output "azs_used" {
  value       = local.az_names
}
output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}
output "private_subnet_id_a" { value = aws_subnet.privatesubnet_a.id}
output "private_subnet_id_b" { value = aws_subnet.privatesubnet_b.id}
output "private_subnet_id_c" { value = aws_subnet.privatesubnet_c.id}
output "public_subnet_id_a" { value = aws_subnet.publicsubnet_a.id}
output "public_subnet_id_b" { value = aws_subnet.publicsubnet_b.id}
output "public_subnet_id_c" { value = aws_subnet.publicsubnet_c.id}

output "public_subnet_ids" {
  description = "All private subnet IDs as a list"
  value = [
    aws_subnet.publicsubnet_a.id,
    aws_subnet.publicsubnet_b.id,
    aws_subnet.publicsubnet_c.id,
  ]
}

output "private_subnet_ids" {
  description = "All private subnet IDs as a list"
  value = [
    aws_subnet.privatesubnet_a.id,
    aws_subnet.privatesubnet_b.id,
    aws_subnet.privatesubnet_c.id,
  ]
}
output "private_route_table_ids" {
  value = [
    aws_route_table.private_a.id,
    aws_route_table.private_b.id,
    aws_route_table.private_c.id,
  ]
}
output "public_route_table_ids" {
  value = [
    aws_route_table.rtb_public_a.id,
    aws_route_table.rtb_public_b.id,
    aws_route_table.rtb_public_c.id,
  ]
}