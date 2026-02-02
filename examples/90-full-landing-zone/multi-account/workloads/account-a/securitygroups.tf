resource "aws_security_group" "vpce" {
  name        = "vpce_sg"
  description = "Allow VPC Interface Endpoints for SSM"
  vpc_id      = module.spoke_vpc_a.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.spoke_vpc_a.vpc_cidr]
  }

  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "vpce_sg" })
}
