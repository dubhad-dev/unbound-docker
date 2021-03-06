FROM debian:10.6 AS build

ARG UNBOUND_VERSION=1.12.0

WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      build-essential \
      libssl-dev \
      libexpat1-dev \
      libldns-dev \
      libevent-dev \
      libnghttp2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O unbound.tar.gz https://nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz --progress=dot:giga \
    && tar -xzf unbound.tar.gz --strip 1 \
    && ./configure --with-libevent --with-libnghttp2 \
    && make install


FROM debian:10.6 AS run

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      openssl \
      libevent-2.1-6 \
      libexpat1 \
      gettext-base \
      ldnsutils \
      libnghttp2-14 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/sbin/unbound* /usr/local/sbin/
COPY --from=build /usr/local/lib/libunbound* /usr/local/lib/
RUN ldconfig

WORKDIR /usr/local/etc/unbound

RUN useradd -Urs /usr/bin/nologin unbound

RUN wget -O root.hints https://www.internic.net/domain/named.cache --progress=dot:giga

COPY unbound.conf.template templates/unbound.conf.template

RUN mkdir conf && mkdir -m 700 var && \
      chown unbound:unbound var && \
      unbound-anchor -a var/root.key || :

ENV THREADS=1
ENV SLABS=1

RUN mkdir /docker-entrypoint.d
COPY docker-entrypoint.sh /
COPY 20-envsubst-on-templates.sh /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 853/tcp
EXPOSE 853/udp
EXPOSE 443/tcp

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["unbound"]