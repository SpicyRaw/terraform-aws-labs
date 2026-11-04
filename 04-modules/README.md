# Lab 04 - Moduli Terraform

## Obiettivo
Creare un'istanza EC2 usando il modulo della community
`terraform-aws-modules/ec2-instance/aws` invece di scrivere la risorsa a mano.

## Cosa fa
- Usa il modulo ufficiale alla versione fissata `6.4.1`
- Lancia l'istanza in una subnet della VPC di default (us-east-1)
- Parametri configurabili tramite variabili
- Espone i valori utili tramite output

## Struttura
- `ec2.tf` - chiamata al modulo
- `variables.tf` - variabili del lab
- `outputs.tf` - output

## Come usarlo
terraform init
terraform plan
terraform apply
terraform destroy   # a fine lab, per non pagare risorse inutili

## Cosa ho imparato
- Un modulo si scarica con `terraform init` (senza, il plan dà "Module not installed")
- Fissare la `version` rende il lab riproducibile
- Errore incontrato: `no matching EC2 Subnet found`. Avevo passato
  un ID di VPC (`vpc-...`) a `subnet_id`, che vuole un ID di subnet
  (`subnet-...`)
- Il modulo legge dati da AWS (subnet, AMI), quindi un valore sbagliato
  esce solo al `plan`, non al `validate`

## Note
Nessun ID o dato personale nel repo.