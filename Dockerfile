FROM alpine:3.6

ENV LANG='en_AU.UTF-8' \
    LANGUAGE='en_AU.UTF-8'

RUN apk -U upgrade && \
    apk add --no-cache \
      wget \
      openssl \
      ca-certificates && \
\
    wget https://github.com/nzbget/nzbget/releases/download/v18.1/nzbget-18.1-bin-linux.run && \
    sh ./nzbget-18.1-bin-linux.run --destdir /nzbget && \
\
    addgroup -S media && adduser -S media -G media && \
    mkdir /movies /downloads /comics /tvseries && \
    chown -R media:media /movies/ /downloads/ /tvseries/ /comics/

EXPOSE 6789

USER media

VOLUME ["/data", "/comics", "/movies", "/tvseries"]

CMD ["/nzbget/nzbget", "-s", "-o", "FlushQueue=no", "-o", "OutputMode=loggable", "-c", "/data/nzbget.conf"]
