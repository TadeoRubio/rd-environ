resource "aws_instance" "ec2-bastion-1" {
  ami                         = "ami-096fda3c22c1c990a"
  instance_type               = "t2.micro"
  private_ip                  = "10.10.20.6"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet-rd-1-public.id
  vpc_security_group_ids = [
    aws_security_group.sg1-open-terraform.id
  ]
  key_name = aws_key_pair.kp-rd-1.key_name

  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }
  tags = {
    "Name" = "Bastion"
    "OS"   = "RHEL 8"
    "use" = "rd-1"
  }
   user_data = file("init-apache-public.sh")
}

/*
resource "aws_eip" "eip_rd-1" {
  vpc = true
  instance = aws_instance.ec2-bastion-1.id
  tags = {
    "Name" = "EIP Bastión rd-1"
    "use" = "rd-1"
  }
}
*/
resource "aws_instance" "ec2-internal-2" {
  ami                         = "ami-096fda3c22c1c990a"
  instance_type               = "t2.micro"
  private_ip                  = "10.10.20.21"
  subnet_id                   = aws_subnet.subnet-rd-1-private.id
  vpc_security_group_ids = [
    aws_security_group.sg2-close-terraform.id
  ]
  key_name = aws_key_pair.kp-rd-1.key_name
  tags = {
    "Name" = "Internal A"
    "OS"   = "RHEL 8"
    "use" = "rd-1"
  }
   user_data = file("init.sh")
}

resource "aws_instance" "ec2-internal-3" {
  ami                         = "ami-096fda3c22c1c990a"
  instance_type               = "t2.micro"
  private_ip                  = "10.10.20.22"
  subnet_id                   = aws_subnet.subnet-rd-1-private.id
  vpc_security_group_ids = [
    aws_security_group.sg2-close-terraform.id
  ]
  key_name = aws_key_pair.kp-rd-1.key_name
  tags = {
    "Name" = "Internal B"
    "OS"   = "RHEL 8"
    "use"="rd-1"
  }
   user_data = file("init-apache-private.sh")
}
