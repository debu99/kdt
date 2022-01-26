## Description

This terraform module is used to create IAM assume role and IAM group that able to assume that role, and then a IAM user is created within that IAM group

## Folder Structure

```
/
│   README.md
└───modules
    └───iam
        └───main.tf
        └───outputs.tf
        └───vars.tf
        └───version.tf
        └───run.sh
└───examples
    └───create_iam_role_group_user
        └───main.tf
        └───.tflint.tf
        └───run.sh
    └───create_iam_user_with_existing_role_and_group
        └───main.tf
        └───.tflint.tf
        └───run.sh
```

| File/Folder | Usage |
| ------ | ------ |
| [README.md](./README.md) | This file |
| [modules/iam/main.tf](./modules/iam/main.tf) | Main code for the Terraform module |
| [modules/iam/outputs.tf](./modules/iam/outputs.tf) | Outputs for the Terraform module |
| [modules/iam/vars.tf](./modules/iam/vars.tf) | Inputs for the Terraform module |
| [modules/iam/version.tf](./modules/iam/version.tf) | Version definition for the Terraform module |
| [modules/iam/run.sh](./modules/iam/run.sh) | Bash script to check the syntax error |
| [examples/create_iam_role_group_user/main.tf](./examples/create_iam_role_group_user/main.tf) | Example file that create IAM assume role, group and user with the module |
| [examples/create_iam_role_group_user/.tflint.tf](./examples/create_iam_role_group_user/.tflint.tf) | Config file for tflint |
| [examples/create_iam_role_group_user/run.sh](./examples/create_iam_role_group_user/run.sh) | Bash script to run the terraform |
| [examples/create_iam_user_with_existing_role_and_group/main.tf](./examples/create_iam_user_with_existing_role_and_group/main.tf) | Example file that only create IAM user with the module |
| [examples/create_iam_user_with_existing_role_and_group/.tflint.tf](./examples/create_iam_user_with_existing_role_and_group/.tflint.tf) | Config file for tflint |
| [examples/create_iam_user_with_existing_role_and_group/run.sh](./examples/create_iam_user_with_existing_role_and_group/run.sh) | Bash script to run the terraform |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_policy.test_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.test_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_access\_key | Whether create AWS access key for user | `bool` | `true` | no |
| enabled | Whether enable this module | `bool` | `true` | no |
| environment | Environment name for naming convention | `string` | n/a | yes |
| iam\_group | Whether create iam group | ```object({ create_iam_group = bool group_name = string })``` | ```{ "create_iam_group": true, "group_name": "" }``` | no |
| iam\_role | Whether create iam assume role | ```object({ create_iam_role = bool assume_role_arn = string })``` | ```{ "assume_role_arn": "", "create_iam_role": true }``` | no |
| region | AWS region for provider | `string` | `"us-east-1"` | no |
| service | Service name for naming convention | `string` | n/a | yes |
| tags | Tags for all resources in this module | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_access\_key\_id | AWS access key id created for IAM user |
| aws\_secret\_access\_key | AWS secret access key created for IAM user |
| iam\_assume\_role\_arn | IAM assume role name created/used by this module |
| iam\_group | IAM group name created/used by this module |
| iam\_user | IAM user name created by this module |

## How to run

```
terraform init
terraform plan
terraform apply
```
