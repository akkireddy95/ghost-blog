# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  cidr_block = var.public_subnet_1_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.public_subnet_1_az

  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  cidr_block = var.public_subnet_2_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.public_subnet_2_az

  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  cidr_block = var.private_subnet_1_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.private_subnet_1_az

  tags = {
    Name = "${var.vpc_name}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  cidr_block = var.private_subnet_2_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.private_subnet_2_az

  tags = {
    Name = "${var.vpc_name}-private-subnet-2"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
