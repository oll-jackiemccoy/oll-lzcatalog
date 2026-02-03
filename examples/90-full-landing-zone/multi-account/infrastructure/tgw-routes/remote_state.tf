data "terraform_remote_state" "account-a" {
  backend = "s3"

  config = {
    bucket = "terraform-workload-accounta-890760984056"
    key    = "workload-accounta/terraform.state"
    region = "us-east-1"
    profile = "awslzaccounta"
  }
}
locals {
  spoke_a_vpc_id = data.terraform_remote_state.account-a.outputs.spoke_vpc_id
  spoke_a_vpc_cidr = data.terraform_remote_state.account-a.outputs.spoke_vpc_cidr
  spoke_tgw_attachment_id = data.terraform_remote_state.account-a.outputs.spoke_tgw_attachment_id
}

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
  ingress_vpc_cidr = data.terraform_remote_state.tgw_core.outputs.ingress_vpc_cidr
  egress_attachment = data.terraform_remote_state.tgw_core.outputs.egress_attachment
  ingress_attachment = data.terraform_remote_state.tgw_core.outputs.ingress_attachment
  egress_tgw_route_table = data.terraform_remote_state.tgw_core.outputs.egress_tgw_route_table
  ingress_tgw_route_table = data.terraform_remote_state.tgw_core.outputs.ingress_tgw_route_table
  egress_private_route_table_ids = data.terraform_remote_state.tgw_core.outputs.egress_private_route_table_ids
  egress_public_route_table_ids = data.terraform_remote_state.tgw_core.outputs.egress_public_route_table_ids
  ingress_private_route_table_ids = data.terraform_remote_state.tgw_core.outputs.ingress_private_route_table_ids
  ingress_public_route_table_ids = data.terraform_remote_state.tgw_core.outputs.ingress_public_route_table_ids
  }