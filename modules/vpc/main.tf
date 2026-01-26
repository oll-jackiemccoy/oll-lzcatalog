resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-igw"
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
########## Public subnets ##########
resource "aws_subnet" "publicsubnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone_id    = local.az_ids[0]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-publicsubnet-a"
    Tier = "public"
  })
  depends_on = [aws_vpc.main_vpc]
}
resource "aws_subnet" "publicsubnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone_id    = local.az_ids[1]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-publicsubnet-b"
    Tier = "public"
  })
  depends_on = [aws_vpc.main_vpc]
}
resource "aws_subnet" "publicsubnet_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[2]
  availability_zone_id    = local.az_ids[2]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-publicsubnet-c"
    Tier = "public"
  })
  depends_on = [aws_vpc.main_vpc]
}
# Public route table -> Internet via IGW
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rtb-public"
    Tier = "public"
  })
}
resource "aws_route" "rtb_public_default" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.publicsubnet_a.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.publicsubnet_b.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.publicsubnet_c.id
  route_table_id = aws_route_table.rtb_public.id
}