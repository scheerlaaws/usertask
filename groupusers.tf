resource "aws_iam_group" "group1" {
  name = "group1"
}

resource "aws_iam_group" "group2" {
  name = "group2"
}

# Policies for group1 (CLI Access Only)
resource "aws_iam_group_policy" "group1_policy" {
  group = aws_iam_group.group1.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["ec2:Describe*", "s3:List*"],
        Resource = "*"
      }
    ]
  })
}

# Policies for group2 (Full Access)
resource "aws_iam_group_policy" "group2_policy" {
  group = aws_iam_group.group2.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

# Users
resource "aws_iam_user" "engine" {
  name = "engine"
}

resource "aws_iam_user" "ci" {
  name = "ci"
}

resource "aws_iam_user" "john_doe" {
  name = "JohnDoe"
}

resource "aws_iam_user" "aboubacar_maina" {
  name = "AboubacarMaina"
}

# Attach users to groups
resource "aws_iam_user_group_membership" "group1_membership" {
  user = aws_iam_user.engine.name
  groups = [
    aws_iam_group.group1.name
  ]
}

resource "aws_iam_user_group_membership" "group1_membership_ci" {
  user = aws_iam_user.ci.name
  groups = [
    aws_iam_group.group1.name
  ]
}

resource "aws_iam_user_group_membership" "group2_membership_john" {
  user = aws_iam_user.john_doe.name
  groups = [
    aws_iam_group.group2.name
  ]
}

resource "aws_iam_user_group_membership" "group2_membership_aboubacar" {
  user = aws_iam_user.aboubacar_maina.name
  groups = [
    aws_iam_group.group2.name
  ]
}
