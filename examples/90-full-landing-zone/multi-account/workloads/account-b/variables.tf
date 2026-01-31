variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}
variable "private_subnet_cidrs" {
  description = "Three CIDRs for private subnets"
  type        = list(string)
}
variable "name_prefix" {
  description = "Prefix for Name tags on resources"
  type        = string
}
variable "tags" {
    type      = map(string)
}