resource "aws_instance" "docker-ec2" {
  ami                         = "ami-06f98347e4f9c7328"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.lab.key_name
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  user_data_replace_on_change = true

  user_data = <<-EOF
#!/bin/bash
dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

EOF

  tags = {
    Name = "docker-nginx"

  }
}