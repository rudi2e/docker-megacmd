FROM debian:10

ARG BUILD_DATE
#ARG BUILD_REVISION

LABEL org.opencontainers.image.title="megacmd"
#LABEL org.opencontainers.image.description=""
#LABEL org.opencontainers.image.authors=""
LABEL org.opencontainers.image.vendor="Rudi2e"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="0.1.1"
LABEL org.opencontainers.image.source="https://github.com/rudi2e/docker-megacmd"
#LABEL org.opencontainers.image.revision="$BUILD_REVISION"
LABEL org.opencontainers.image.created="$BUILD_DATE"

COPY --chown=root:root rootfs /

RUN if [ "$(uname -m)" = "x86_64" ]; then \
        download_url="https://mega.nz/linux/MEGAsync/Debian_10.0/amd64/megacmd_1.4.0-3.1_amd64.deb"; \
        #download_url="https://mega.nz/linux/repo/Debian_11/amd64/megacmd-Debian_11_amd64.deb"; \
    #elif [ "$(uname -m)" = "armv7l" ]; then \
    #    ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split; \
    #    ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb; \
    #    ln -s /bin/tar /usr/sbin/tar; \
    #    ln -s /bin/rm /usr/sbin/rm; \
    #    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"; \
    #    export TERM=linux; \
    #    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    #    download_url="https://mega.nz/linux/MEGAsync/Raspbian_10.0/armhf/megacmd_1.2.0-6.1_armhf.deb"; \
    #    #download_url="https://mega.nz/linux/repo/Debian_11/armhf/megacmd-Debian_11_armhf.deb"; \
    else \
        echo "Not supported architecture: $(uname -m)"; \
        exit 1; \
    fi \
    && chmod 755 /docker-entrypoint.sh \
    && apt-get update \
    && apt-get install -y ca-certificates curl \
    && update-ca-certificates \
    && curl -L "$download_url" -o megacmd.deb \
    && apt-get -fy install ./megacmd.deb \
    && rm megacmd.deb \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mega-cmd-server"]
