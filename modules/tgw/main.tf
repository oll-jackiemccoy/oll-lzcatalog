resource "aws_ec2_transit_gateway" "main" {
  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support

    tags   = merge(var.tags, 
    {Name = var.tgw_name }
    )
}
#RAM Shares
resource "aws_ram_resource_share" "this" {
  name                      = var.share_name
  allow_external_principals = false
  tags                      = var.tags
}
resource "aws_ram_resource_association" "tgw" {
  resource_share_arn = aws_ram_resource_share.this.arn
  resource_arn       = aws_ec2_transit_gateway.main.arn
}

resource "aws_ram_principal_association" "tgw_org_share" {
   principal           = var.principal
   resource_share_arn  = aws_ram_resource_share.this.arn
 }