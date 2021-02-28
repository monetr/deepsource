FROM golang:1.16.0 AS builder
COPY ./cli /build
WORKDIR /build
RUN go get ./...
RUN go build -o /bin/deepsource github.com/deepsourcelabs/cli

FROM scratch

LABEL org.opencontainers.image.url=https://github.com/harderthanitneedstobe/deepsource
LABEL org.opencontainers.image.source=https://github.com/harderthanitneedstobe/deepsource
LABEL org.opencontainers.image.authors=me@elliotcourant.dev
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.title="DeepSource"
LABEL org.opencontainers.image.description="DeepSource Docker Image"

COPY --from=builder /bin/deepsource /bin/deep
ENTRYPOINT ["/bin/deepsource"]