## Description
Create helm chart for stateful deployment

## Folder structure
```
/
└───q2
    └───Chart.yaml
    └───README.md
    └───values.yaml
    └───templates
        └───pvc.yaml
        └───services.yaml
        └───statefulset.yaml
```

| File/Folder | Usage |
| ------ | ------ |
| [Chart.yaml](./Chart.yaml) | Manifest file for litecoin helm chart|
| [README.md](./README.md) | This file |
| [values.yaml](./values.yaml) | Variable file for litecoin helm chart |
| [templates/pvc.yaml](./templates/pvc.yaml) | Kubernetes PersistentVolumeClaim yaml file |
| [templates/services.yaml](./templates/services.yaml) | Kubernetes Services yaml file |
| [templates/statefulset.yaml](./templates/statefulset.yaml) | Kubernetes Statefulset yaml file |

## Pre-requisite
Helm:
- [Helm](https://helm.sh/) - Helm Charts help you define, install, and upgrade even the most complex Kubernetes application

## Installation
```sh
helm install litecoin ./
```

## Helm Chart

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.env | string | `"dev"` | Environment variable for application |
| app.name | string | `"litecoin"` | Application name |
| image.env.LITECOIN_DATA | string | `"/home/litecoin/.litecoin"` | Default path for litecoin running files |
| image.envSecret | bool | `false` | Use Kubernetes secrets as environment variable |
| image.healthCheckEnabled | bool | `true` | Enable pod healthcheck |
| image.healthCheckMode | string | `"tcp"` | Healtcheck mode: tcp/grpc |
| image.healthCheckPort | int | `9333` | Healthcheck port  |
| image.imagePullPolicy | string | `"Always"` | Image pull policy |
| image.port.litecoin | int | `9333` | Litecoin tcp port |
| image.port.rpc | int | `9332` | Litecoin RPC port |
| image.port.testnetrpc | int | `19332` | Testnet RPC port |
| image.port.testnettcp | int | `19333` | Testnet TCP port |
| image.replicas | int | `1` | Replica numbers |
| image.repo | string | `"debu99/litecoin"` | Image repository name |
| image.resources.limits.cpu | string | `"1200m"` | CPU resource limitation |
| image.resources.limits.memory | string | `"1200Mi"` | Memory resource limitation  |
| image.resources.requests.cpu | string | `"1000m"` | Requested CPU resource |
| image.resources.requests.memory | string | `"1000Mi"` | Requested Memory resource |
| image.securityContext.fsGroup | int | `999` | fsGroup id |
| image.securityContext.runAsGroup | int | `999` | Pod run as group id |
| image.securityContext.runAsNonRoot | bool | `true` | Pod run as non root user |
| image.securityContext.runAsUser | int | `999` | Pod run as user id |
| image.tag | string | `"latest"` | Image tag name |
| pvc.accessMode | string | `"ReadWriteOnce"` | PVC access mode |
| pvc.mountPath | string | `"/home/litecoin/.litecoin"` | PVC mount path in the pod |
| pvc.size | string | `"1Gi"` | PVC size |
| pvc.storageClassName | string | `"gp2"` | Storage class name for PVC |
| service.enabled | bool | `true` | Enable service |

----------------------------------------------



