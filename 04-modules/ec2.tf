module "ec2-instance" {
  source    = "terraform-aws-modules/ec2-instance/aws"
  version   = "6.4.1"
  subnet_id = "subnet-0db5af00d6bf9d12b"
}