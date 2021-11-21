resource "aws_vpc" "itea-vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "itea-vpc"
  }
}

resource "aws_subnet" "itea-subnet-public-1" {
  vpc_id                  = aws_vpc.itea-vpc.id
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "itea-subnet-public-1"
  }
}

resource "aws_subnet" "itea-subnet-public-2" {
  vpc_id                  = aws_vpc.itea-vpc.id
  cidr_block              = "172.31.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "itea-subnet-public-2"
  }
}

resource "aws_subnet" "itea-subnet-public-3" {
  vpc_id                  = aws_vpc.itea-vpc.id
  cidr_block              = "172.31.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "itea-subnet-public-3"
  }
}

resource "aws_internet_gateway" "itea-igw" {
  vpc_id = aws_vpc.itea-vpc.id

  tags = {
    "Name" = "itea-igw"
  }
}

resource "aws_route_table" "itea-public-crt" {
  vpc_id = aws_vpc.itea-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.itea-igw.id
  }

  tags = {
    Name = "itea-public-crt"
  }
}

resource "aws_route_table_association" "itea-crta-public-subnet-1" {
  subnet_id      = aws_subnet.itea-subnet-public-1.id
  route_table_id = aws_route_table.itea-public-crt.id
}

resource "aws_route_table_association" "itea-crta-public-subnet-2" {
  subnet_id      = aws_subnet.itea-subnet-public-2.id
  route_table_id = aws_route_table.itea-public-crt.id
}

resource "aws_route_table_association" "itea-crta-public-subnet-3" {
  subnet_id      = aws_subnet.itea-subnet-public-3.id
  route_table_id = aws_route_table.itea-public-crt.id
}

resource "aws_security_group" "itea-all" {
  vpc_id = aws_vpc.itea-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "itea-all"
  }
}