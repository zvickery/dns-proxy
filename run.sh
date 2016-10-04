#!/usr/bin/env bash

export CLIENT_IP=127.0.0.1
export LOCAL_IP=127.0.0.1
export PUBLIC_IP=127.0.0.1

docker run \
  -it \
  -p ${LOCAL_IP}:80:80 \
  -p ${LOCAL_IP}:443:443 \
  -p ${LOCAL_IP}:53:53/udp \
  -e "CLIENT_IP=${CLIENT_IP}" \
  -e "LOCAL_IP=${LOCAL_IP}" \
  -e "PUBLIC_IP=${PUBLIC_IP}" \
  --entrypoint bash \
  zdvickery/dns-proxy
