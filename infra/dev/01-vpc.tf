# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags                 = var.vpc_tags
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = var.internet_gateway_tags
}

# Subnets
resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidr_blocks)
  cidr_block        = var.subnet_cidr_blocks[count.index]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.subnet_availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-subnet-${count.index + 1}"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = var.public_route_table_tags
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = var.private_route_table_tags
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.subnet[length(var.public_subnet_cidr_blocks) + count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
