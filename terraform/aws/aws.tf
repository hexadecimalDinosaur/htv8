terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {          # credentials in environment variables
  region = "ca-central-1" # TODO: parameterize

}

resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "{{ project_name }}-vpc"
  }
}

variable "ingress_ports" {
  type        = list(number)
  description = "Ports to allow for VPC ingress block"
  default     = [22, 80, 443]
}

resource "aws_network_acl" "project_vpc_acl" {
  vpc_id = aws_vpc.project_vpc.id
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      protocol   = "tcp"
      rule_no    = 90 + port.key # avoid creating rules with the same number
      action     = "allow"
      cidr_block = "10.0.1.0/24" # "0.0.0.0/0"
      from_port  = port.value
      to_port    = port.value
    }
  }
}

resource "aws_subnet" "project_pub_subnet" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = aws_vpc.project_vpc.cidr_block
  map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "project_gw" {
  vpc_id = aws_vpc.project_vpc.id
}

resource "aws_route_table" "project_rt" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_internet_gateway.project_gw.id
  }

  #  route {
  #    ipv6_cidr_block        = "::/0"
  #    egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.project_pub_subnet.id
  route_table_id = aws_route_table.project_rt.id
}

data "aws_ami" "debian" {

  most_recent = "true"
  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
  owners = ["136693071363"] # Amazon
}

resource "aws_instance" "project_webserver" {
  ami           = data.aws_ami.debian.id
  instance_type = "t2.micro"
  key_name      = "deployer-key"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "deployer-key"
  public_key = file("pub_key.pub")
}

output "public_ip" {
  value = aws_instance.project_webserver.public_ip
}
