resource "aws_security_group" "sg1-open-terraform" {
  name        = "sg1-open"
  vpc_id      = aws_vpc.vpc-lpic-1.id
  description = "Permitir SSH & Ping"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.20.0/24"]

    //security_groups = [aws_security_group.sg2-close-terraform.id]
    description = "ALL"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
    description = "ALL"
  }

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Ping"
    from_port = -1
    protocol = "icmp"
    to_port = -1
  } 

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "sg1-open",
    "use" = "lpic-1"
  }
}


resource "aws_security_group" "sg2-close-terraform" {
  name        = "sg2-close"
  vpc_id      = aws_vpc.vpc-lpic-1.id
  description = "Permitir Ping"

  ingress {
    cidr_blocks = ["10.10.20.0/24","3.211.173.228/32"]
    description = "All"
    from_port = 0
    protocol = "-1"
    to_port = 0
    }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "sg2-close",
    "use" = "lpic-1"
  }
}

