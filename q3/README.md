## Description
Create CICD for stateful deployment

## Folder structure
```
/
└───q3
    └───.gitlab-ci.yml
    └───docker
        └───docker-entrypoint.sh
        └───Dockerfile
        └───gosu.public.key
        └───litecoin.public.key
        └───imageTest.yaml
    └───README.md
```

| File/Folder | Usage |
| ------ | ------ |
| [.gitlab-ci.yml](./.gitlab-ci.yml) | Gitlab CICD pipeline yaml |
| [docker/docker-entrypoint.sh](./docker/docker-entrypoint.sh) | Entrypoint file for litecoin docker image |
| [docker/Dockerfile](./docker/Dockerfile) | Docker file for litecoin |
| [docker/imageTest.yaml](./docker/imageTest.yaml) | Configuration file for container-structure-test |
| [docker/gosu.public.key](./docker/gosu.public.key) | Public key for gosu |
| [docker/litecoin.public.key](./docker/litecoin.public.key) | Public key for litecoin |
| [README.md](./README.md) | This file |

## Prerequisite
ArgoCD:
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) - A declarative, GitOps continuous delivery tool for Kubernetes.

## CI
- lint: Check Dockerfile syntax error
- static_analysis: Static code scan for Dockerfile 
- build: Containerize application
- container_test: Check docker image is properly created
- local_test: Start container and do healthcheck
- image_scan: Scan image for vulnerabilities with Trivy
- push: Push to docker registry

## CD
- Deploy helm chart with ArgoCD

----------------------------------------------



