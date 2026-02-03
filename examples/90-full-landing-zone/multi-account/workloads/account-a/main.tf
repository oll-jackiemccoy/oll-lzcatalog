module "spoke_vpc_a" {
  source              = "../../../../../modules/spoke-vpc"
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidrs= var.private_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}
locals {
  spoke_private_route_table_ids = module.spoke_vpc_a.private_route_table_ids
}

resource "aws_ec2_transit_gateway_vpc_attachment" "spoke_a" {
  transit_gateway_id = local.tgw_id
  vpc_id             = module.spoke_vpc_a.vpc_id
  subnet_ids         = module.spoke_vpc_a.private_subnet_ids
  dns_support        = "enable"

  tags   = merge(var.tags, {
    Name = "tgw-attach-${var.name_prefix}" })
}
# resource "aws_route" "spoke_a_default_to_tgw" {
#   for_each = toset(local.spoke_private_route_table_ids)

#   route_table_id         = each.value
#   destination_cidr_block = "0.0.0.0/0"
#   transit_gateway_id     = local.tgw_id
# }
resource "aws_route" "spoke_a_default_to_tgw" {
  count = length(local.spoke_private_route_table_ids)

  route_table_id         = local.spoke_private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = local.tgw_id

}
# resource "aws_route" "spoke_a_default_to_ingress" {
#   for_each = toset(local.spoke_private_route_table_ids)

#   route_table_id         = each.value
#   destination_cidr_block = local.ingress_vpc_cidr
#   transit_gateway_id     = local.tgw_id
# }
resource "aws_route" "spoke_a_default_to_ingress" {
  count = length(local.spoke_private_route_table_ids)

  route_table_id         = local.spoke_private_route_table_ids[count.index]
  destination_cidr_block = local.ingress_vpc_cidr
  transit_gateway_id     = local.tgw_id

}