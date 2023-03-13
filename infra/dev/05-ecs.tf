# ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

# ECS task definition
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

# ECS service
resource "aws_ecs_service" "ecs_service" {
  for_each = var.ecs_services

  name            = each.key
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition[each.value.task_definition].arn
  desired_count   = each.value.desired_count
  launch_type     = each.value.launch_type

  network_configuration {
    subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups  = [aws_security_group.ecs_service_security_group[each.key].id]
    assign_public_ip = each.value.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.private_subnet_1_az
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.private_subnet_2_az
  tags = {
    Name = "private-subnet-2"
  }
}

# Security group for ECS service
resource "aws_security_group" "ecs_service_security_group" {
  for_each = var.ecs_services

  name_prefix = "${each.key}-${var.ecs_service_security_group_name_prefix}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = each.value.ingress_port
    to_port     = each.value.ingress_port
    protocol    = "tcp"
    cidr_blocks = each.value.ingress
  }
}
