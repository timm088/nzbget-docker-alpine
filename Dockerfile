FROM python:3.8-alpine

RUN apk -U upgrade && \
    apk add --no-cache \
    wget \
    openssl \
    curl \
    ca-certificates \
    git \
    p7zip \
    ffmpeg \
    tzdata \
    openssl \
    libxml2 \
    libxml2-dev \
    libxslt \
    libxslt-dev \
    musl-dev \
    gcc && \
    \
    pip install --no-cache-dir \
    lxml && \
    \
    wget https://github.com/nzbget/nzbget/releases/download/v21.0/nzbget-21.0-bin-linux.run && \
    sh ./nzbget-21.0-bin-linux.run --destdir /nzbget && \
    \
    cd /nzbget/scripts && \
    git clone --depth=1 https://github.com/clinton-hall/nzbToMedia && \
    \
    adduser -u 1001 -S media -G users && \
    mkdir /movies /downloads /comics /tvseries && \
    chown -R media:users /movies/ /downloads/ /tvseries/ /comics/ /nzbget/ && \
    \
    apk del \
    gcc \
    libxml2-dev \
    libxslt-dev \
    wget \
    musl-dev

EXPOSE 6789

USER media

VOLUME ["/data", "/comics", "/movies", "/tvseries"]

CMD ["/nzbget/nzbget", "-s", "-o", "FlushQueue=no", "-o", "OutputMode=loggable", "-c", "/data/nzbget.conf"]
