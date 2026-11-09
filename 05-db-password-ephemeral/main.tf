terraform {
  required_version = ">=1.11"

  required_providers {
    aws    = { source = "hashicorp/aws", version = ">=5.90" }
    random = { source = "hashicorp/random", version = ">= 3.7" }
  }
}

provider "aws" {
  region = "us-east-1"

}

ephemeral "random_password" "db" {
  length  = 24
  special = false
}

resource "aws_db_instance" "demo" {
  identifier        = "demo-db"
  engine            = "postgres"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  username            = "dbadmin"
  password_wo         = ephemeral.random_password.db.result
  password_wo_version = 1

  publicly_accessible = false
  storage_encrypted   = true
  skip_final_snapshot = true

}