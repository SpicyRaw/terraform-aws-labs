resource "aws_s3_bucket" "this" {
  bucket        = "lab03-bucket-privato-eduard" #deve essere unico in tutto AWS
  force_destroy = true                          #permette il destroy anche con file dentro

}

#Di default il bucket è già privato, ma lo scrivo nel codice per renderlo esplicito
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}