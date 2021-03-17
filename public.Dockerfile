FROM golang:1.14.1 as builder
WORKDIR /app/
COPY greeting/ /app/greeting/
COPY cmd/xo-helloworld-server/main.go /app/xo-helloworld-server/main.go
COPY cmd/xo-helloworld-rest/main.go /app/xo-helloworld-rest/main.go
COPY go.mod /app/go.mod
COPY go.sum /app/go.sum
RUN git config --global url."git@ssh.dev.azure.com:v3".insteadOf https://dev.azure.com
RUN git config --global url."ssh://git@github.com".insteadOf https://github.com
RUN go env -w GOPRIVATE=github.com/xhoto/*
RUN go env -w GOSUMDB=off
RUN go env -w GOPROXY=direct
RUN CGO_ENABLED=0 go build -o /app/cmd/xo-helloworld-server /app/xo-helloworld-server/main.go
RUN CGO_ENABLED=0 go build -o /app/cmd/xo-helloworld-rest /app/xo-helloworld-rest/main.go

FROM alpine
COPY --from=builder /app/cmd/xo-helloworld-server /xo-helloworld-server
COPY --from=builder /app/cmd/xo-helloworld-rest /xo-helloworld-rest
ENTRYPOINT ["/bin/sh", "-c" , "/xo-helloworld-server & /xo-helloworld-rest"]
EXPOSE 8080
EXPOSE 9090