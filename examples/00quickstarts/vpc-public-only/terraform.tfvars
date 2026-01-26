region = "us-east-1"
name_prefix = "vpc-public"
vpc_cidr = "10.10.0.0/16"
public_subnet_cidrs = ["10.10.0.0/23", "10.10.2.0/23", "10.10.4.0/23"]
tags = {
  ManagedBy    = "terraform"
  Environment  = "vpc-public"
  map-migrated = "mig-map-tagname-here"
}