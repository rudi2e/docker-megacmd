FROM debian:11

LABEL maintainer="rudi2e"
LABEL title="megacmd"
LABEL version="0.1.0"
LABEL description=""

ARG PUID=1000
ARG PGID=1000

RUN apt-get update \
 && apt-get install -y ca-certificates curl \
 && curl "https://mega.nz/linux/MEGAsync/Debian_11/amd64/megacmd-Debian_11_amd64.deb" -o megacmd-Debian_11_amd64.deb \
 && apt-get install -y ./megacmd-Debian_11_amd64.deb \
 && rm megacmd-Debian_11_amd64.deb \
 && apt-get clean \
 && groupadd -g $PGID mega \
 && useradd -ms /bin/bash -u ${PUID} -g mega mega

CMD ["mega-cmd-server"]
