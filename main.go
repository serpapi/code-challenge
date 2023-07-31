package main

import (
	"challenge/worker"
	"fmt"
	"os"
)

func main() {
	dir, err := os.Getwd()
	if err != nil {
		fmt.Printf("Getwd error:%v", err)
		return
	}
	url := fmt.Sprintf(`file://%s/files/van-gogh-paintings.html`, dir)

	if err := worker.Run(url); err == nil {
		fmt.Println("Parse is ok.")
		return
	}

	fmt.Printf("Parse is error:%v", err)
}
