#!/usr/bin/env bash

DOMAIN1=${DOMAIN1:-'nhl.com'}
DOMAIN2=${DOMAIN2:-'mlb.com'}
DOMAIN3=${DOMAIN3:-'mlb.tv'}
DOMAIN4=${DOMAIN4:-'nhl.tv'}
CLIENT_IP=${CLIENT_IP:-127.0.0.1}
LOCAL_IP=${LOCAL_IP:-127.0.0.1}
PUBLIC_IP=${PUBLIC_IP:-127.0.0.1}
EXTERNAL_DNS=${EXTERNAL_DNS:-8.8.8.8}

sed -i s/DOMAIN1/${DOMAIN1}/g /etc/sniproxy.conf
sed -i s/DOMAIN2/${DOMAIN2}/g /etc/sniproxy.conf
sed -i s/DOMAIN3/${DOMAIN3}/g /etc/sniproxy.conf
sed -i s/DOMAIN4/${DOMAIN4}/g /etc/sniproxy.conf
sed -i '/\*/s/\./\\\./g' /etc/sniproxy.conf

sed -i s/DOMAIN1/${DOMAIN1}/g /etc/bind/zones.override
sed -i s/DOMAIN2/${DOMAIN2}/g /etc/bind/zones.override
sed -i s/DOMAIN3/${DOMAIN3}/g /etc/bind/zones.override
sed -i s/DOMAIN4/${DOMAIN4}/g /etc/bind/zones.override

sed -i s/CLIENT_IP/${CLIENT_IP}/g /etc/bind/named.conf.local
sed -i s/LOCAL_IP/${LOCAL_IP}/g   /etc/bind/named.conf.local
sed -i s/PUBLIC_IP/${PUBLIC_IP}/g /etc/bind/named.conf.local

sed -i s/PUBLIC_IP/${PUBLIC_IP}/g /etc/bind/db.override

sed -i s/EXTERNAL_DNS/${EXTERNAL_DNS}/g /etc/bind/named.conf.options

/etc/init.d/named start && /usr/local/sbin/sniproxy -f
