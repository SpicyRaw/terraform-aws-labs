resource "aws_eip" "lb" {
  instance = aws_instance.firstec2.id
  domain   = "vpc"
}
