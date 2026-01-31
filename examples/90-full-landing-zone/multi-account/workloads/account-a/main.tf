module "spoke_vpc_a" {
  source              = "../../../../../modules/spoke-vpc"
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidrs= var.private_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}
data "aws_ec2_transit_gateway" "shared" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "owner-id"
    values = ["157671019750"]
  }
}
locals {
  shared_tgw_id = data.aws_ec2_transit_gateway.shared.id
}
resource "aws_ec2_transit_gateway_vpc_attachment" "spoke_a" {
  transit_gateway_id = local.shared_tgw_id
  vpc_id             = module.spoke_vpc_a.vpc_id
  subnet_ids         = module.spoke_vpc_a.private_subnet_ids
  dns_support        = "enable"

  tags   = merge(var.tags, {
    Name = "tgw-attach-${var.name_prefix}" })
}