# 01 - EC2 base

## Cosa crea

- 1 istanza EC2 [t3.micro] in regione [us-east-1]
- Un Elastic IP associato all'istanza  (eip.tf) cosi l'IP pubblico non cambia al riavvio.

## File 
- firstec2.tf
- eip.tf


## Cosa ho imparato

- Ciclo di lavoro: init, plan, apply, destroy
- Modifica dei tags: aggiornamento in-place, senza ricreare l'istanza
- Apply -auto-approve solo per laboratori.
- Controllo funzionamento tramite AWS Console
- Associare IP a un istanza tramite Terraform

## Comandi

    terraform init
    terraform plan
    terraform apply
    terraform destroy
    terraform apply-auto-approve

## Note

Eseguire `terraform destroy` a fine uso per evitare costi.