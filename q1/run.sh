#!/bin/bash
set -e

IMAGE_NAME=debu99/litecoin
IMAGE_TAG=0.0.1

docker run --rm -i -v $PWD:/app --entrypoint /bin/hadolint hadolint/hadolint -t error /app/Dockerfile

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ${IMAGE_NAME}:${IMAGE_TAG}

container-structure-test test --image ${IMAGE_NAME}:${IMAGE_TAG} -c ./imageTest.yaml

docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest

docker push ${IMAGE_NAME}:${IMAGE_TAG}
docker push ${IMAGE_NAME}:latest