# AWS Region
aws_region = "eu-north-1"

# # 01 VPC vars
vpc_name                    = "ghost-vpc"
vpc_cidr_block              = "10.0.0.0/16"
public_subnet_1_cidr_block  = "10.0.1.0/24"
public_subnet_1_az          = "eu-north-2a"
public_subnet_2_cidr_block  = "10.0.2.0/24"
public_subnet_2_az          = "eu-north-2b"
private_subnet_1_cidr_block = "10.0.3.0/24"
private_subnet_1_az         = "eu-north-2a"
private_subnet_2_cidr_block = "10.0.4.0/24"
private_subnet_2_az         = "eu-north-2b"

#02 SG vars
sg_alb_id = "sg-0123456789abcdef"
sg_ec2_id = "sg-0123456789abcdef"

# EC2 vars
instance_type = "t2.micro"
ami_id        = "ami-0c55b159cbfafe1f0"

#04 ALB vars
alb_name                     = "my-alb"
alb_internal                 = false
alb_type                     = "application"
alb_listener_port            = 80
alb_listener_protocol        = "HTTP"
alb_target_group_name_prefix = "ghost-blog-group"
alb_target_group_port        = 80
alb_target_group_protocol    = "HTTP"
alb_ingress_port             = 80
alb_ingress_cidr_blocks      = ["0.0.0.0/0"]

#05 ECS vars
ecs_cluster_name                       = "ghost-blog-cluster"
ecs_task_family                        = "ghost-blog-task-family"
ecs_task_network_mode                  = "bridge"
ecs_task_requires_compatibilities      = "EC2"
ecs_container_name                     = "ghost-blog-container"
ecs_container_image                    = "my-docker-image"
ecs_container_port                     = 80
ecs_container_protocol                 = "tcp"
ecs_service_name                       = "ghost-blog-service"
ecs_service_desired_count              = 1
ecs_service_launch_type                = "EC2"
ecs_service_assign_public_ip           = false
ecs_service_security_group_name_prefix = "ghost-blog-service-sg"
ecs_service_ingress_port               = 80
ecs_service_ingress_cidr_blocks        = ["0.0.0.0/0"]

#06 RDS vars
rds_engine                     = "mysql"
rds_engine_version             = "5.8"
rds_instance_class             = "t3.micro"
rds_name                       = "ghost-blogdb"
rds_username                   = "admin"
rds_password                   = "ghostpassword"
rds_allocated_storage          = 20
rds_storage_type               = "gp2"
rds_storage_encrypted          = true
rds_multi_az                   = false
db_subnet_group_name           = "my-rds-subnet-group"
rds_security_group_name_prefix = "my-rds-sg"
rds_ingress_cidr_blocks        = "10.0.0.0/16"

#07 ECR vars
sg_ecs_id = "sg-0123456789abcdef"

# S3 vars
bucket_name = "ghost-blog-bucket"

# EFS vars
efs_name             = "ghost-blog-efs"
efs_performance_mode = "generalPurpose"
efs_throughput_mode  = "bursting"
efs_encrypted        = true

# CloudWatch vars
cw_log_group_name  = "ghost-blog-log-group"
cw_log_stream_name = "ghost-blog-log-stream"

#10 Rout53 vars
r53_primary_zone = "ghostblog.com"

#11 WAF vars
waf_name = "my-web-acl"
waf_ip_sets = {
  "ip-set-1" = {
    name         = "ip-set-1"
    priority     = 1
    ip_addresses = ["192.0.2.0/24", "203.0.113.0/24"]
  },
  "ip-set-2" = {
    name         = "ip-set-2"
    priority     = 2
    ip_addresses = ["198.51.100.0/24", "203.0.113.0/24"]
  }
}


