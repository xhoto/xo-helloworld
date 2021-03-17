FROM alpine
COPY aska-helloworld-server /aska-helloworld-server
COPY aska-helloworld-rest /aska-helloworld-rest
ENTRYPOINT ["/bin/sh", "-c" , "/aska-helloworld-server & /aska-helloworld-rest"]
EXPOSE 8080 9090