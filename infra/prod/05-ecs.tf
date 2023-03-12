#ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.ecs_task_family
  network_mode             = var.ecs_task_network_mode
  requires_compatibilities = [var.ecs_task_requires_compatibilities]

  container_definitions = jsonencode([
    {
      name  = var.ecs_container_name
      image = var.ecs_container_image
      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_port
          protocol      = var.ecs_container_protocol
        }
      ]
    }
  ])
}

#ECS service
resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.ecs_service_desired_count
  launch_type     = var.ecs_service_launch_type

  network_configuration {
    subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups  = [aws_security_group.ecs_service_security_group.id]
    assign_public_ip = var.ecs_service_assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }
}

#security group for ECS service
resource "aws_security_group" "ecs_service_security_group" {
  name_prefix = var.ecs_service_security_group_name_prefix
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.ecs_service_ingress_port
    to_port     = var.ecs_service_ingress_port
    protocol    = "tcp"
    cidr_blocks = var.ecs_service_ingress_cidr_blocks
  }

  tags = {
    Name = "${var.ecs_service_security_group_name_prefix}-ecs-service-security-group"
  }
}
