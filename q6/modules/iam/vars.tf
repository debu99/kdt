variable "region" {
  type        = string
  description = "AWS region for provider"
  default     = "us-east-1"
}

variable "enabled" {
  type        = bool
  description = "Whether enable this module"
  default     = true
}

variable "environment" {
  type        = string
  description = "Environment name for naming convention"
}

variable "service" {
  type        = string
  description = "Service name for naming convention"
}

variable "iam_role" {
  type = object({
    create_iam_role = bool
    assume_role_arn = string
  })
  description = "Whether create iam assume role"
  default = {
    create_iam_role = true
    assume_role_arn = ""
  }

  validation {
    condition     = (var.iam_role.create_iam_role == false && var.iam_role.assume_role_arn != "") || var.iam_role.create_iam_role
    error_message = "The create_iam_role has been set to 'false' but the assume_role_arn has not be defined."
  }
}

variable "iam_group" {
  type = object({
    create_iam_group = bool
    group_name       = string
  })
  description = "Whether create iam group"
  default = {
    create_iam_group = true
    group_name       = ""
  }

  validation {
    condition     = (var.iam_group.create_iam_group == false && var.iam_group.group_name != "") || var.iam_group.create_iam_group
    error_message = "The create_iam_group has been set to 'false' but the group_name has not be defined."
  }
}

variable "create_access_key" {
  type        = bool
  description = "Whether create AWS access key for user"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Tags for all resources in this module"
  default     = {}
}
