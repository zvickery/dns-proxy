#!/usr/bin/env bash

export CLIENT_IP=$(dig +short zdvickery.us)
export LOCAL_IP=$(hostname -i)
export PUBLIC_IP=$(curl -sL -4 icanhazip.com)

set -x

sed "s/SRC_IP/$CLIENT_IP/" iptables-zdv > iptables-tmp
sudo iptables-restore < iptables-tmp
docker stop $(docker ps -q)

docker run \
  -d \
  -p ${LOCAL_IP}:80:80 \
  -p ${LOCAL_IP}:443:443 \
  -p ${LOCAL_IP}:53:53/udp \
  -e "CLIENT_IP=${CLIENT_IP}" \
  -e "LOCAL_IP=${LOCAL_IP}" \
  -e "PUBLIC_IP=${PUBLIC_IP}" \
  zdvickery/dns-proxy
