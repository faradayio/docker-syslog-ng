FROM alpine:3.7
LABEL maintainer="ivan@fabrique-it.fr"
LABEL version="3.12.1"

ENV SYSLOG_VERSION=3.12.1
ENV DOWNLOAD_URL="https://github.com/balabit/syslog-ng/releases/download/syslog-ng-${SYSLOG_VERSION}/syslog-ng-${SYSLOG_VERSION}.tar.gz"

RUN apk add --update glib openssl curl openssl-dev alpine-sdk glib-dev pcre-dev

RUN curl -L "${DOWNLOAD_URL}" | tar zx -C /tmp

RUN cd "/tmp/syslog-ng-${SYSLOG_VERSION}" \
    && ./configure --prefix=/usr && make && make install

RUN apk del curl openssl-dev alpine-sdk glib-dev pcre-dev \
    && rm -rf "/tmp/syslog-ng-${SYSLOG_VERSION}"

ADD ./syslog-ng-client.conf /etc/syslog-ng/syslog-ng-client.conf
ADD ./syslog-ng-server.conf /etc/syslog-ng/syslog-ng-server.conf

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
