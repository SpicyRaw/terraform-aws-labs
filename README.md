# terraform-aws-labs

Laboratori pratici di IaC con Terraform su AWS,realizzati durante la preparazione alla certificazione HashiCorp Terraform Associate (004).

## Laboratori

Cartella 01-ec2-base
Cartella 02-securitygroup-base

## Requisiti

- Terraform installato
- AWS CLI configurata con un profilo dedicato
- Un account AWS (le credenziali non sono incluse nel repository)

## Come usarli

    cd 01-ec2-base
    terraform init
    terraform plan
    terraform apply
    terraform destroy

## Sicurezza

Credenziali/IP, file di state e file .tfvars sono esclusi tramite .gitignore.