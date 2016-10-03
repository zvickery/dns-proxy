FROM ubuntu:16.04

RUN apt-get update && apt-get install -y autotools-dev bind9 cdbs debhelper devscripts dh-autoreconf dpkg-dev fakeroot gettext git libev-dev libpcre3-dev libudns-dev pkg-config
RUN git clone git://github.com/dlundquist/sniproxy.git
RUN cd /sniproxy && ./autogen.sh && ./configure && make install

ADD conf/sniproxy.conf /etc/sniproxy.conf
ADD conf/named.conf.options /etc/bind/named.conf.options
ADD conf/db.override /etc/bind/db.override
ADD conf/named.conf.local /etc/bind/named.conf.local
ADD conf/startup.sh /

RUN chmod 775 /startup.sh && \
  mkdir /var/log/named && \
  chown root.bind /var/log/named && \
  chmod 755 /var/log/named

EXPOSE 53
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/startup.sh"]
