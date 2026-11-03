resource "aws_iam_role" "ec2_s3" {
    name = "lab03-ec2-s3-role"

     assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

#I permessi: solo su questo bucket

resource "aws_iam_role_policy" "s3_access" {
  name = "lab03-s3-access"
  role = aws_iam_role.ec2_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = aws_s3_bucket.this.arn
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject", "s3:GetObject"]
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

# Permette di entrare nell'istanza dalla console senza aprire la porta 22
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_s3.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Collega il ruolo all'istanza
resource "aws_iam_instance_profile" "ec2_s3" {
  name = "lab03-ec2-s3-profile"
  role = aws_iam_role.ec2_s3.name
}