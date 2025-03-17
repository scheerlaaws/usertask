# Role C - Service role (full access to S3 bucket)
resource "aws_iam_role" "roleC" {
  name = "roleC"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::593793022790:role/roleB"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "roleC_policy" {
  role = aws_iam_role.roleC.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = "arn:aws:s3:::aws-test-bucket/*"
      }
    ]
  })
}

