#!/bin/sh

if [ -n "$SERVER" ] && [ -n "$TCP_PORT" ]; then
  cp /etc/syslog-ng/syslog-ng-server.conf /etc/syslog-ng/syslog-ng.conf
  sed -i "s/%TCP_PORT%/$TCP_PORT/g" /etc/syslog-ng/syslog-ng.conf
elif [ -n "$CLIENT" ] && [ -n "$SYSLOGNG_SERVER" ]  && [ -n "$TCP_PORT" ]; then
  cp /etc/syslog-ng/syslog-ng-client.conf /etc/syslog-ng/syslog-ng.conf
  sed -i "s/%SYSLOGNG_SERVER%/$SYSLOGNG_SERVER/g" /etc/syslog-ng/syslog-ng.conf
  sed -i "s/%TCP_PORT%/$TCP_PORT/g" /etc/syslog-ng/syslog-ng.conf
else
  echo >&2 'Error:  You need to specify SERVER or CLIENT and SYSLOGNG_SERVER and TCP_PORT'
	exit 1
fi

exec /usr/sbin/syslog-ng -F -f /etc/syslog-ng/syslog-ng.conf
