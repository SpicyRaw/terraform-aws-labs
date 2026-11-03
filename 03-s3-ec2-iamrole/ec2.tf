# Cerca l'AMI Amazon Linux 2023 più recente
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_security_group" "web" {
  name        = "lab03-web-http"
  description = "Solo HTTP in ingresso"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Uscita aperta: serve per S3 e per installare i pacchetti
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3.name

  # Script eseguito al primo avvio
  user_data = <<-EOT
    #!/bin/bash
    dnf install -y httpd cronie
    echo "Lab 03" > /var/www/html/index.html
    systemctl enable --now httpd crond

    mkdir -p /srv/upload
    chmod 1777 /srv/upload

    # Ogni minuto copia la cartella sul bucket
    echo "* * * * * root aws s3 sync /srv/upload s3://${aws_s3_bucket.this.id} --region us-east-1" > /etc/cron.d/s3-sync
  EOT

  tags = {
    Name = "lab03-s3-ec2"
  }
}