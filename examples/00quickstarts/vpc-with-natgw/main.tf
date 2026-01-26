module "vpc" {
  source              = "../../../modules/vpc-with-natgw"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs= var.private_subnet_cidrs
  name_prefix         = var.name_prefix
  tags                = var.tags
}