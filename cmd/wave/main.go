package main

import (
	"fmt"

	_ "github.com/mattn/go-sqlite3"
)

var (
	version = "dev"
)

func main() {
	fmt.Printf("👋 version %s\n", version)
}
