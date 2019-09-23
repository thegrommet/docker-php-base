FROM alpine

ENV VARNISH_VERSION 6.0.4
ENV VARNISH_SRC_URL https://varnish-cache.org/_downloads
ENV VARNISH_SHA256 3fbafc49b043c3e3852f6d889f0fee8058d958397345756efc12bb22b0b7598d

ENV VARNISH_MODULES_VERSION 0.15.0
ENV VMOD_QUERYSTRING_VERSION 2.0.1

ENV VARNISH_MEMORY 32M
ENV VARNISH_PORT 6081

RUN set -eux; \
  addgroup -S varnish; \
  for user in varnish vcache; do \
    adduser -S -G varnish $user; \
  done

# dependencies required for building VMOD (Varnish modules)
ENV VMOD_BUILD_DEPS \
    autoconf \
    # autoconf-archive \
    automake \
    libtool \
    make \
    pkgconf \
    python3 \
    file \
    py-docutils

# persistent / runtime deps
RUN apk add --no-cache --virtual .persistent-deps \
    gcc \
    libgcc \
    libc-dev

COPY *.patch /build/varnish-patches/

WORKDIR /build

RUN set -eux; \
  \
  fetchDeps=' \
    ca-certificates \
    curl \
  '; \
  buildDeps=" \
    $VMOD_BUILD_DEPS \
    coreutils \
    dpkg \
    dpkg-dev \
    libedit-dev \
    libexecinfo-dev \
    linux-headers \
    ncurses-dev \
    patch \
    pcre-dev \
  "; \
  apk add --no-cache --virtual .build-deps $fetchDeps $buildDeps; \
  \
  curl -sfSL "$VARNISH_SRC_URL/varnish-$VARNISH_VERSION.tgz" -o varnish.tgz; \
  \
  if [ -n "$VARNISH_SHA256" ]; then \
    echo "$VARNISH_SHA256 varnish.tgz" | sha256sum -c -; \
  fi; \
  \
  mkdir -p varnish; \
  tar -zxf varnish.tgz -C varnish --strip-components=1; \
  \
  cd varnish; \
  for p in /build/varnish-patches/*.patch; do \
    [ -f "$p" ] || continue; \
    patch -p1 -i "$p"; \
  done; \
  gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
  ./autogen.sh; \
  ./configure \
    --build="$gnuArch" \
    --without-jemalloc \
    --with-sphinx-build=$(command -v true) \
  ; \
  make -j "$(nproc)"; \
  make install; \
  mkdir -p /etc/varnish; \
  install -c -m 0644 -o varnish -g varnish etc/example.vcl /etc/varnish/default.vcl; \
  \
  varnishd -V; \
  \
  curl -sfSL "https://github.com/varnish/varnish-modules/archive/$VARNISH_MODULES_VERSION.tar.gz" -o varnish-modules.tgz; \
  mkdir varnish-modules; \
  tar xzf varnish-modules.tgz -C varnish-modules --strip-components 1; \
  cd varnish-modules; \
  ./bootstrap; \
  ./configure; \
  make -j "$(nproc)"; \
  make install; \
  \
  cd /build; \
  curl -sfSL "https://github.com/Dridi/libvmod-querystring/releases/download/v$VMOD_QUERYSTRING_VERSION/vmod-querystring-$VMOD_QUERYSTRING_VERSION.tar.gz" -o vmod-querystring.tgz; \
  mkdir vmod-querystring; \
  tar xzf vmod-querystring.tgz -C vmod-querystring --strip-components 1; \
  cd vmod-querystring; \
  ./configure; \
  make -j "$(nproc)"; \
  make install; \
  \
  cd  /; \
  rm -rf /build /usr/local/include; \
  \
  runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
      | tr ',' '\n' \
      | sort -u \
      | awk 'system("[ -e /usr/local/lib/" $1 " ] || [ -e /usr/local/lib/varnish/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )"; \
  apk add --no-cache --virtual .varnish-rundeps $runDeps; \
  \
  apk del .build-deps; \
  rm -rf /var/cache/apk/* /usr/local/var/varnish/*

WORKDIR /

RUN chown -R varnish:varnish /usr/local/var/varnish

ADD ./entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

EXPOSE 6081

ENTRYPOINT ["/entrypoint"]
