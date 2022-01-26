## Description
Create litecoin docker image

## Folder structure
```
/
└───q1
    └───docker-entrypoint.sh
    └───Dockerfile
    └───gosu.public.key
    └───imageTest.yaml
    └───litecoin.public.key
    └───README.md
    └───run.sh
```

| File/Folder | Usage |
| ------ | ------ |
| [docker-entrypoint.sh](./docker-entrypoint.sh) | Entrypoint file for docker image|
| [Dockerfile](./Dockerfile) | Docker file for litecoin |
| [gosu.public.key](./gosu.public.key) | Public key for gosu |
| [imageTest.yaml](./imageTest.yaml) | Configuration for container-structure-test |
| [litecoin.public.key](./litecoin.public.key) | Public key for litecoin |
| [README.md](./README.md) | This file |
| [run.sh](./run.sh) |  Bash script to build the image |

## Pre-requisite
Docker:
- [Docker](https://www.docker.com/) - Package Software into Standardized Units for Development, Shipment and Deployment

## Installation
```sh
bash run.sh
```

## Reference

- [docker-litecoin-core](https://github.com/uphold/docker-litecoin-core/tree/master/0.18) - Uphold debian image


## Changes

```diff
-FROM debian:stable-slim
+FROM ubuntu:20.04

-LABEL maintainer.0="João Fonseca (@joaopaulofonseca)" \
-  maintainer.1="Pedro Branco (@pedrobranco)" \
-  maintainer.2="Rui Marinho (@ruimarinho)"

+ENV LITECOIN_USER=litecoin
-RUN useradd -r litecoin \
+RUN useradd -r ${LITECOIN_USER} \
   && apt-get update -y \
-  && apt-get install -y curl gnupg \
+  && apt-get install -y curl gnupg net-tools netcat-traditional \
   && apt-get clean \
-  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
-  && set -ex \
-  && for key in \
-    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
-    FE3348877809386C \
-  ; do \
-    gpg --no-tty --keyserver pgp.mit.edu --recv-keys "$key" || \
-    gpg --no-tty --keyserver keyserver.pgp.com --recv-keys "$key" || \
-    gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
-    gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
-  done
+  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

+COPY *.public.key /
 ENV GOSU_VERSION=1.10

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
-  && gpg --verify /usr/local/bin/gosu.asc \
+  && gpg --import gosu.public.key && gpg --verify /usr/local/bin/gosu.asc \
   && rm /usr/local/bin/gosu.asc \
   && chmod +x /usr/local/bin/gosu

 ENV LITECOIN_VERSION=0.18.1
-ENV LITECOIN_DATA=/home/litecoin/.litecoin
+ENV LITECOIN_DATA=/home/${LITECOIN_USER}/.litecoin

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
  && curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
-  && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
+  && gpg --import litecoin.public.key && gpg --verify litecoin-"${LITECOIN_VERSION}"-linux-signatures.asc \
  && grep $(sha256sum litecoin-"${LITECOIN_VERSION}"-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-"${LITECOIN_VERSION}"-linux-signatures.asc \
   && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

 COPY docker-entrypoint.sh /entrypoint.sh
+RUN chmod +x /entrypoint.sh

VOLUME ["/home/litecoin/.litecoin"]
+EXPOSE 9332 9333 19332 19333
-EXPOSE 9332 9333 19332 19333 19444
+USER ${LITECOIN_USER}

 ENTRYPOINT ["/entrypoint.sh"]

 +HEALTHCHECK CMD netstat -ltn | grep -c 9083
 ```
- Change base image from debian to ubuntu 20.04 to remove vulnerabilities
- Add some network and debug tools
- Import public key locally to avoid error during build time
- Fix entrypoint.sh permission issue
- Run as normal user instead of root
- Remove [unused port](https://github.com/litecoin-project/litecoin/blob/master/doc/litecoin-release-notes/release-notes-0.10.2.2.md) from expose
- Add healthcheck for container