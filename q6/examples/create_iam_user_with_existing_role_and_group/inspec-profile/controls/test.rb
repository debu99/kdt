content = inspec.profile.file("output.json")
params = JSON.parse(content)

iam_group_name = params['iam_group']['value']
iam_user_name = params['iam_user']['value']
iam_assume_role_arn = params['iam_assume_role_arn']['value']

# ${var.environment}-${var.service}-user
describe aws_iam_user(iam_user_name) do
  it { should exist }
end

# ${var.environment}-${var.service}-group
describe aws_iam_group(group_name: iam_group_name) do
  it { should exist }
  its('users') { should include iam_user_name}
end
 
