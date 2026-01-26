region = "us-east-1"
name_prefix = "vpc-with-natgw"
vpc_cidr = "10.20.0.0/16"
public_subnet_cidrs = ["10.20.0.0/23", "10.20.2.0/23", "10.20.4.0/23"]
private_subnet_cidrs = ["10.20.16.0/20", "10.20.32.0/20", "10.20.48.0/20"]
tags = {
  ManagedBy    = "terraform"
  Environment  = "vpc-with-natgw"
  map-migrated = "mig-map-tagname-here"
}