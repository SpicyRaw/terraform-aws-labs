# Lab 02 – Security Group base con Terraform

Creazione di un Security Group AWS gestito interamente con Terraform, con regole separate per HTTP/HTTPS/ELASTIC IP, SSH e traffico in uscita.

## Cosa crea

- 1 Elastic IP (`aws_eip.lb`)
- 1 security group (`allow_tls`)
- Ingress: HTTP 80 da `0.0.0.0/0`
- Ingress: SSH 22 solo dal mio IP (`var.my_ip`)
- Ingress: HTTPS 443 dal solo IP dell'Elastic IP (`${aws_eip.lb.public_ip}/32`)
- Egress: tutto il traffico verso `0.0.0.0/0
- Security group "Dynamic block" che genera le regole di ingress da una lista di porte, invece di scrivere un blocco `ingress` per ogni porta.


Regione: `us-east-1`. Il security group viene creato nel VPC di default dell'account.

## Requisiti

- Terraform installato
- Account AWS con credenziali configurate (`aws configure`)
- 
## Note di sicurezza

- **SSH limitato a un solo IP.** La porta 22 non è esposta a `0.0.0.0/0`: l'IP viene passato tramite la variabile `my_ip`, senza valore di default.
- **Nessun dato personale nel repository.** Il file `terraform.tfvars` con il tuo IP è escluso tramite `.gitignore`; nel repo c'è solo `terraform.tfvars.example` con un IP fittizio.
- **Il file `terraform.tfstate` non va mai pubblicato**, perché contiene dettagli dell'infrastruttura. È escluso dal `.gitignore`.
- **La porta 80 è aperta a tutti** perché pensata per un web server pubblico. In produzione si metterebbe davanti un load balancer o un WAF e si userebbe HTTPS (443).
- **L'IP di casa è di solito dinamico.** Se cambia, SSH smette di funzionare: aggiorna `terraform.tfvars` e rilancia `terraform apply`.

## Cosa ho imparato
- Riferire un attributo di un'altra risorsa crea una dipendenza implicita: Terraform crea prima l'EIP e poi la regola.
- `public_ip` è "known after apply": il valore esiste solo dopo la creazione.
- Ogni cartella con file .tf è un progetto indipendente con il proprio terraform init, la propria cartella .terraform e il proprio state.
- Una regola duplicata (stesso CIDR e protocollo) viene rifiutata da AWS con `InvalidPermission.Duplicate`.
- Le variabili si richiamano senza virgolette (`var.my_ip`); tra virgolette Terraform le tratta come testo.
- Il file `.terraform.lock.hc` fissa le versioni dei provider e si committa; la cartella `.terraform` no.
- Risultato: 8 regole in ingresso create da un solo blocco (verificato in console, us-east-1).

## Scelte consapevoli (e limiti)
- La regola 443 verso l'IP dell'EIP è un esperimento didattico, non una configurazione reale: l'EIP non è associato ad alcuna istanza. Nel 01-ec2-base l'EIP viene associato all'istanza
- Egress `-1` (tutti i protocolli) verso `0.0.0.0/0`: scelta temporanea
  per semplicità. In produzione si restringe al necessario.
- Nessun tag per ora: da aggiungere nei prossimi lab.