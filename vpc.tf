data "aws_availability_zones" "available" {}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "linux_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.linux_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "linux_subnet"
  }
}


resource "aws_route_table" "linux_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "linux_RT"
  }
}


resource "aws_route_table_association" "linux_rt_association" {
  subnet_id      = aws_subnet.linux_subnet.id
  route_table_id = aws_route_table.linux_rt.id
}


resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


resource "aws_route" "linux_rt_default_route" {
  route_table_id         = aws_route_table.linux_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}

resource "aws_security_group" "linux" {
  name        = "linux_SG"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "linux_SG"
  }
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}

resource "aws_security_group_rule" "allow_https_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}


resource "aws_security_group_rule" "allow_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.linux.id
}











