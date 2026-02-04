data "terraform_remote_state" "tgw_core" {
  backend = "s3"

  config = {
    bucket = "terraform-state-network-157671019750"
    key    = "full-lz-multiaccount-networking/terraform.state"
    region = "us-east-1"
    profile = "awslznetwork"
  }
}
locals {
  tgw_id = data.terraform_remote_state.tgw_core.outputs.tgw_id
  ingress_vpc_id = data.terraform_remote_state.tgw_core.outputs.ingress_vpc_id
  ingress_vpc_cidr = data.terraform_remote_state.tgw_core.outputs.ingress_vpc_cidr
  ingress_public_subnet_ids  = data.terraform_remote_state.tgw_core.outputs.ingress_public_subnet_ids
  
  }