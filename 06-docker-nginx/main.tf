provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "lab" {
  key_name   = "lab-docker"
  public_key = file(pathexpand(var.public_key_path))
}