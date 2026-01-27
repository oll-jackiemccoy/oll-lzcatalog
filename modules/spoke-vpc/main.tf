resource "aws_vpc" "spoke_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}
data "aws_availability_zones" "standard" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"] # only regional AZs
  }
  filter {
    name   = "zone-type"
    values = ["availability-zone"] # exclude local / wavelength
  }
}

locals {
  az_ids   = slice(data.aws_availability_zones.standard.zone_ids, 0, 3)
  az_names = slice(data.aws_availability_zones.standard.names, 0, 3) # for tags/outputs
}
########## Private subnets ##########
resource "aws_subnet" "privatesubnet_a" {
  vpc_id               = aws_vpc.spoke_vpc.id
  cidr_block           = var.private_subnet_cidrs[0]
  availability_zone_id = local.az_ids[0]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-a"
    Tier = "private"
  })
  depends_on = [aws_vpc.spoke_vpc]
}
resource "aws_subnet" "privatesubnet_b" {
  vpc_id               = aws_vpc.spoke_vpc.id
  cidr_block           = var.private_subnet_cidrs[1]
  availability_zone_id = local.az_ids[1]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-b"
    Tier = "private"
  })
  depends_on = [aws_vpc.spoke_vpc]
}
resource "aws_subnet" "privatesubnet_c" {
  vpc_id               = aws_vpc.spoke_vpc.id
  cidr_block           = var.private_subnet_cidrs[2]
  availability_zone_id = local.az_ids[2]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-c"
    Tier = "private"
  })
  depends_on = [aws_vpc.spoke_vpc]
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-a", 
    Tier = "private" })
}

resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.privatesubnet_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-b", 
    Tier = "private" })
}
resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.privatesubnet_b.id
  route_table_id = aws_route_table.private_b.id
}
resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-c", 
    Tier = "private" })
}
resource "aws_route_table_association" "private_assoc_c" {
  subnet_id      = aws_subnet.privatesubnet_c.id
  route_table_id = aws_route_table.private_c.id
}
