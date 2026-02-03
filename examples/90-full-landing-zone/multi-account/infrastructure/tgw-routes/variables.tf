variable "region" {
  description = "AWS region"
  type        = string
}
variable "ingress_prefix" { type = string }
variable "egress_prefix" { type = string }
variable "spoke_prefix" { type = string }
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}