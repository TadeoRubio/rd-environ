output "eip_lpic_1" {
  value = aws_eip.eip_lpic-1.public_ip
}


output "eip_nat-gw" {
  value = aws_eip.eip_nat-gw.public_ip
}
