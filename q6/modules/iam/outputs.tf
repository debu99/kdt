output "iam_assume_role_arn" {
  description = "IAM assume role name created/used by this module"
  value       = var.enabled ? local.assume_role_arn : null
}

output "iam_group" {
  description = "IAM group name created/used by this module"
  value       = var.enabled ? local.group_name : null
}

output "iam_user" {
  description = "IAM user name created by this module"
  value       = var.enabled ? aws_iam_user.this[0].name : null
}

output "aws_access_key_id" {
  description = "AWS access key id created for IAM user"
  value       = var.enabled && var.create_access_key ? aws_iam_access_key.this[0].id : null
}

output "aws_secret_access_key" {
  description = "AWS secret access key created for IAM user"
  value       = var.enabled && var.create_access_key ? aws_iam_access_key.this[0].secret : null
}