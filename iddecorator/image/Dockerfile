FROM golang:1.18.6-alpine3.16 as builder

COPY iddecorator ./app

WORKDIR ./app/src

RUN export GO111MODULE=on

RUN apk add --no-cache gcc musl-dev libc6-compat

RUN go build -ldflags "-linkmode external -extldflags -static"  -o /iddecorator .

# Webhook
FROM scratch

EXPOSE 443

COPY --from=builder /iddecorator /iddecorator

ENTRYPOINT ["/iddecorator"]