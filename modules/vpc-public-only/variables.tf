variable "name_prefix" {
  description = "Prefix for Name tags on resources"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}
variable "public_subnet_cidrs" {
  description = "Three CIDRs for public subnets"
  type        = list(string)
}
variable "tags" {
    type      = map(string)
}