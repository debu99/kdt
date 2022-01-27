#!/bin/bash

REGION="ap-southeast-1"

terraform fmt
terraform validate
terraform init

docker run --rm -v $(pwd)/../..:/data -w /data/examples/`basename "$PWD"` -t ghcr.io/terraform-linters/tflint init
docker run --rm -v $(pwd)/../..:/data -w /data/examples/`basename "$PWD"` -t ghcr.io/terraform-linters/tflint

docker run --tty -v $(pwd)/../..:/data bridgecrew/checkov --directory /data
docker run --rm -it -v $(pwd)/../..:/data aquasec/tfsec /data

terraform plan
read -p "Press any key to resume ..."
terraform apply

#docker run -it -v $PWD:/app -v $HOME/.aws:/root/.aws -w /app --rm chef/inspec:4.52.9 init profile --platform aws inspec-profile --chef-license=accept
mkdir -p inspec-profile/files
terraform output --json > inspec-profile/files/output.json 
docker run -it -v $PWD:/app -v $HOME/.aws:/root/.aws -w /app --rm chef/inspec:4.52.9 exec inspec-profile -t aws://${REGION}/rnd --chef-license=accept