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
  vpc_cidr            = var.ingress_vpc_cidr
  public_subnet_cidrs = var.ingress_public_subnet_cidrs
  private_subnet_cidrs= var.ingress_private_subnet_cidrs
  name_prefix         = var.ingress_prefix
  tags                = var.tags
}
module "egress_vpc" {
  source              = "../../../../modules/egress-vpc"
  vpc_cidr            = var.egress_vpc_cidr
  public_subnet_cidrs = var.egress_public_subnet_cidrs
  private_subnet_cidrs= var.egress_private_subnet_cidrs
  name_prefix         = var.egress_prefix
  tags                = var.tags
}
resource "aws_ec2_transit_gateway_vpc_attachment" "ingress" {
  transit_gateway_id = module.tgw.tgw_id
  vpc_id             = module.ingress_vpc.vpc_id
  subnet_ids         = module.ingress_vpc.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.ingress_prefix}-to-tgw"
  })
}
resource "aws_ec2_transit_gateway_route_table" "ingress" {
  transit_gateway_id = module.tgw.tgw_id
  tags = merge(var.tags, { Name = "tgw-rtb-${var.ingress_prefix}" })
}

resource "aws_ec2_transit_gateway_route_table" "spokes" {
  transit_gateway_id = module.tgw.tgw_id
  tags = merge(var.tags, { Name = "tgw-rtb-${var.spokes_prefix}" })
}

resource "aws_ec2_transit_gateway_route_table" "egress" {
  transit_gateway_id = module.tgw.tgw_id
  tags = merge(var.tags, { Name = "tgw-rtb-${var.egress_prefix}" })
}
resource "aws_ec2_transit_gateway_route_table_association" "ingress_assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}