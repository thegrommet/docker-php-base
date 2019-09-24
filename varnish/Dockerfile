FROM alpine:3.7 as vmod-builder

WORKDIR /build

RUN apk update
RUN apk add --no-cache build-base gcc make libtool varnish varnish-dev file python2 \
  automake m4 autoconf ca-certificates curl
RUN curl -sfSL https://github.com/Dridi/libvmod-querystring/releases/download/v1.0.5/vmod-querystring-1.0.5.tar.gz -o vmod-querystring.tgz
RUN mkdir vmod-querystring && tar xzf vmod-querystring.tgz -C vmod-querystring --strip-components 1
RUN cd vmod-querystring && ./configure && make && \
  install -c src/.libs/*.so /usr/lib/varnish/vmods/ && cd ..

RUN curl -sfSL https://github.com/varnish/varnish-modules/archive/0.13.0.tar.gz -o varnish-modules.tgz
RUN mkdir varnish-modules && tar xzf varnish-modules.tgz -C varnish-modules --strip-components 1
RUN cd varnish-modules && ./bootstrap && ./configure && make && \
  install -c src/.libs/*.so /usr/lib/varnish/vmods/ && cd ..

FROM alpine:3.7

ENV VARNISH_MEMORY 32M
ENV VARNISH_PORT 6081

RUN apk --no-cache add varnish

COPY --from=vmod-builder /usr/lib/varnish/vmods/*.so /usr/lib/varnish/vmods/

ADD ./entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

EXPOSE 6081

ENTRYPOINT ["/entrypoint"]
