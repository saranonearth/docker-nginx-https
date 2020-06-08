#!/bin/sh


if [[ ! -f /usr/share/nginx/certificates/fullchain.pem ]];then
    mkdir -p /usr/share/nginx/certificates
fi


if [[ ! -f /usr/share/nginx/certificates/fullchain.pem ]]; then
    openssl genrsa -out /usr/share/nginx/certificates/privkey.pem 4096
    sl genrsa -out /usr/share/nginx/certificates/privkey.pem 4096
    openssl req -new -key /usr/share/nginx/certificates/privkey.pem -out /usr/share/nginx/certificates/cert.csr -nodes -subj \
    "/C=PT/ST=World/L=World/O=${DOMAIN:-dev.com}/OU=dev/CN=${DOMAIN:-dev.com}/EMAIL=${EMAIL:-onearth@gmail.com}"
    openssl x509 -req -days 365 -in /usr/share/nginx/certificates/cert.csr -signkey /usr/share/nginx/certificates/privkey.pem -out /usr/share/nginx/certificates/fullchain.pem
fi


$(while :; do /opt/certbot.sh; sleep "${RENEW_INTERVAL:-12h}"; done;) &


$(while inotifywait -e close_write /usr/share/nginx/certificates; do nginx -s reload; done) &

nginx -g "daemon off;"
