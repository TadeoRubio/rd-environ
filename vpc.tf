resource "aws_vpc" "vpc-lpic-1" {
    cidr_block = "10.10.20.0/24"
    enable_dns_hostnames = true
    tags = {
      "Name" = "vpc-lpic-1"
      "use" = "lpic-1"
    }
}

resource "aws_subnet" "subnet-lpic-1-public" {
  vpc_id = aws_vpc.vpc-lpic-1.id
  cidr_block = "10.10.20.0/28"
  tags = {
    "Name" = "subnet-lpic-1-public"
    "use" = "lpic-1"
  }
}

resource "aws_subnet" "subnet-lpic-1-private" {
  vpc_id = aws_vpc.vpc-lpic-1.id
  cidr_block = "10.10.20.16/28"
  tags = {
    "Name" = "subnet-lpic-1-private"
    "use" = "lpic-1"
  }
}

resource "aws_internet_gateway" "ig-lpic-1" {
  vpc_id = aws_vpc.vpc-lpic-1.id
  tags = {
    "Name" = "ig-lpic-1"
    "use" = "lpic-1"
  }
}

resource "aws_route_table" "rt-lpic-1" {
  vpc_id = aws_vpc.vpc-lpic-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-lpic-1.id
  }
  tags = {
    "Name" = "rt-lpic-1"
    "use" = "lpic-1"
  }
}

resource "aws_route_table_association" "rta1-lpic-1-terrform" {
  subnet_id = aws_subnet.subnet-lpic-1-public.id
  route_table_id = aws_route_table.rt-lpic-1.id
}

resource "aws_eip" "eip_nat-gw" {
  vpc = true
  tags = {
    "Name" = "EIP NAT-GW"
    "use" = "lpic-1"
  }
}

resource "aws_nat_gateway" "ngw-1" {
  allocation_id = aws_eip.eip_nat-gw.id
  subnet_id     = aws_subnet.subnet-lpic-1-public.id

  tags = {
    Name = "NAT GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.ig-lpic-1]
}

resource "aws_route_table" "rt-ngw-1" {
  vpc_id = aws_vpc.vpc-lpic-1.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-1.id
  }
  tags = {
    "Name" = "rt-ngw-1"
    "use" = "lpic-1"
  }
}

resource "aws_route_table_association" "rta1-ngw-1-terrform" {
  subnet_id = aws_subnet.subnet-lpic-1-private.id
  route_table_id = aws_route_table.rt-ngw-1.id
}
