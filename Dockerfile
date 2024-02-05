FROM alpine:edge
LABEL maintainer="Julio Gutierrez protorrent.limeade106@passmail.net"

ENV XDG_CONFIG_HOME="/config" \
  XDG_DATA_HOME="/config" \
  HOME="/config" \
  QBT_WEBUI_PORT=8080 \
  S6_VERBOSITY=1

ARG S6_OVERLAY_VERSION=3.1.6.2

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz /tmp
COPY root /

RUN \
  echo "*** install s6 ***" && \
  tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
  tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
  tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz && \
  tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz && \
  echo "*** install packages ***" && \
  apk add --no-cache patch tzdata bash shadow wireguard-tools iptables libnatpmp libcap-utils qbittorrent-nox curl jq && \
  echo "*** patch wg-quick ***" && \
  patch --verbose -d / -p 0 -i /tmp/wg-quick.patch && \
  echo "**** create abc user and make our folders ****" && \
  groupmod -g 1000 -n abc users && \
  useradd -u 1000 -g 1000 -d /config -s /bin/false abc && \
  mkdir -p /config /downloads && \
  echo "*** cleanup ***" && \
  apk del --no-network --no-cache patch && \
  rm -rf /tmp/*

EXPOSE 8080
VOLUME /config
VOLUME /downloads
ENTRYPOINT [ "/init" ]
