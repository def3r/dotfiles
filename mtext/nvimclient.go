package main

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"net"
	"os"
	"slices"
	"time"

	ws "github.com/coder/websocket"
)

func GetFileIndex(fileContent []byte) (int, int) {
	var sIndex int
	var eIndex int
	sIndex = bytes.Index(fileContent, delim)
	if sIndex == -1 {
		sIndex = 0
		eIndex = -1
	} else {
		eIndex = bytes.Index(fileContent[sIndex+1:], delim)
	}
	if eIndex == -1 {
		eIndex = len(fileContent)
	} else {
		eIndex += sIndex + 1
	}
	return sIndex, eIndex
}

func GetTargetConns(conns *webClients, target string) []*ws.Conn {
	var wsConns []*ws.Conn
	conns.mtx.Lock()
	for _, ws := range conns.clients[target] {
		wsConns = append(wsConns, ws)
	}
	conns.mtx.Unlock()
	return wsConns
}

func WriteToConns(content []byte, wsConns []*ws.Conn) []*ws.Conn {
	var closedConns []*ws.Conn
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*1)
	for _, wsConn := range wsConns {
		err := wsConn.Write(ctx, ws.MessageText, content)
		if err != nil {
			closedConns = append(closedConns, wsConn)
		}
	}
	cancel()
	return closedConns
}

func EraseConns(closedConns []*ws.Conn, target string, conns *webClients) {
	conns.mtx.Lock()
	conns.clients[target] = slices.DeleteFunc(conns.clients[target], func(c *ws.Conn) bool {
		return slices.Contains(closedConns, c)
	})
	conns.mtx.Unlock()
}

func HandleNeovimClient(conn net.Conn, conns *webClients) {
	filePath := ""
	for {
		bytes, err := conn.Read(bffr)
		if bytes > 0 {
			filePath += string(bffr[:bytes])
			// fmt.Print(string(bffr[:bytes]))
		}
		if errors.Is(err, io.EOF) {
			fmt.Println("Connection closed: ", conn.LocalAddr())
			break
		}
	}
	fmt.Println("filePath:", filePath)

	target := ""
	if filePath[:42] == "/home/asbestos/part9/Asbestos/cp/LeetCode/" {
		fmt.Println("Leetcode andy")
		target = "leetcode"
	} else if filePath[:38] == "/home/asbestos/part9/Asbestos/cp/misc/" {
		fmt.Println("Tuf andy")
		target = "tuf"
	}

	wsConns := GetTargetConns(conns, target)
	if len(wsConns) == 0 {
		return
	}

	fileContent, err := os.ReadFile(filePath)
	if err != nil {
		fmt.Println(err)
		return
	}

	sIndex, eIndex := GetFileIndex(fileContent)
	closedConns := WriteToConns(fileContent[sIndex:eIndex], wsConns)
	EraseConns(closedConns, target, conns)
}

func NeovimClientConnect(conns *webClients) {
	listener, err := net.Listen("tcp4", ":6767")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		go HandleNeovimClient(conn, conns)
	}
}
