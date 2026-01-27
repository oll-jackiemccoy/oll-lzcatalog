name_prefix = "account-a"
vpc_cidr = "10.25.0.0/16"
private_subnet_cidrs = ["10.25.0.0/22", "10.25.4.0/22", "10.25.8.0/22"]
tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}