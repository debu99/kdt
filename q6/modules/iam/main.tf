provider "aws" {
  region = var.region
}

locals {
  name = "${var.environment}-${var.service}"
  tags = merge(var.tags, {
    "Environment" = var.environment
    "Service"     = var.service
  })
  assume_role_arn = (var.iam_role.create_iam_role == false || var.enabled == false) ? var.iam_role.assume_role_arn : aws_iam_role.this[0].arn
  group_name      = (var.iam_group.create_iam_group == false || var.enabled == false) ? var.iam_group.group_name : aws_iam_group.this[0].name
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.enabled && var.iam_role.create_iam_role ? 1 : 0
  name               = "${local.name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = local.tags
}

resource "aws_iam_group" "this" {
  count = var.enabled && var.iam_group.create_iam_group ? 1 : 0
  name  = "${local.name}-group"
}

resource "aws_iam_group_policy" "this" {
  count = var.enabled && var.iam_group.create_iam_group ? 1 : 0
  name  = "${local.name}-group-policy"
  group = local.group_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "${local.assume_role_arn}"
      },
    ]
  })
}

resource "aws_iam_user" "this" {
  count = var.enabled ? 1 : 0
  name  = "${local.name}-user"

  tags = local.tags
}

resource "aws_iam_user_group_membership" "this" {
  count = var.enabled ? 1 : 0
  user  = aws_iam_user.this[0].name

  groups = [
    local.group_name
  ]
}

resource "aws_iam_access_key" "this" {
  count = var.enabled && var.create_access_key ? 1 : 0
  user  = aws_iam_user.this[0].name
}

resource "aws_iam_policy" "test_policy" {
  count       = var.enabled && var.iam_role.create_iam_role ? 1 : 0
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  count      = var.enabled && var.iam_role.create_iam_role ? 1 : 0
  role       = split("/", local.assume_role_arn)[1]
  policy_arn = aws_iam_policy.test_policy[0].arn
}


