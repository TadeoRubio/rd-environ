resource "aws_key_pair" "kp-lpic-1" {
  key_name = "kp-lpic-1"
  public_key = file("key_lpic1.pub")
  tags = {
    "Name" = "kp-lpic-1"
    "desc" = "Key pair"
    "use"="lpic-1"
  }
}
