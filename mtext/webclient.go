package main

import (
	"fmt"
	"net"
	"net/http"
	"os"
	"sync"
	"time"

	ws "github.com/coder/websocket"
)

type webClients struct {
	clients map[string][]*ws.Conn
	mtx     sync.Mutex
}

type mTextServer struct {
	// logf controls where logs are sent.
	logf  func(a ...any) (n int, err error)
	conns *webClients
}

func (s mTextServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := ""
	switch r.Header.Get("Origin") {
	case "https://leetcode.com":
		target = "leetcode"
	case "https://takeuforward.org":
		target = "tuf"
	default:
		return
	}

	c, err := ws.Accept(w, r, &ws.AcceptOptions{
		OriginPatterns: []string{"https://takeuforward.org", "http://localhost", "https://leetcode.com"},
	})
	if err != nil {
		s.logf(err)
		return
	}

	s.logf("Target:", target)
	s.conns.mtx.Lock()
	s.conns.clients[target] = append(s.conns.clients[target], c)
	s.conns.mtx.Unlock()
}

func WebClientConnect(conns *webClients) {
	listener, err := net.Listen("tcp", ":6768")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	s := &http.Server{
		Handler: mTextServer{
			logf:  fmt.Println,
			conns: conns,
		},
		ReadTimeout:  time.Second * 10,
		WriteTimeout: time.Second * 10,
	}

	go func() {
		errc <- s.Serve(listener)
	}()
}
