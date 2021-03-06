FROM golang:1.14.1 as builder
ARG ssh_prv_key
ARG ssh_pub_key
ARG ssh_known_hosts
ARG ssh_authorized_keys
WORKDIR /app/
COPY greeting/ /app/greeting/
COPY cmd/xo-helloworld-server/main.go /app/xo-helloworld-server/main.go
COPY cmd/xo-helloworld-rest/main.go /app/xo-helloworld-rest/main.go
COPY go.mod /app/go.mod
COPY go.sum /app/go.sum
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh 
RUN echo $ssh_prv_key > /root/.ssh/id_rsa && \
    echo $ssh_pub_key > /root/.ssh/id_rsa.pub && \
    echo $ssh_known_hosts > /root/.ssh/known_hosts && \
    echo $ssh_authorized_keys > /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
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