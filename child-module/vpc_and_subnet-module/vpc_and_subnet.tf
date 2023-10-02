
provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_vpc" "vpc_1" {
  cidr_block       = var.vpc_cider_block
  instance_tenancy = "default"

  tags = {
    Name = "vpc-1"
  }
}
resource "aws_subnet" "subnet_A" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.subnet_1_cider_block
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "vpc1_igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "vpc1_route_table"
  }
}
resource "aws_route_table_association" "public-test-a" {
  subnet_id      = aws_subnet.subnet_A.id
  route_table_id = aws_route_table.route_table.id
}

output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.vpc_1.id
}
output "subnet_id" {
  description = "ID of project SUBNET"
  value       = aws_subnet.subnet_A.id
}
