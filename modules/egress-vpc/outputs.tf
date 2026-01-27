output "vpc_id" {
  value = aws_vpc.egress_vpc.id
}
output "azs_used" {
  value       = local.az_names
}

output "private_subnet_id_a" { value = aws_subnet.privatesubnet_a.id}
output "private_subnet_id_b" { value = aws_subnet.privatesubnet_b.id}
output "private_subnet_id_c" { value = aws_subnet.privatesubnet_c.id}
output "public_subnet_id_a" { value = aws_subnet.publicsubnet_a.id}
output "public_subnet_id_b" { value = aws_subnet.publicsubnet_b.id}
output "public_subnet_id_c" { value = aws_subnet.publicsubnet_c.id}

output "private_subnet_ids" {
  description = "All private subnet IDs as a list"
  value = [
    aws_subnet.privatesubnet_a.id,
    aws_subnet.privatesubnet_b.id,
    aws_subnet.privatesubnet_c.id,
  ]
}
