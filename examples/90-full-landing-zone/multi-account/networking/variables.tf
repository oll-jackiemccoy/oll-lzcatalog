variable "tgw_name" {
  description = "Name of the Transit Gateway"
  type        = string
}
variable "description" {
  description = "Transit Gateway description"
  type        = string      
}
variable "amazon_side_asn" {
  description = "Amazon-side ASN for the TGW"
  type        = number
}
variable "auto_accept_shared_attachments" {
  description = "Whether to auto-accept shared attachments"
  type        = string
}
variable "default_route_table_association" {
  description = "Enable default route table association"
  type        = string
}
variable "default_route_table_propagation" {
  description = "Enable default route table propagation"
  type        = string
}
variable "dns_support" {
  description = "Enable DNS support on the TGW"
  type        = string

}
variable "vpn_ecmp_support" {
  description = "Enable VPN ECMP support on the TGW"
  type        = string
}
variable "principal" {
  description = "Organization ARN or AWS Account ID)"
  type        = string
}
variable "share_name" { 
    type = string 
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "ingress_prefix" { type = string }
variable "egress_prefix" { type = string }
variable "spokes_prefix" { type = string }

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
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