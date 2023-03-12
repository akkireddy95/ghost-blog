#01 VPC outputs
output "vpc_id" {
  value = aws_vpc.vpc.id
}

#04 ALB outputs
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

#06 RDS outputs
output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

#05 ECS outputs
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_task_definition.arn
}

output "ecs_service_arn" {
  value = aws_ecs_service.ecs_service.arn
}

output "ecs_service_url" {
  value = aws_lb.load_balancer.dns_name
}

#07 ECR outputs
output "ecr_repository_url" {
  value = aws_ecr_repository.ghost_blog.repository_url
}

#08 EFS outputs
output "efs_dns_name" {
  value       = aws_efs_file_system.efs.dns_name
}

#11 WAF outputs
output "web_acl_arn" {
  value = aws_wafv2_web_acl.waf.arn
}


# output "efs_id" {
#   value = aws_efs_file_system.efs.id
# }

# output "efs_mount_target_ids" {
#   value = aws_efs_mount_target.efs_mount_target.*.id
# }
