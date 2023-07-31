package worker

import (
	"challenge/parse/google"
	"challenge/spider"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
)

func Run(url string) error {
	c := spider.Context{Req: new(spider.Request)}

	c.Req.URL = url

	spider.Fatch(&c)

	res := google.Prase(&c)

	if nil == res {
		fmt.Println("Prase search result is nil")
		return errors.New("empty body")
	}

	// TODO:stroge
	if r, err := json.Marshal(res); err == nil {
		ioutil.WriteFile("./files/result.json", r, 0755)
		return nil
	}

	return errors.New("json marshal error")
}
