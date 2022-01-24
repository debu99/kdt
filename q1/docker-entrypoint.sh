#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for litecoind"

  set -- litecoind "$@"
fi

if [ -z $LITECOIN_DATA ]; then
  export LITECOIN_DATA=/home/`whoami`/.litecoin
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "litecoind" ]; then
  set -- "$@" -datadir="$LITECOIN_DATA"
fi

if [ "$(id -u)" = "0" ] && ([ "$1" = "litecoind" ] || [ "$1" = "litecoin-cli" ] || [ "$1" = "litecoin-tx" ]); then
  set -- gosu litecoin "$@"
fi

exec "$@"