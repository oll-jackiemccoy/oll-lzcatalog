output "vpc_id" {
  value = aws_vpc.spoke_vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.spoke_vpc.cidr_block
}
output "azs_used" {
  value       = local.az_names
}
output "private_subnet_id_a" { value = aws_subnet.privatesubnet_a.id}
output "private_subnet_id_b" { value = aws_subnet.privatesubnet_b.id}
output "private_subnet_id_c" { value = aws_subnet.privatesubnet_c.id}


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


