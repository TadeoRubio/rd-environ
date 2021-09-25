resource "aws_key_pair" "kp-rd-1" {
  key_name = "kp-rd-1"
  public_key = file("key_rd1.pub")
  tags = {
    "Name" = "kp-rd-1"
    "desc" = "Key pair"
    "use"="rd-1"
  }
}
