# AWS Region
region = "eu-north-1"

# # 01 VPC vars
vpc_name = "ghost-vpc"
vpc_cidr_block = "10.0.0.0/16"
public_subnet_1_cidr_block = "10.0.1.0/24"
public_subnet_1_az = "eu-north-2a"
public_subnet_2_cidr_block = "10.0.2.0/24"
public_subnet_2_az = "eu-north-2b"
private_subnet_1_cidr_block = "10.0.3.0/24"
private_subnet_1_az = "eu-north-2a"
private_subnet_2_cidr_block = "10.0.4.0/24"
private_subnet_2_az = "eu-north-2b"

# EC2 vars
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"

#04 ALB vars
alb_name = "my-alb"
alb_internal = false
alb_type = "application"
alb_listener_port = 80
alb_listener_protocol = "HTTP"
alb_target_group_name_prefix = "ghost-blog-group"
alb_target_group_port = 80
alb_target_group_protocol = "HTTP"
alb_ingress_port = 80
alb_ingress_cidr_blocks = ["0.0.0.0/0"]

#05 ECS vars
ecs_cluster_name = "ghost-blog-cluster"
ecs_task_family = "ghost-blog-task-family"
ecs_task_network_mode = "bridge"
ecs_task_requires_compatibilities = "EC2"
ecs_container_name = "ghost-blog-container"
ecs_container_image = "my-docker-image"
ecs_container_port = 80
ecs_container_protocol = "tcp"
ecs_service_name = "ghost-blog-service"
ecs_service_desired_count = 1
ecs_service_launch_type = "EC2"
ecs_service_assign_public_ip = false
ecs_service_security_group_name_prefix = "ghost-blog-service-sg"
ecs_service_ingress_port = 80
ecs_service_ingress_cidr_blocks = ["0.0.0.0/0"]

#06 RDS vars
rds_engine = "mysql"
rds_engine_version = "5.8"
rds_instance_class = "t3.micro"
rds_name = "ghost-blogdb"
rds_username = "admin"
rds_password = "ghostpassword"
rds_allocated_storage = 20
rds_storage_type = "gp2"
rds_storage_encrypted = true
rds_multi_az = false
db_subnet_group_name = "my-rds-subnet-group"
rds_security_group_name_prefix = "my-rds-sg"
rds_ingress_cidr_blocks = "10.0.0.0/16"

#07 ECR vars


# S3 vars
bucket_name = "ghost-blog-bucket"

# EFS vars
efs_name = "ghost-blog-efs"
efs_performance_mode = "generalPurpose"
efs_throughput_mode = "bursting"
efs_encrypted = true

# CloudWatch vars
cw_log_group_name = "ghost-blog-log-group"
cw_log_stream_name = "ghost-blog-log-stream"

#10 Rout53 vars
r53_primary_zone = "ghostblog.com"

#11 WAF vars
waf_name                 = "ghost-blog-waf"






# region              = "eu-north-1"

# # 01 VPC vars
# cidr_vpc            = "10.10.0.0/16"
# vpc_name            = "prod-ubi-vpc"
# igw_name            = "prod-ubi-vpc-igw"
# availability_zone1  = "eu-north-1a"
# cidr_subnet1        = "10.10.10.0/24"
# cidr_subnet2        = "10.10.20.0/24"
# availability_zone2  = "eu-north-1b"
# cidr_subnet3        = "10.10.11.0/24"
# cidr_subnet4        = "10.10.21.0/24"
# pcmk_ip             = "62.162.227.130/32"
# # public_key_ubi_aws  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTB5N3ulHnPpJjcIJ4Ex+7AXeXG1wau9hIvrraA29XpqwC/5qmIYLkRlDPLn1JN9+VI2s72qBGNtyT478nPCaFDOWzRNjGjBGFGDgLQbtw0kycaYOWfuk27ARl4hy/v6rbzGWopjVLSV+XsH8+m6eeyRlyYoXGzMVnSOpjP/wvRD/3KyVgcSra40Qx6QjchxpzHhcLc9VllLyNHzXFqAITSn3a76eG7WVMlECiId6iQXxnZsHWKGPIMmHhUHOkPpSLB1QNBAlSfS8tJbBOLVoWvwce/z5rrOFcAa8zh3apqw/X8vHLUrIhDaFqaXe+WRLGX7cb1hGVwQSRlgku0UOR ubi-aws"

# # 02 EKS vars
# eks_name    = "prod-ubi-eks"
# eks_tag     = "prod"

# # 03 Node Group vars
# node_group_name = "prod-ubi"
# instance_type   = ["m5.large"] 
# disk_size       = 40
# ssh_keypair     = "prod-ubi-eks-cluster-key"
# public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTag1IWXiwtOYS8ULbmsAlbw7IfqAKKoME1exe8ONGw0SKBRU4IytiUP2aRXkLZYhTSSu3qUdYNjMTwaEnGUZunZdRumkPyGbr2AeLINeT6W8AnMHufVdkUn8WZKOG3vW2b5UJe7uaQjqc6kvnmjuKGnTcod408g8X2axSyMYLt9dWqowgMwnBMPxSGjYnZZzqOTzpQZ7rd3j5HHH3HoarsaTUPVaZvHjhvXU9qX2ts+MQuW0wbNWzwx+sXPKl8e7dkdBpRyOYj/ZQK2KvHnMZve7I45VAy4DK1A63ck81d2LAD7GXOgwYWTPMz/qGGqeqNL/gd1h+vgx4wBCfwBvd"

# # 04 ECR vars
# gateway_ecr_name            = "prod-ubi-gis-portal-gateway"
# discovery_ecr_name          = "prod-ubi-gis-portal-service-discovery"
# communication_ecr_name      = "prod-ubi-gis-portal-communication"
# identity_provider_ecr_name  = "prod-ubi-gis-portal-identity-provider"
# party_management_ecr_name   = "prod-ubi-gis-portal-party-management"
# products_ecr_name           = "prod-ubi-gis-portal-products"
# portal_client_ecr_name      = "prod-ubi-gis-portal-client"
# scan_on_push                = true
# timeouts_delete             = "60m"
# image_tag_mutability        = "MUTABLE"
# gateway_lc_policy           = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# gateway_ecr_policy          = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# discovery_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# discovery_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# communication_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# communication_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# identity_provider_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# identity_provider_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# party_management_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# party_management_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# products_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# products_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# portal_client_lc_policy       = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 3 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "sinceImagePushed",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 3
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# portal_client_ecr_policy       = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "ECR Policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF

# # 05 RDS vars
# dbuser             = "produbi"

# # 06 EC2 vars
# # ubi_aws                     = "ubi-aws"
# # jenkins_name                = "jenkins"
# # jenkins_private_ip          = "10.10.20.100"
# # jenkins_root_volume_size    = "120"


# # 09 EFS vars
# eks_efs_name    = "eks-efs"