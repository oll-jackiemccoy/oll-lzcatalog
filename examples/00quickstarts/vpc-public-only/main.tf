module "vpc" {
  source              = "../../../modules/vpc-public-only"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}