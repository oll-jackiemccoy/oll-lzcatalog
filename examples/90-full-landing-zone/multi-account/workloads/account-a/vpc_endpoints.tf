locals {
  # Region-aware endpoint service names
  ssm_endpoints = {
    ssm         = "com.amazonaws.${var.region}.ssm"
    ssmmessages = "com.amazonaws.${var.region}.ssmmessages"
    ec2messages = "com.amazonaws.${var.region}.ec2messages"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  for_each            = local.ssm_endpoints
  vpc_id              = module.spoke_vpc_a.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = module.spoke_vpc_a.private_subnet_ids
  security_group_ids = [aws_security_group.vpce.id]

  tags = merge(var.tags, { Name = "vpce-${each.key}" })
}
