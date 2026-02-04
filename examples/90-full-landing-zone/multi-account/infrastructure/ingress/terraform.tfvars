region = "us-east-1"
lb_prefix = "accounta"
tags = {
  ManagedBy    = "terraform"
  Environment  = "multiaccount"
  map-migrated = "mig-map-tagname-here"
}
target_port = 80
health_check_path = "/"
target_ip = "10.25.9.148"
