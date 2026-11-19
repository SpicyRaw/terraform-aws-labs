resource "aws_security_group" "ssh" {
  name        = "Managed Terraform Lab"
  description = "Docker ssh"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = var.my_ip
  from_port         = var.ssh
  ip_protocol       = "tcp"
  to_port           = var.ssh
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = var.my_ip
  from_port         = var.http
  ip_protocol       = "tcp"
  to_port           = var.http
}

resource "aws_vpc_security_group_egress_rule" "ssh" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}