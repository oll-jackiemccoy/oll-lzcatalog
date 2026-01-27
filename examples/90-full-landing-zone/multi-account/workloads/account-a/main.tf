module "spoke_vpc_a" {
  source              = "../../../../../modules/spoke-vpc"
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidrs= var.private_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}