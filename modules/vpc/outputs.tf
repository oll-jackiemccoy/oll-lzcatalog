output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "azs_used" {
  value       = local.az_names
}

output "public_subnet_id_a" { value = aws_subnet.publicsubnet_a.id}
output "public_subnet_id_b" { value = aws_subnet.publicsubnet_b.id}
output "public_subnet_id_c" { value = aws_subnet.publicsubnet_c.id}

