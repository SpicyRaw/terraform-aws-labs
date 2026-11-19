output "ip_pubblico" {
  value = aws_instance.docker-ec2.public_ip
}