# DB subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.subnet[1].id, aws_subnet.subnet[2].id]
}


# RDS security group
resource "aws_security_group" "rds_security_group" {
  name_prefix = var.rds_security_group_name_prefix

  ingress {
    from_port   = var.rds_ingress_port
    to_port     = var.rds_ingress_port
    protocol    = "tcp"
    cidr_blocks = [var.rds_ingress_cidr_block]
  }

  tags = {
    Name = "${var.rds_security_group_name_prefix}-rds-security-group"
  }
}

# RDS instance in the private subnet
resource "aws_db_instance" "rds_instance" {
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  name                   = var.rds_name
  username               = var.rds_username
  password               = var.rds_password
  allocated_storage      = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
  storage_encrypted      = var.rds_storage_encrypted
  multi_az               = var.rds_multi_az
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]

  tags = {
    Name = "${var.rds_name}-db"
  }
}