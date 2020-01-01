FROM alpine:3.11

RUN apk -U upgrade && \
    apk add --no-cache \
    wget \
    openssl \
    curl \
    ca-certificates \
    git \
    p7zip \
    ffmpeg \
    python \
    py3-pip \
    tzdata \
    py3-openssl py3-lxml && \
    \
    ln -s -f /usr/bin/python3 /usr/bin/python && \
    \
    wget https://github.com/nzbget/nzbget/releases/download/v21.0/nzbget-21.0-bin-linux.run && \
    sh ./nzbget-21.0-bin-linux.run --destdir /nzbget && \
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
