module "test" {
  source      = "../../modules/iam/"
  enabled     = true
  environment = "test"
  service     = "ci"
  tags = {
    test = "ABC"
  }
}

output "iam_assume_role_arn" {
  value = module.test.iam_assume_role_arn
}

output "iam_role" {
  value = module.test.iam_role
}

output "iam_group" {
  value = module.test.iam_group
}

output "iam_user" {
  value = module.test.iam_user
}

output "iam_group_policy" {
  value = module.test.iam_group_policy
}

output "aws_access_key_id" {
  value     = module.test.aws_access_key_id
  sensitive = true
}

output "aws_secret_access_key" {
  value     = module.test.aws_secret_access_key
  sensitive = true
}