package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
)

const GooglePrefix = "https://www.google.com"

const EnvUrl = "SCRAPE_URL"
const EnvOutputPath = "SCRAPE_OUTPUT_PATH"

var url = "file:////home/lulu/code-challenge/files/van-gogh-paintings.html"
var outputPath = "/home/lulu/code-challenge/files/output.json"

func main() {
	if urlEnv := os.Getenv(EnvUrl); urlEnv != "" {
		url = urlEnv
	}
	if outputPathEnv := os.Getenv(EnvOutputPath); outputPathEnv != "" {
		outputPath = outputPathEnv
	}
	result, err := scrape(url)
	if err != nil {
		log.Fatal(fmt.Errorf("failed to scrape: %w", err))
	}
	bytes, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		log.Fatal(fmt.Errorf("failed to marshal items: %w", err))
	}
	err = os.WriteFile(outputPath, bytes, 0644)
	if err != nil {
		log.Fatal(fmt.Errorf("failed to write file: %w", err))
	}
}
