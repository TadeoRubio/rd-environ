output "eip_nat-gw" {
  value = aws_eip.eip_nat-gw.public_ip
}

/*
output "eip_rd_1" {
  value = aws_eip.eip_rd-1.public_ip
}
*/

output "public_instance_ip" {
  value = aws_instance.ec2-bastion-1.public_ip
}