package spider

import (
	"context"
	"fmt"
	"time"

	"github.com/chromedp/chromedp"
)

func Fatch(c *Context) {
	ctx, cancel := chromedp.NewContext(
		context.Background(),
	)
	defer cancel()

	ctx, cancel = context.WithTimeout(ctx, 15*time.Second)
	defer cancel()

	err := chromedp.Run(ctx,
		chromedp.Navigate(c.Req.URL),
		chromedp.WaitReady(`body`),
		chromedp.OuterHTML("html", &c.Body),
	)
	if err != nil {
		fmt.Println(err)
	}
}
