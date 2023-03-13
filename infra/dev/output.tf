# VPC Outputs
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

# EC2 Outputs
output "ecs_instance_private_ip" {
  value = aws_instance.ecs_instance.*.private_ip
}

output "ecs_instance_arn" {
  value = aws_instance.ecs_instance.*.arn
}

# ALB Outputs
output "alb_arn" {
  value = aws_lb.alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

# ECS Outputs

output "ecs_service_name" {
  value = { for k, v in aws_ecs_service.ecs_service : k => v.name }
}

output "ecs_service_arn" {
  value = { for k, v in aws_ecs_service.ecs_service : k => v.arn }
}


# RDS Outputs
output "rds_instance_address" {
  value = aws_db_instance.rds_instance.address
}

output "rds_instance_port" {
  value = aws_db_instance.rds_instance.port
}

# WAF Outputs
output "waf_logging_bucket" {
  value = aws_s3_bucket.logging_bucket.bucket
}
