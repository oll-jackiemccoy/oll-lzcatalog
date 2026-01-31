name_prefix = "account-b"
vpc_cidr = "10.26.0.0/16"
private_subnet_cidrs = ["10.26.0.0/22", "10.26.4.0/22", "10.26.8.0/22"]
tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}