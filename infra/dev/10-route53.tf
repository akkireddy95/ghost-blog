data "aws_route53_zone" "primary" {
  name = "ghostblog.com"
}

# Route 53 DNS Record for Ghost Blog
data "aws_route53_zone" "ghostblog" {
  name = var.r53_primary_zone
}

resource "aws_route53_record" "ghostblog_elb" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.route53_record_name
  type    = "CNAME"
  records = [aws_lb.ghost_blog_load_balancer.dns_name]
  ttl     = "300"
}

resource "aws_lb" "ghost_blog_load_balancer" {
  name               = "ghost-blog"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.alb_subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]

  access_logs {
    bucket  = aws_s3_bucket.logging_bucket.id
    prefix  = "ghost-blog/access-logs/"
    enabled = true
  }

  tags = {
    Name = "ghost-blog-alb"
  }
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "alb_sg_"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
