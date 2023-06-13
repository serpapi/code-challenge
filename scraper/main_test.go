package main

import (
	"encoding/json"
	"fmt"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

const EnvExpectedPath = "SCRAPE_EXPECTED_PATH"

var expectedPath = "/home/lulu/code-challenge/files/expected-array.json"

func readJson(t *testing.T, filePath string) *Result {
	result := &Result{}
	jsonRaw, err := os.ReadFile(filePath)
	if err != nil {
		t.Fatal(fmt.Errorf("failed to read file: %w", err))
	}
	// Go's json package thinks expected-array.json is malformed, wrapping in curly brackets fixes that
	if jsonRaw[0] != '{' {
		jsonRaw = append(append([]byte{'{'}, jsonRaw...), '}')
	}
	err = json.Unmarshal(jsonRaw, result)
	if err != nil {
		t.Fatal(fmt.Errorf("failed to unmarshal output: %w", err))
	}
	return result
}

func TestScrape(t *testing.T) {
	main()
	if expectedPathEnv := os.Getenv(EnvExpectedPath); expectedPathEnv != "" {
		expectedPath = expectedPathEnv
	}
	output := readJson(t, outputPath)
	expected := readJson(t, expectedPath)
	assert.Equal(t, output, expected)
}
