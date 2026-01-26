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
########## Private subnets ##########
resource "aws_subnet" "privatesubnet_a" {
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = var.private_subnet_cidrs[0]
  availability_zone_id = local.az_ids[0]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-a"
    Tier = "private"
  })
  depends_on = [aws_vpc.main_vpc]
}
resource "aws_subnet" "privatesubnet_b" {
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = var.private_subnet_cidrs[1]
  availability_zone_id = local.az_ids[1]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-b"
    Tier = "private"
  })
  depends_on = [aws_vpc.main_vpc]
}
resource "aws_subnet" "privatesubnet_c" {
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = var.private_subnet_cidrs[2]
  availability_zone_id = local.az_ids[2]
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-privatesubnet-c"
    Tier = "private"
  })
  depends_on = [aws_vpc.main_vpc]
}
resource "aws_eip" "eip_a" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "${var.name_prefix}-eip_a" })
}
resource "aws_eip" "eip_b" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "${var.name_prefix}-eip_b" })
}
resource "aws_eip" "eip_c" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "${var.name_prefix}-eip_c" })
}
resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.publicsubnet_a.id
  tags          = merge(var.tags, { Name = "${var.name_prefix}-natgw_a" })

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "natgw_b" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = aws_subnet.publicsubnet_b.id
  tags          = merge(var.tags, { Name = "${var.name_prefix}-natgw_b" })

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "natgw_c" {
  allocation_id = aws_eip.eip_c.id
  subnet_id     = aws_subnet.publicsubnet_c.id
  tags          = merge(var.tags, { Name = "${var.name_prefix}-natgw_c" })

  depends_on = [aws_internet_gateway.igw]
}
# Public route table -> Internet via IGW
resource "aws_route_table" "rtb_public_a" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rtb-public-a"
    Tier = "public"
  })
}
resource "aws_route_table" "rtb_public_b" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rtb-public-b"
    Tier = "public"
  })
}
resource "aws_route_table" "rtb_public_c" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rtb-public-c"
    Tier = "public"
  })
}
resource "aws_route" "rtb_public_a_default" {
  route_table_id         = aws_route_table.rtb_public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route" "rtb_public_b_default" {
  route_table_id         = aws_route_table.rtb_public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route" "rtb_public_c_default" {
  route_table_id         = aws_route_table.rtb_public_c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.publicsubnet_a.id
  route_table_id = aws_route_table.rtb_public_a.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.publicsubnet_b.id
  route_table_id = aws_route_table.rtb_public_b.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.publicsubnet_c.id
  route_table_id = aws_route_table.rtb_public_c.id
}
resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-a", 
    Tier = "private" })
}

resource "aws_route" "private_a_default" {
  route_table_id         = aws_route_table.private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_a.id
}

resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.privatesubnet_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-b", 
    Tier = "private" })
}

resource "aws_route" "private_b_default" {
  route_table_id         = aws_route_table.private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_b.id
}

resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.privatesubnet_b.id
  route_table_id = aws_route_table.private_b.id
}
resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = merge(var.tags, { 
    Name = "${var.name_prefix}-rtb-private-c", 
    Tier = "private" })
}

resource "aws_route" "private_c_default" {
  route_table_id         = aws_route_table.private_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_c.id
}

resource "aws_route_table_association" "private_assoc_c" {
  subnet_id      = aws_subnet.privatesubnet_c.id
  route_table_id = aws_route_table.private_c.id
}
