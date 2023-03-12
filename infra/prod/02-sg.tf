# Security Group for Web Servers
resource "aws_security_group" "web_servers_sg" {
  name_prefix = "${var.vpc_name}-web-servers-sg"
  description = "Security Group for Web Servers"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-web-servers-sg"
  }
}

# Security Group for RDS
resource "aws_security_group" "vpc_security_group" {
  name_prefix = var.vpc_name
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  tags = {
    Name = "${var.vpc_name}-rds-sg"
  }
}

#security groups for EFS mount targets
resource "aws_security_group_rule" "efs_ingress" {
  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_ecs_id
}

resource "aws_security_group_rule" "efs_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_ecs_id
}

resource "aws_security_group_rule" "efs_alb_ingress" {
  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_alb_id
}

resource "aws_security_group_rule" "efs_alb_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_alb_id
}

resource "aws_security_group_rule" "efs_ec2_ingress" {
  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_ec2_id
}

resource "aws_security_group_rule" "efs_ec2_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = var.sg_ec2_id
}
