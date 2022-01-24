module "test" {
  source      = "./modules/iam/"
  enabled     = false
  environment = "test"
  service     = "ci"
}

output "iam_assume_role_arn" {
  value = module.test.iam_assume_role_arn
}

output "aws_access_key_id" {
  value = module.test.aws_access_key_id
  sensitive = true
}

output "aws_secret_access_key" {
  value = module.test.aws_secret_access_key
  sensitive = true
}