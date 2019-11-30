FROM registry.hub.docker.com/library/alpine:3.10

RUN apk --update --upgrade add \
      wget \
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
      nss \
      git

ENV PYTHON=python3

WORKDIR /app
RUN git clone https://github.com/mlohstroh/bitlbee bitlbee/
WORKDIR /app/bitlbee

RUN ./configure --debug=1
RUN make
RUN make install
RUN mkdir -p /var/lib/bitlbee

EXPOSE 6667
ENV BILTBEE_DEBUG=1 

ENTRYPOINT [ "bitlbee", "-Dnv" ]