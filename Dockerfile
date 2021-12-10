FROM centos:centos8

ENV SHIBBOLETH_VERSION=3.2.3-3.1.x86_64
ENV SERVER_NAME=shibboleth-sp.com

RUN curl --output /etc/yum.repos.d/security:shibboleth.repo  \
    https://download.opensuse.org/repositories/security:/shibboleth/CentOS_8/security:shibboleth.repo \
    && dnf install -y mc vim net-tools httpd mod_ssl shibboleth-$SHIBBOLETH_VERSION

COPY httpd-shibd-foreground.sh /usr/local/bin/
COPY shibboleth/ /etc/shibboleth/

RUN sed -i "s/#ServerName www.example.com:80/ServerName $SERVER_NAME:443/" /etc/httpd/conf/httpd.conf
RUN /usr/libexec/httpd-ssl-gencerts

EXPOSE 80 443

CMD ["httpd-shibd-foreground.sh"]
