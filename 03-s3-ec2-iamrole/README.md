# Lab 03 - EC2 con bucket S3 privato

Istanza EC2 raggiungibile solo via HTTP (porta 80) che carica automaticamente su un bucket S3 privato i file messi in una cartella. L'accesso al bucket usa un ruolo IAM, senza chiavi di accesso.

## Cosa crea

- Bucket S3 privato
- Security group con solo la porta 80 in ingresso
- Ruolo IAM con permessi minimi sul bucket
- Istanza EC2 con Apache e un cron che sincronizza `/srv/upload` con il bucket ogni minuto

## Il bucket è privato

Di default i bucket S3 nuovi sono privati. Ho comunque voluto scriverlo nel codice con `aws_s3_bucket_public_access_block`, così la scelta è esplicita.

## Accesso all'istanza

La porta 22 è chiusa. Si entra con Session Manager dalla console EC2 (*Connect → Session Manager*).

## Uso

terraform init
terraform apply
curl http://<ip_pubblico>


Dall'istanza:

echo "ciao" > /srv/upload/test.txt

Dopo circa un minuto il file è nel bucket. Per eliminare tutto: `terraform destroy`.

## Niente versioning e niente crittografia configurata esplicitamente (AWS cifra comunque di default con SSE-S3). Da aggiungere in un secondo momento.