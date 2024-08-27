FROM alpine:latest

RUN apk --no-cache add curl

WORKDIR /app

COPY url_check.sh /app/url_check.sh

RUN chmod +x /app/url_check.sh

ENV URL_TO_CHECK="https://informatux.net"

VOLUME /app/logs

CMD ["/app/url_check.sh"]

