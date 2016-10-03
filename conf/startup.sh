#!/usr/bin/env bash

DOMAIN=${DOMAIN:-'nhl\.com'}
CLIENT_IP=${CLIENT_IP:-127.0.0.1}
LOCAL_IP=${LOCAL_IP:-127.0.0.1}
PUBLIC_IP=${PUBLIC_IP:-127.0.0.1}
EXTERNAL_DNS=${EXTERNAL_DNS:-8.8.8.8}

sed -i s/DOMAIN/${DOMAIN}/g /etc/sniproxy.conf
sed -i s/LOCAL_IP/${LOCAL_IP}/g /etc/sniproxy.conf

sed -i s/CLIENT_IP/${CLIENT_IP}/g /etc/bind/named.conf.local
sed -i s/LOCAL_IP/${LOCAL_IP}/g   /etc/bind/named.conf.local
sed -i s/PUBLIC_IP/${PUBLIC_IP}/g /etc/bind/named.conf.local

sed -i s/PUBLIC_IP/${PUBLIC_IP}/g /etc/bind/db.override

sed -i s/EXTERNAL_DNS/${EXTERNAL_DNS}/g /etc/bind/named.conf.options

/etc/init.d/bind9 start && /usr/local/sbin/sniproxy
