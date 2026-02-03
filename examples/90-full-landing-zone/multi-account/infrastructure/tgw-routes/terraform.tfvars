region = "us-east-1"
ingress_prefix = "ingress"
egress_prefix = "egress"
spoke_prefix = "account-a"

tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}
