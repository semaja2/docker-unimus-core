FROM alpine:latest

LABEL org.opencontainers.image.title="Unimus Core (alpine)" \
      org.opencontainers.image.authors="Andrew James" \
      org.opencontainers.image.vendor="semaja2.net" \
      org.opencontainers.image.url="https://unimus.net/" \
      org.opencontainers.image.description="Unimus Core running on Alpine" \
      org.opencontainers.image.licenses="GPL v2.0"

ENV DOWNLOAD_URL https://download.unimus.net/unimus-core/-%20Latest/Unimus-Core.jar

RUN set -eux && \
    addgroup --system --gid 1995 unimus-core && \
    adduser --system \
            --gecos "Unimus Core" \
            --disabled-password \
            --uid 1997 \
            --ingroup unimus-core \
            --shell /sbin/nologin \
            --home /var/lib/unimus-core/ \
        unimus-core && \
    adduser unimus-core unimus-core && \
    mkdir -p /etc/unimus-core && \
    mkdir -p /var/lib/unimus-core && \
    mkdir -p /var/log/unimus-core && \
    chown --quiet -R unimus-core:unimus-core /etc/unimus-core/ /var/log/unimus-core/ /var/lib/unimus-core/ && \
   apk add --clean-protected --no-cache \
            tini \
            bash \
            curl \
            tzdata \
            openjdk11-jre-headless && \
    rm -rf /var/cache/apk/*

RUN curl -L -o /opt/unimus-core.jar $DOWNLOAD_URL

COPY ["docker-entrypoint.sh", "/usr/bin/"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/docker-entrypoint.sh"]

USER 1997

CMD ["/usr/bin/java", "-jar", "/opt/unimus-core.jar"]