package google

import (
	"challenge/spider"
	"fmt"
	"strings"

	"github.com/PuerkitoBio/goquery"
)

type Picture struct {
	Name       string   `json:"name"`
	Extensions []string `json:"extensions,omitempty"`
	Link       string   `json:"link"`
	Image      *string  `json:"image"`
}

type Results struct {
	Artworks []Picture `json:"artworks"`
}

func Prase(c *spider.Context) interface{} {
	doc, err := goquery.NewDocumentFromReader(strings.NewReader(c.Body))
	if err != nil {
		fmt.Printf("Parse fail:%v", err)
		return nil
	}

	result := new(Results)

	doc.Find("g-scrolling-carousel a.klitem").Each(func(i int, s *goquery.Selection) {
		p := new(Picture)
		// href
		if href, has := s.Attr("href"); has {
			if !strings.Contains(href, "https://www.google.com") {
				p.Link = "https://www.google.com" + href
			} else {
				p.Link = href
			}
		}

		// name
		name := ""
		s.Find("div.kltat").Each(func(i int, sp *goquery.Selection) {
			name += sp.Text()
		})
		p.Name = name

		// extensions
		extensions := s.Find("div.klmeta").Text()
		if extensions != "" {
			p.Extensions = append(p.Extensions, extensions)
		}

		// image
		if image, has := s.Find("img").Attr("src"); has {
			p.Image = &image
		}

		result.Artworks = append(result.Artworks, *p)
	})

	return result
}
