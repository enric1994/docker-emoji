FROM alpine:3.8

MAINTAINER Enric Moreu <enric.moreu.filella@gmail.com>

RUN apk update \
&& apk add jq \
&& rm -rf /var/cache/apk/*

COPY get_emoji.sh /src/get_emoji.sh
COPY emoji_db.json /src/emoji_db.json

ENTRYPOINT ["/src/get_emoji.sh"]
