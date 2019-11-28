FROM registry.hub.docker.com/library/alpine:3.10

RUN apk --update --upgrade add wget \
      glib \
      gnutls-dev \
      libgcrypt-dev \
      gcc \
      pkgconfig \
      glib-dev \
      openssl-dev \
      python3 \
      make \
      build-base \
      nss

ENV PYTHON=python3

WORKDIR /app

RUN wget http://get.bitlbee.org/src/bitlbee-3.5.1.tar.gz
RUN tar -xvf bitlbee-3.5.1.tar.gz
WORKDIR /app/bitlbee-3.5.1

RUN ./configure --debug=1
RUN make
RUN make install
RUN mkdir -p /var/lib/bitlbee

EXPOSE 6667
ENV BILTBEE_DEBUG=1 

ENTRYPOINT [ "bitlbee", "-Dnv" ]