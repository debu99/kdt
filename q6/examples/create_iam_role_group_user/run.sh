#!/bin/bash

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
