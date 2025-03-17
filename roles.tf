# Role A - Admin role (deny IAM access)
resource "aws_iam_role" "roleA" {
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "roleA_policy" {
  role = aws_iam_role.roleA.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      },
      {
        Effect   = "Deny",
        Action   = ["iam:*"],
        Resource = "*"
      }
    ]
  })
}

# Role B - Service role (assume roleC in account 1111111111)
resource "aws_iam_role" "roleB" {
  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ecs.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "roleB_policy" {
  role = aws_iam_role.roleB.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::1111111111:role/roleC"
      }
    ]
  })
}
