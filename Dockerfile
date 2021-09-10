FROM alpine:latest

ARG VERSION=2.1.2

LABEL org.opencontainers.image.title="Unimus Core (alpine)" \
      org.opencontainers.image.authors="Andrew James" \
      org.opencontainers.image.vendor="semaja2.net" \
      org.opencontainers.image.url="https://unimus.net/" \
      org.opencontainers.image.description="Unimus Core running on Alpine" \
      org.opencontainers.image.version="${VERSION}"

ENV DOWNLOAD_URL https://download.unimus.net/unimus-core/${VERSION}/Unimus-Core.jar

RUN set -eux && \
    addgroup --system --gid 1995 unimus-core && \
    adduser --system \
            --gecos "Unimus Core" \
            --disabled-password \
            --uid 1997 \
            --ingroup unimus-core \
            --shell /sbin/nologin \
            --home /opt/unimus-core/ \
        unimus-core && \
    adduser unimus-core unimus-core && \
    mkdir -p /etc/unimus-core && \
    mkdir -p /opt/unimus-core && \
    mkdir -p /var/log/unimus-core && \
    chown --quiet -R unimus-core:root /etc/unimus-core/ && \
    chown --quiet -R unimus-core:root /var/log/unimus-core/ && \
    chown --quiet -R unimus-core:root /opt/unimus-core/ && \
    apk add --clean-protected --no-cache \
            tini \
            bash \
            curl \
            tzdata \
            openjdk11-jre-headless && \
    rm -rf /var/cache/apk/*

RUN curl -L --fail -o /opt/unimus-core/unimus-core.jar $DOWNLOAD_URL

COPY ["docker-entrypoint.sh", "/usr/bin/"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/docker-entrypoint.sh"]

USER 1997

CMD ["/bin/bash", "/opt/unimus-core/start-unimus-core.sh"]