resource "aws_lb" "public" {
  name               = "${var.lb_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  
  subnets = local.ingress_public_subnet_ids

  enable_deletion_protection = false

  tags = merge(var.tags, { Name = "${var.lb_prefix}-alb" })
}

resource "aws_lb_target_group" "app" {
  name        = "${var.lb_prefix}-tg"
  port        = var.target_port
  protocol    = "HTTP"
  vpc_id      = local.ingress_vpc_id
  target_type = "ip" # use "instance" if you’re targeting EC2 instances by ID

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, { Name = "${var.lb_prefix}-tg" })
}

# HTTP listener → redirect to HTTPS (optional but best practice)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
resource "aws_lb_target_group_attachment" "app_target" {
  target_group_arn  = aws_lb_target_group.app.arn
  target_id         = var.target_ip
  port              = var.target_port
  availability_zone = "all"
}

