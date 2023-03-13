# ALB
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.alb_security_group.id]

  tags = {
    Name = "${var.alb_name}-alb"
  }
}

# ALB listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

# ALB target group
resource "aws_lb_target_group" "ghostblog" {}

resource "aws_lb_target_group" "target_group" {
  name        = var.alb_target_group_name_prefix
  port        = var.alb_target_group_port
  protocol    = var.alb_target_group_protocol
  vpc_id      = aws_vpc.vpc.id
  target_type = "instance"
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = var.alb_target_group_port
    protocol            = var.alb_target_group_protocol
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.alb_target_group_name_prefix}-target-group"
  }
}

# ALB security group
resource "aws_security_group" "alb_security_group" {
  name_prefix = var.alb_security_group_name_prefix
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.alb_ingress_port
    to_port     = var.alb_ingress_port
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr_blocks
  }

  tags = {
    Name = "${var.alb_security_group_name_prefix}-alb-security-group"
  }
}

# Ghostblog ALB listener
resource "aws_lb_listener" "ghostblog" {
  load_balancer_arn = aws_lb.ghostblog.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ghostblog.arn
    type             = "forward"
  }
}

# Ghostblog ALB
resource "aws_lb" "ghostblog" {
  name               = "ghostblog"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.subnet_ids

  tags = {
    Environment = "production"
  }
}
