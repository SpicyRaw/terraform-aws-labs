# RDS con password effimera (Terraform)

Lab AWS: un database RDS la cui password **non finisce nello state di Terraform**.

## Cosa fa
- `ephemeral "random_password"` genera la password solo durante il run
- `password_wo` la passa al DB senza salvarla
- DB non pubblico e cifrato

## Come si usa
    terraform init
    terraform apply
    terraform destroy

## Cosa ho capito
- Un valore **ephemeral** non viene salvato in state o plan.
- Un attributo **write-only** (`*_wo`) lo usa senza memorizzarlo.
- Per cambiare la password si incrementa `password_wo_version`.