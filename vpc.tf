resource "aws_vpc" "vpc-rd-1" {
    cidr_block = "10.10.20.0/24"
    enable_dns_hostnames = true
    tags = {
      "Name" = "vpc-rd-1"
      "use" = "rd-1"
    }
}

resource "aws_subnet" "subnet-rd-1-public" {
  vpc_id = aws_vpc.vpc-rd-1.id
  cidr_block = "10.10.20.0/28"
  tags = {
    "Name" = "subnet-rd-1-public"
    "use" = "rd-1"
  }
}

resource "aws_subnet" "subnet-rd-1-private" {
  vpc_id = aws_vpc.vpc-rd-1.id
  cidr_block = "10.10.20.16/28"
  tags = {
    "Name" = "subnet-rd-1-private"
    "use" = "rd-1"
  }
}

resource "aws_internet_gateway" "ig-rd-1" {
  vpc_id = aws_vpc.vpc-rd-1.id
  tags = {
    "Name" = "ig-rd-1"
    "use" = "rd-1"
  }
}

resource "aws_route_table" "rt-rd-1" {
  vpc_id = aws_vpc.vpc-rd-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-rd-1.id
  }
  tags = {
    "Name" = "rt-rd-1"
    "use" = "rd-1"
  }
}

resource "aws_route_table_association" "rta1-rd-1-terrform" {
  subnet_id = aws_subnet.subnet-rd-1-public.id
  route_table_id = aws_route_table.rt-rd-1.id
}

resource "aws_eip" "eip_nat-gw" {
  vpc = true
  tags = {
    "Name" = "EIP NAT-GW"
    "use" = "rd-1"
  }
}

resource "aws_nat_gateway" "ngw-1" {
  allocation_id = aws_eip.eip_nat-gw.id
  subnet_id     = aws_subnet.subnet-rd-1-public.id
  depends_on = [aws_internet_gateway.ig-rd-1]
  tags = {
    Name = "NAT GW"
  }

}

resource "aws_route_table" "rt-ngw-1" {
  vpc_id = aws_vpc.vpc-rd-1.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-1.id
  }
  tags = {
    "Name" = "rt-ngw-1"
    "use" = "rd-1"
  }
}

resource "aws_route_table_association" "rta1-ngw-1-terrform" {
  subnet_id = aws_subnet.subnet-rd-1-private.id
  route_table_id = aws_route_table.rt-ngw-1.id
}
