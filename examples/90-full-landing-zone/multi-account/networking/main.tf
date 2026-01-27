module "tgw" {
  source              = "../../../../modules/tgw"
  tgw_name                        = var.tgw_name
  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  share_name                      = var.share_name
  principal                       = var.principal

  tags   = merge(var.tags)
}
module "ingress_vpc" {
  source              = "../../../../modules/ingress-vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs= var.private_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}