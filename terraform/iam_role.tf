resource "aws_iam_policy" "apprunner_cloudwatch_full_access" {
  name        = "${ var.prefix }-apprunner-cloudwatch-full-access"
  description = "IAM policy for App Runner with CloudWatchFullAccess permissions"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "autoscaling:Describe*",
          "cloudwatch:*",
          "logs:*",
          "sns:*",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "oam:ListSinks"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "apprunner_role" {
  name               = "${ var.prefix }-apprunner-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "apprunner_policy_attachment" {
  name       = "${ var.prefix }-apprunner-cloudwatch-full-access-attachment"
  policy_arn = aws_iam_policy.apprunner_cloudwatch_full_access.arn
  roles      = [aws_iam_role.apprunner_role.name]
}
