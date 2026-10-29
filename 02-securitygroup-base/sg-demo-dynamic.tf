resource "aws_security_group" "sg-demo-dynamic" {
  name = "Dynamic block"

  dynamic "ingress" {
    for_each = var.sg-demo-dynamics
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
