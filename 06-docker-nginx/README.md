# Lab 06 – Docker + Nginx su EC2 con Terraform

Primo lab con Docker. Terraform crea un'istanza EC2 con Docker già installato, accessibile via SSH con una chiave dedicata. Sull'istanza viene avviato un container Nginx, e la pagina `index.html` viene modificata dall'interno del container.

## Cosa fa

- Crea una **key pair** AWS a partire dalla chiave pubblica locale
- Crea un **security group** con SSH (22) e HTTP (80) aperti solo al mio IP
- Crea un'istanza **EC2** (Amazon Linux 2023, `t3.micro`, `us-east-1`)
- Installa e avvia **Docker** all'avvio dell'istanza tramite `user_data`
- Restituisce l'**IP pubblico** come output

## Struttura

| File | Contenuto |
| `main.tf` | Provider AWS e key pair |
| `ec2.tf` | Istanza EC2 con `user_data` che installa Docker
| `firewall.tf` | Security group e regole (SSH, HTTP, egress)
| `variabili.tf` | `my_ip`, `ssh`, `http`, `public_key_path`
| `outputs.tf` | `ip_pubblico`
| `terraform.tfvars` | Valori personali (non nel repo)

## Prerequisiti

- Terraform e credenziali AWS configurate
- Una coppia di chiavi SSH locale:

`ssh-keygen -t ed25519 -f ~/.ssh/lab-docker`


La chiave privata resta sul PC e **non va mai nel repo**. Terraform legge solo quella pubblica (`lab-docker.pub`).

## Come si usa

1. Crea `terraform.tfvars` con i tuoi valori:


my_ip = "x.x.x.x/32"
ssh   = 22
http  = 80


2. Crea l'infrastruttura:


terraform init
terraform plan
terraform apply


3. Aspetta 1-2 minuti (Docker si sta installando) e collegati:


ssh -i ~/.ssh/lab-docker ec2-user@<ip_pubblico> dell istanza.


4. Avvia il container:


docker run -d --name web -p 80:80 nginx
docker ps
curl localhost


5. Modifica la pagina dall'interno del container:


docker exec -it web bash
echo "<h1>Il mio primo container</h1>" > /usr/share/nginx/html/index.html
exit


6. Apri `http://<ip_pubblico>` dal browser.

7. A fine lab, per non pagare l'istanza:


terraform destroy


## Note di sicurezza

- SSH e HTTP sono limitati al mio IP (`/32`), non a `0.0.0.0/0`
- Il mio IP e il percorso della chiave non sono scritti nel codice: l'IP sta in `terraform.tfvars` (nel `.gitignore`) e la chiave si referenzia con `pathexpand("~/.ssh/...")`
- L'egress resta aperto verso tutto: scelta consapevole per un lab
- La pagina è servita in HTTP, senza TLS: va bene per un lab, non per produzione. Utilizzare http://ip_pubblico

## Cosa ho imparato

- `user_data` gira **solo al primo avvio** e `#!/bin/bash` deve essere la **prima riga** dello script: con una riga vuota prima, Docker non viene installato. Con `user_data_replace_on_change = true` Terraform ricrea l'istanza quando lo script cambia
- Senza `key_name` l'istanza nasce senza chiave SSH e non ci si può entrare, e senza `vpc_security_group_ids` non usa il mio security group
- Terraform legge tutti i file `.tf` della cartella come uno solo: dividerli per risorsa serve solo all'ordine
- I container sono effimeri: le modifiche fatte a mano dentro un container non sopravvivono se viene ricreato

## Prossimi passi

- Scrivere un `Dockerfile` con la pagina già dentro, invece di modificarla a mano
- Usare un volume per capire come persistere i dati
- Provare `docker compose`
- Rendere il lab più sicuro: container non root e porte esposte ridotte al minimo