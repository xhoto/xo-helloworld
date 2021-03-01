# Introduction 
Sample code for gRPC, protobuf, gateway, go project stucture, azure-pipeline, private repo

# Prerequisites
## 1. Use SSH key (no passphrase) for access azure repo [Use SSH key authentication](https://docs.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops)
windows env
```
c:> set GIT_SSH=C:\Program Files\Git\usr\bin\ssh.exe
```

## 2. Set azure git use ssh to use private repo in go get
```
$ git config --global url."git@ssh.dev.azure.com:v3".insteadOf https://dev.azure.com
$ git config --global core.autocrlf true
```

## 3. Install [VSCode](https://code.visualstudio.com/)
## 4. Install [Docker](https://docker.com)
## 5. Open VSCode with the Remote-Container [link](https://code.visualstudio.com/docs/remote/containers-tutorial)

# Getting Started
## 1. build, install, execute
```
$ cd cmd/xo-helloworld-server
$ go build
$ go install
$ xo-helloworld-server
```
```
$ cd cmd/xo-helloworld-client
$ go build
$ go install
$ xo-helloworld-client
```
```
$ cd go install ./cmd/...
```

## 2. test
```
$ cd greeting
$ go test
PASS
ok      github.com/xhoto/xo-helloworld/greeting 0.020.s
```

## 3. debug
1. set break point
2. and run and debug

# Ref links
* [Go get command support in Azure Repos Git](https://docs.microsoft.com/en-us/azure/devops/repos/git/go-get?view=azure-devops)
* [Private Go Modules on Azure DevOps](https://medium.com/@seb.nyberg/using-go-modules-with-private-azure-devops-repositories-4664b621f782)
* [402 error workaround](https://medium.com/@alikutly/go-get-hangs-forever-while-importing-from-azure-devops-git-repo-on-linux-da0ff3c0b135)
```
$ go env -w GOSUMDB=off
$ go env -w GOPROXY=direct
```