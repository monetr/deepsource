FROM golang:1.16.2 AS builder
COPY ./cli /build
WORKDIR /build
RUN go get ./...
RUN go build -o /build/bin/deepsource github.com/deepsourcelabs/cli

FROM alpine:3.13.3

LABEL org.opencontainers.image.url=https://github.com/harderthanitneedstobe/deepsource
LABEL org.opencontainers.image.source=https://github.com/harderthanitneedstobe/deepsource
LABEL org.opencontainers.image.authors=me@elliotcourant.dev
LABEL org.opencontainers.image.title="DeepSource"
LABEL org.opencontainers.image.description="DeepSource Docker Image"

COPY --from=builder /build/bin/deepsource /usr/bin/deepsource
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
RUN apk update && apk add git
ENTRYPOINT ["/usr/bin/deepsource"]
