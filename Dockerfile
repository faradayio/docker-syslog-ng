FROM alpine:3.8
LABEL maintainer="seamus@abshere.net"
LABEL version="3.17.2"

ENV SYSLOG_VERSION=3.17.2
ENV DOWNLOAD_URL="https://github.com/balabit/syslog-ng/releases/download/syslog-ng-${SYSLOG_VERSION}/syslog-ng-${SYSLOG_VERSION}.tar.gz"

RUN apk add --update glib openssl curl openssl-dev alpine-sdk glib-dev pcre-dev

RUN curl -sSL "${DOWNLOAD_URL}" | tar zx -C /tmp

RUN cd "/tmp/syslog-ng-${SYSLOG_VERSION}" \
    && ./configure --prefix=/usr && make && make install

RUN apk del curl openssl-dev alpine-sdk glib-dev pcre-dev \
    && rm -rf "/tmp/syslog-ng-${SYSLOG_VERSION}"

ADD ./syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

CMD ["/usr/sbin/syslog-ng", "-F", "-f", "/etc/syslog-ng/syslog-ng.conf"]

# ADD ./entrypoint.sh /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
