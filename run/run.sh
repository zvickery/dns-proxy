#!/usr/bin/env bash

export CLIENT_IP=127.0.0.1
export LOCAL_IP=127.0.0.1
export PUBLIC_IP=127.0.0.1

set -x

sed "s/SRC_IP/$CLIENT_IP/" iptables-zdv > iptables-tmp
sudo iptables-restore < iptables-tmp
docker stop $(docker ps -q) || true

docker run \
  -d \
  -p ${LOCAL_IP}:80:80 \
  -p ${LOCAL_IP}:443:443 \
  -p ${LOCAL_IP}:53:53/udp \
  -e "CLIENT_IP=${CLIENT_IP}" \
  -e "LOCAL_IP=${LOCAL_IP}" \
  -e "PUBLIC_IP=${PUBLIC_IP}" \
  zdvickery/dns-proxy
