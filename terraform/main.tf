terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source for default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source for default subnet in specified availability zone
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data source for Ubuntu 22.04 LTS AMI (Free Tier eligible)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group for MEAN app
resource "aws_security_group" "meanapp" {
  name        = "meanapp-sg"
  description = "Security group for MEAN app"
  vpc_id      = data.aws_vpc.default.id

  # HTTP access from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from configurable CIDR block
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }

  # Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "meanapp-sg"
  }
}

# SSH key pair for EC2 access
resource "aws_key_pair" "meanapp" {
  key_name   = "meanapp-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "meanapp-key"
  }
}

# EC2 instance for MEAN app
resource "aws_instance" "meanapp" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name               = aws_key_pair.meanapp.key_name
  vpc_security_group_ids = [aws_security_group.meanapp.id]
  subnet_id              = tolist(data.aws_subnets.default.ids)[0]

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = var.instance_name
  }
}
