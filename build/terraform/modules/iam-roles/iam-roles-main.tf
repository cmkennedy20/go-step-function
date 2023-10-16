
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_execution_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "kms_policy" {
  name        = "kms_policy"
  description = "KMS Policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr_policy"
  description = "ECR Policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "attach-ec2-policy" {
  name       = "ec2-sg-policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "task_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_execution_policy.json
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role-arn"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

output "task_policy" {
  value       = aws_iam_role.ecs_execution_role
  description = "execution_role"
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}