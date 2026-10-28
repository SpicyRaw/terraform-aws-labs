provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu-eks-pro/k8s_1.29/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20251124"]

  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
}