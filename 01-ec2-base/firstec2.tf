provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "firstec2" {
  ami           = "ami-004d1eaf8eaa0107d"
  instance_type = "t3.micro"
}
