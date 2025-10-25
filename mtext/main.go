package main

import (
	"fmt"
	"os"
	"os/signal"

	ws "github.com/coder/websocket"
)

var errc chan error
var bffr []byte
var delim []byte

func main() {
	bffr = make([]byte, 1024)
	delim = []byte("// mtext solution")

	errc = make(chan error, 1)
	conns := webClients{clients: make(map[string][]*ws.Conn)}

	go NeovimClientConnect(&conns)
	go WebClientConnect(&conns)

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, os.Interrupt)
	select {
	case err := <-errc:
		fmt.Printf("failed to serve: %v", err)
	case sig := <-sigs:
		fmt.Printf("terminating: %v", sig)
	}

}
