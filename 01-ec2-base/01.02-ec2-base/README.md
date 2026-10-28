# Configurazione EC2 con AMI dinamica

Questa configurazione serve per creare un'istanza EC2 su AWS trovando automaticamente l'AMI aggiornata, senza doverla cercare e copiare a mano ogni volta.

## Come funziona

Nel file `ec2-ami-region.tf` ci sono tre parti principali:
- Il **provider** che imposta la regione AWS (`us-east-1`).
- Il blocco **data** che cerca in automatico l'ultima versione dell'AMI di Ubuntu.
- La risorsa **aws_instance** che crea l'istanza (`t2.micro`) usando quell'AMI.

## Utilizzo

Apri il terminale nella cartella ed esegui:

1. `terraform init` per inizializzare Terraform.
2. `terraform plan` per vedere il piano per la singola istanza.
3. `terraform apply` per creare la risorsa.