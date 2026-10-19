# Lab 02 – Security Group base con Terraform

Creazione di un Security Group AWS gestito interamente con Terraform, con regole separate per HTTP, SSH e traffico in uscita.

## Cosa crea

HTTP SSH 

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

- Ogni cartella con file .tf è un progetto indipendente con il proprio terraform init, la propria cartella .terraform e il proprio state.
- Una regola duplicata (stesso CIDR e protocollo) viene rifiutata da AWS con `InvalidPermission.Duplicate`.
- Le variabili si richiamano senza virgolette (`var.my_ip`); tra virgolette Terraform le tratta come testo.
- Il file `.terraform.lock.hc` fissa le versioni dei provider e si committa; la cartella `.terraform` no.
