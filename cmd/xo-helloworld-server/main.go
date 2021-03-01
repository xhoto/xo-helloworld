package main

import (
	"context"
	"log"
	"net"

	"github.com/xhoto/xo-helloworld/greeting"
	pb "github.com/xhoto/xo-idl/gen/go/helloworld"
	"google.golang.org/grpc"
)

const (
	port = ":49090"
)

// server is used to implement helloworld.GreeterServer.
type server struct {
	pb.UnimplementedGreeterServer
}

// SayHello implements helloworld.GreeterServer
func (s *server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
	log.Printf("Received: %v test!", in.GetName())
	return &pb.HelloReply{Message: greeting.Hello(in.GetName())}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterGreeterServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to server:%v", err)
	}
}
