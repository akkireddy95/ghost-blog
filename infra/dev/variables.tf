# aws_region
variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

# 01 VPC vars
variable "vpc_id" {
  type = string
}

variable "vpc_tags" {
  type = map(string)
}

variable "vpc_name" {
  type    = string
  default = "ghost-vpc"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_1_az" {
  type    = string
  default = "eu-north-1a"
}

variable "public_subnet_2_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_subnet_2_az" {
  type    = string
  default = "eu-north-1b"
}

variable "private_subnet_1_cidr_block" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_subnet_1_az" {
  type    = string
  default = "eu-north-1a"
}

variable "private_subnet_2_cidr_block" {
  type    = string
  default = "10.0.4.0/24"
}

variable "private_subnet_2_az" {
  type    = string
  default = "eu-north-1b"
}

variable "internet_gateway_tags" {
  type = map(string)
}

variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "subnet_availability_zones" {
  type    = list(string)
  default = ["us-west-1a", "us-west-1b", "us-west-1c"]
}

variable "private_route_table_tags" {
  type = map(string)
  default = {
    Name = "my-private-route-table"
  }
}
variable "public_route_table_tags" {
  type = map(string)
  default = {
    Name = "public-route-table"
  }
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}



#02 SG vars
variable "sg_alb_id" {
  type = string
}


# 03 EC2 vars
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-0c55b159cbfafe1f0"
}

variable "ecs_instance_configurations" {
  type = list(object({
    ami_id            = string
    instance_type     = string
    subnet_id         = string
    security_group_id = string
  }))
}



# 04 ALB vars
variable "alb_name" {
  type    = string
  default = "my-alb"
}

variable "alb_internal" {
  type    = bool
  default = false
}

variable "alb_type" {
  type    = string
  default = "application"
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "alb_listener_port" {
  type    = number
  default = 80
}

variable "alb_listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "alb_target_group_name_prefix" {
  type    = string
  default = "ghost-blog-group"
}

variable "alb_target_group_port" {
  type    = number
  default = 80
}

variable "alb_target_group_protocol" {
  type    = string
  default = "HTTP"
}

variable "alb_ingress_port" {
  type    = number
  default = 80
}

variable "alb_ingress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "alb_security_group_name_prefix" {
  type    = string
  default = "my-alb-sg"
}
variable "alb_subnet_ids" {
  type    = list(string)
  default = ["subnet-1234567890abcdef0", "subnet-0987654321fedcba0"]
}



# 05 ECS vars
variable "ecs_cluster_name" {
  type    = string
  default = "ghost-blog-cluster"
}

variable "ecs_task_family" {
  type    = string
  default = "ghost-blog-task-family"
}

variable "ecs_task_network_mode" {
  type    = string
  default = "bridge"
}

variable "ecs_task_requires_compatibilities" {
  type    = string
  default = "EC2"
}

variable "ecs_container_name" {
  type    = string
  default = "ghost-blog-container"
}

variable "ecs_container_image" {
  type    = string
  default = "ghost-blog"
}

variable "ecs_container_port" {
  type    = number
  default = 80
}

variable "ecs_container_protocol" {
  type    = string
  default = "tcp"
}
variable "ecs_service_name" {}
variable "ecs_service_desired_count" {
  default = 1
}
variable "ecs_service_launch_type" {
  default = "EC2"
}
variable "ecs_service_assign_public_ip" {
  default = false
}
variable "ecs_service_ingress_port" {}
variable "ecs_service_ingress_cidr_blocks" {
  type = list(string)
}
variable "sg_ecs_id" {
  type = string
}

variable "ecs_services" {
  type = list(string)
}



#06 RDS vars
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_name" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_allocated_storage" {}
variable "rds_storage_type" {}
variable "rds_storage_encrypted" {}
variable "rds_multi_az" {}
variable "db_subnet_group_name" {}
variable "rds_security_group_name_prefix" {}
variable "rds_ingress_cidr_blocks" {}
variable "rds_ingress_port" {
  type = number
}
variable "rds_ingress_cidr_block" {
  type = string
}

#07 ECR vars
variable "ecr_repository_name" {
  default = "ghost-blog"
}

variable "allowed_ecr_actions" {
  default = [
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage",
    "ecr:BatchCheckLayerAvailability",
    "ecr:PutImage",
    "ecr:InitiateLayerUpload",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload"
  ]
}

variable "ecs_service_security_group_name_prefix" {
  default = "ecs-service-sg-"
}

variable "ecs_security_group_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


#10 Rout53 vars
variable "r53_primary_zone" {}
variable "route53_record_name" {}


#11 WAF vars
variable "waf_name" {
  type    = string
  default = "ghost-blog-waf"
}

variable "website_name" {
  type    = string
  default = "ghost-blog"
}

variable "waf_ip_sets" {
  type = map(object({
    name         = string
    priority     = number
    ip_addresses = list(string)
  }))
  default = {
    "set1" = {
      name         = "ip-set-1"
      priority     = 1
      ip_addresses = ["10.0.0.1/32", "10.0.0.2/32"]
    },
    "set2" = {
      name         = "ip-set-2"
      priority     = 2
      ip_addresses = ["10.0.0.3/32", "10.0.0.4/32"]
    }
  }
}

variable "ip_addresses" {
  type    = list(string)
  default = []
}

#12 CloudWatch vars
variable "cw_log_group_name" {
  default = "ghost-blog-log-group-name"
}

variable "cw_log_stream_name" {
  type    = string
  default = "ghost-blog-log-stream"
}

