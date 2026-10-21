provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "firewall-terraform"
  description = "Managed from terraform"
 
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.my_ip
  from_port         = var.http
  ip_protocol       = "tcp"
  to_port           = var.http
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.my_ip
  from_port         = var.ssh
  ip_protocol       = "tcp"
  to_port           = var.ssh
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_hhtps" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = var.https
  ip_protocol       = "tcp"
  to_port           = var.http
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
