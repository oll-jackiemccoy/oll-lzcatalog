module "vpc" {
  source              = "../../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = ["10.23.0.0/23","10.23.2.0/23","10.23.4.0/23"]
  private_subnet_cidrs= ["10.23.16.0/20", "10.23.32.0/20", "10.23.48.0/20"]
  name_prefix         = var.name_prefix
  tags                = var.tags
}