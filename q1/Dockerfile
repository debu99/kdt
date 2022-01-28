FROM ubuntu:20.04

ENV LITECOIN_USER=litecoin
RUN useradd -r ${LITECOIN_USER} \
  && apt-get update -y \
  && apt-get install -y curl gnupg net-tools netcat-traditional \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY *.public.key /
ENV GOSU_VERSION=1.10
RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/"${GOSU_VERSION}"/gosu-$(dpkg --print-architecture) \
  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/"${GOSU_VERSION}"/gosu-$(dpkg --print-architecture).asc \
  && gpg --import gosu.public.key && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_DATA=/home/${LITECOIN_USER}/.litecoin

RUN curl -SLO https://download.litecoin.org/litecoin-"${LITECOIN_VERSION}"/linux/litecoin-"${LITECOIN_VERSION}"-x86_64-linux-gnu.tar.gz \
  && curl -SLO https://download.litecoin.org/litecoin-"${LITECOIN_VERSION}"/linux/litecoin-"${LITECOIN_VERSION}"-linux-signatures.asc \
  && gpg --import litecoin.public.key && gpg --verify litecoin-"${LITECOIN_VERSION}"-linux-signatures.asc \
  && grep $(sha256sum litecoin-"${LITECOIN_VERSION}"-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-"${LITECOIN_VERSION}"-linux-signatures.asc \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz && mkdir -p "${LITECOIN_DATA}" && chmod 770 "${LITECOIN_DATA}" && chown -R "${LITECOIN_USER}" "${LITECOIN_DATA}"

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/home/${LITECOIN_USER}/.litecoin"]

EXPOSE 9332 9333 19332 19333

USER ${LITECOIN_USER}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]

HEALTHCHECK CMD netstat -ltn | grep -c 9332
