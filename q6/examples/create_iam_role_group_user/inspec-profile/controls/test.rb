content = inspec.profile.file("output.json")
params = JSON.parse(content)

iam_group_name = params['iam_group']['value']
iam_user_name = params['iam_user']['value']
iam_role_name = params['iam_role']['value']
iam_assume_role_arn = params['iam_assume_role_arn']['value']
iam_group_policy = params['iam_group_policy']['value']

# ${var.environment}-${var.service}-role
describe aws_iam_role(role_name: iam_role_name) do
    it { should exist }
    its('assume_role_policy_document') { should_not be_empty }
    its('assume_role_policy_document') { should include CGI::escape('"Action":"sts:AssumeRole"')}
    its('assume_role_policy_document') { should include CGI::escape('"Effect":"Allow"')}
    its('assume_role_policy_document') { should include CGI::escape(iam_assume_role_arn.split(':').reverse.drop(1).reverse.join(':') + ':root')}
end

# ${var.environment}-${var.service}-user
describe aws_iam_user(iam_user_name) do
  it { should exist }
end

# ${var.environment}-${var.service}-group
describe aws_iam_group(group_name: iam_group_name) do
  it { should exist }
  its('users') { should include iam_user_name}
end

# ${var.environment}-${var.service}-group-policy
describe aws_iam_inline_policy(group_name: iam_group_name, policy_name: iam_group_policy) do
  it { should exist }
  it { should have_statement(Action: 'sts:AssumeRole', Effect: 'Allow', Resource: iam_assume_role_arn) }
end

 
