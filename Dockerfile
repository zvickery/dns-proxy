FROM ubuntu:20.04 AS builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y autotools-dev bind9 cdbs debhelper devscripts dh-autoreconf dpkg-dev fakeroot gettext git libev-dev libpcre3-dev libudns-dev pkg-config && apt-get clean

RUN git clone git://github.com/dlundquist/sniproxy.git
RUN cd /sniproxy && ./autogen.sh && ./configure && make install

FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y bind9 libev4 libudns0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/sbin/sniproxy /usr/local/sbin

ADD conf/sniproxy.conf /etc/sniproxy.conf
ADD conf/named.conf.options /etc/bind/named.conf.options
ADD conf/db.override /etc/bind/db.override
ADD conf/named.conf.local /etc/bind/named.conf.local
ADD conf/zones.override /etc/bind/zones.override
ADD conf/startup.sh /

RUN chmod 775 /startup.sh && \
  mkdir /var/log/named && \
  chown root.bind /var/log/named && \
  chmod 775 /var/log/named

EXPOSE 53
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/startup.sh"]
