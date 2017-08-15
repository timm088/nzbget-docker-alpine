FROM alpine:3.6

ENV LANG='en_AU.UTF-8' \
    LANGUAGE='en_AU.UTF-8'

RUN apk -U upgrade && \
    apk add --no-cache \
      wget \
      openssl \
      curl \
      ca-certificates \
      git \
      python \
      py2-pip \
      py2-openssl py-libxml2 py2-lxml && \
\
    wget https://github.com/nzbget/nzbget/releases/download/v18.1/nzbget-18.1-bin-linux.run && \
    sh ./nzbget-18.1-bin-linux.run --destdir /nzbget && \
\
    cd /nzbget/scripts && \
    git clone --depth=1 https://github.com/clinton-hall/nzbToMedia && \
\
    adduser -u 1001 -S media -G users && \
    mkdir /movies /downloads /comics /tvseries && \
    chown -R media:users /movies/ /downloads/ /tvseries/ /comics/ /nzbget/

EXPOSE 6789

USER media

VOLUME ["/data", "/comics", "/movies", "/tvseries"]

CMD ["/nzbget/nzbget", "-s", "-o", "FlushQueue=no", "-o", "OutputMode=loggable", "-c", "/data/nzbget.conf"]
