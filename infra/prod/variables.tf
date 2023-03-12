
#01 VPC vars
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "public_subnet_1_cidr_block" {}
variable "public_subnet_1_az" {}
variable "public_subnet_2_cidr_block" {}
variable "public_subnet_2_az" {}
variable "private_subnet_1_cidr_block" {}
variable "private_subnet_1_az" {}
variable "private_subnet_2_cidr_block" {}
variable "private_subnet_2_az" {}

#03 EC2 vars
variable "vpc_id" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_ids" {}
variable "security_group_ids" {}

#04 ALB vars
variable "alb_name" {
  type = string
}

variable "alb_internal" {
  type    = bool
  default = false
}

variable "alb_type" {
  type    = string
  default = "application"
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
  type = string
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

#05 ECS vars
variable "ecs_cluster_name" {}

variable "ecs_task_family" {}

variable "ecs_task_network_mode" {
  default     = "bridge"
}

variable "ecs_task_requires_compatibilities" {
  default     = "EC2"
}

variable "ecs_container_name" {}
variable "ecs_container_image" {}
variable "ecs_container_port" {}
variable "ecs_container_protocol" {
  default     = "tcp"
}
variable "ecs_service_name" {}
variable "ecs_service_desired_count" {
  default     = 1
}
variable "ecs_service_launch_type" {
  default     = "EC2"
}
variable "ecs_service_assign_public_ip" {
  default     = false
}
variable "ecs_service_security_group_name_prefix" {}
variable "ecs_service_ingress_port" {}
variable "ecs_service_ingress_cidr_blocks" {
  type        = list(string)
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

#07 ECR vars

#08 EFS vars
variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = map(string)
}

#10 Rout53 vars

variable "r53_primary_zone" {
  default     = "ghostblog.com"
}


#11 WAF vars
variable "waf_name" {
  type    = string
  default = "ghost-blog-web-acl"
}

variable "website_name" {
  type    = string
  default = "ghost-blog-website"
}

variable "waf_ip_sets" {
  type    = map(object({
    name         = string
    priority     = number
    ip_set_id    = string
    ip_addresses = list(string)
  }))
  default = {}
}

#12 CloudWatch vars


# variable "vpc_id" {}

# variable "subnet_ids" {type = list(string)}
# variable "alb_sg" {}
# variable "ecs_sg" {}
# variable "container_port" {}
# variable "alb_listener_port" {}
# variable "alb_target_group_port" {}
# variable "alb_target_group_health_check_path" {}
# variable "alb_target_group_health_check_interval" {}
# variable "alb_target_group_health_check_timeout" {}
# variable "alb_target_group_health_check_healthy_threshold" {}
# variable "alb_target_group_health_check_unhealthy_threshold" {}





