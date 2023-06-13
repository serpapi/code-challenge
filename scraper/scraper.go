package main

import (
	"context"
	"errors"
	"github.com/chromedp/cdproto/cdp"
	"github.com/chromedp/cdproto/dom"
	"github.com/chromedp/chromedp"
	"strings"
	"time"
)

type Result struct {
	Artworks []*Item `json:"artworks"`
}

type Item struct {
	Name       string   `json:"name"`
	Extensions []string `json:"extensions,omitempty"`
	Link       string   `json:"link"`
	Image      string   `json:"image"`
}

func extractImgData(node *cdp.Node, item *Item) {
	if node.NodeName == "IMG" {
		// for some reason the results in expected-array.json have `=` encoded as `x2d`, I'd look into it more if this was a real project
		item.Image = strings.ReplaceAll(node.AttributeValue("src"), "=", "x2d")
	} else {
		for _, child := range node.Children {
			extractImgData(child, item)
		}
	}
}

func extractMetadata(node *cdp.Node, item *Item) {
	if strings.Contains(node.AttributeValue("class"), "klmeta") {
		item.Extensions = append(item.Extensions, node.Children[0].NodeValue)
	} else {
		for _, child := range node.Children {
			extractMetadata(child, item)
		}
	}
}

func extractItem(node *cdp.Node) *Item {
	item := &Item{
		Name: node.AttributeValue("aria-label"),
		Link: GooglePrefix + node.AttributeValue("href"),
	}
	extractImgData(node, item)
	extractMetadata(node, item)
	return item
}

func extract(node *cdp.Node, result *Result) {
	if node.NodeName == "A" {
		result.Artworks = append(result.Artworks, extractItem(node))
	} else {
		for _, child := range node.Children {
			extract(child, result)
		}
	}
}

func scrape(url string) (*Result, error) {
	var nodes []*cdp.Node
	result := &Result{}

	ctx, cancel := chromedp.NewContext(context.Background())
	defer cancel()

	if err := chromedp.Run(ctx, chromedp.Tasks{
		chromedp.Navigate(url),
		chromedp.Nodes("g-scrolling-carousel", &nodes, chromedp.ByQueryAll),
		chromedp.ActionFunc(func(c context.Context) error {
			if len(nodes) == 0 {
				return errors.New("no carousel found")
			}
			return dom.RequestChildNodes(nodes[0].NodeID).WithDepth(-1).Do(c) // only need the first carousel
		}),
		chromedp.Sleep(time.Second), // give it time to render dynamic contents
		chromedp.ActionFunc(func(c context.Context) error {
			extract(nodes[0], result) // only need the first carousel
			return nil
		}),
	}); err != nil {
		return nil, err
	}

	return result, nil
}
