resource "aws_ec2_transit_gateway_route_table" "spoke_a" {
  transit_gateway_id = local.tgw_id
  tags = merge(var.tags, { Name = "tgw-rtb-${var.spoke_prefix}" })
}

resource "aws_ec2_tag" "spoke_a_attachment_name" {
  resource_id = local.spoke_tgw_attachment_id
  key         = "Name"
  value       = "tgw-attach-${var.spoke_prefix}"
}

resource "aws_ec2_transit_gateway_route_table_association" "spoke_a_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_a.id
  transit_gateway_attachment_id  = local.spoke_tgw_attachment_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "spoke_a_prop_to_egress" {
  transit_gateway_route_table_id = local.egress_tgw_route_table
  transit_gateway_attachment_id  = local.spoke_tgw_attachment_id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "spoke_a_prop_to_ingress" {
  transit_gateway_route_table_id = local.ingress_tgw_route_table
  transit_gateway_attachment_id  = local.spoke_tgw_attachment_id
}

resource "aws_ec2_transit_gateway_route" "internet_spoke_to_egress" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_a.id
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = local.egress_attachment
}
resource "aws_ec2_transit_gateway_route" "spoke_to_ingress" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_a.id
  destination_cidr_block         = local.ingress_vpc_cidr
  transit_gateway_attachment_id  = local.ingress_attachment
}
resource "aws_route" "egress_private_to_spoke_tgw" {
  for_each = toset(local.egress_private_route_table_ids)

  route_table_id         = each.value
  destination_cidr_block = local.spoke_a_vpc_cidr
  transit_gateway_id     = local.tgw_id
}
resource "aws_route" "egress_public_to_spoke_tgw" {
  for_each = toset(local.egress_public_route_table_ids)

  route_table_id         = each.value
  destination_cidr_block = local.spoke_a_vpc_cidr
  transit_gateway_id     = local.tgw_id
}
resource "aws_route" "ingress_private_to_spoke_tgw" {
  for_each = toset(local.ingress_private_route_table_ids)

  route_table_id         = each.value
  destination_cidr_block = local.spoke_a_vpc_cidr
  transit_gateway_id     = local.tgw_id
}
resource "aws_route" "ingress_public_to_spoke_tgw" {
  for_each = toset(local.ingress_public_route_table_ids)

  route_table_id         = each.value
  destination_cidr_block = local.spoke_a_vpc_cidr
  transit_gateway_id     = local.tgw_id
}