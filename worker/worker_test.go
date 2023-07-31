package worker

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestWorker(t *testing.T) {
	// Here can be the seam page, but google change it css format.
	// change dir to your own directory.
	dir := "/Users/zhengxianle/Documents/GitHub/code-challenge"
	url := fmt.Sprintf(`file://%s/files/van-gogh-paintings.html`, dir)
	err := Run(url)
	assert.Nil(t, err)
}
