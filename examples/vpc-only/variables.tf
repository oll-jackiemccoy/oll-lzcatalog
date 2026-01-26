variable "region" {
  description = "AWS region"
  type        = string
}
variable "name_prefix" {
    type = string
}
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
    default = {
    ManagedBy   = "terraform"
    }
}
variable "vpc_cidr" {
    type = string
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}