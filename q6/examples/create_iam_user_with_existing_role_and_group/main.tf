module "test" {
  source  = "../../modules/iam"
  enabled = true
  iam_role = {
    create_iam_role = false
    assume_role_arn = "arn:aws:iam::389154786661:role/test-ci-role"
  }
  iam_group = {
    create_iam_group = false
    group_name       = "test-ci-group"
  }
  create_access_key = false
  environment       = "test"
  service           = "ci2"
  tags = {
    test = "1234"
  }
}

output "iam_assume_role_arn" {
  value = module.test.iam_assume_role_arn
}

output "iam_group" {
  value = module.test.iam_group
}

output "iam_user" {
  value = module.test.iam_user
}

output "aws_access_key_id" {
  value     = module.test.aws_access_key_id
  sensitive = true
}

output "aws_secret_access_key" {
  value     = module.test.aws_secret_access_key
  sensitive = true
}
