## Build
Needs Go >= 1.20 and `google-chrome` binary

Needs the following ENVs
* `SCRAPE_URL`: a link to the scrape target, e.g. `file:///home/xxx/xxx`, `https://www.google.com/xxxxxxx`
* `SCRAPE_OUTPUT_PATH`: a path to put the output file, including filename
* `SCRAPE_EXPECTED_PATH`: path to `expected-array.json`, only required when running unit tests

`cd ./scraper && go build && scrape`
## Testing

Tested with the following URLs in addition to the provided HTML file.
* https://www.google.com/search?client=firefox-b-1-d&sxsrf=APwXEdcmA0W3ily78S71bStVhDagsuBUCA:1686677318288&q=Zendaya&stick=H4sIAAAAAAAAAONgFuLVT9c3NEwzz06uNDLNVeLSz9U3SElJM7So0BLLTrbSLykDoviCovz0osRcq-TE4pJFrOxRqXkpiZWJAFnTZQk_AAAA&sa=X&ved=2ahUKEwjc2KDT4sD_AhWFKEQIHTXMBPMQ9OUBegQIDRAC&biw=1536&bih=377&dpr=2
* https://www.google.com/search?client=firefox-b-1-d&sa=X&biw=1536&bih=843&sxsrf=APwXEdeCzEgyAPaHaKE4WDo-i8MdI294SQ:1686677932116&q=German+Shepherd&stick=H4sIAAAAAAAAAONgFuLUz9U3SCqxzClS4gAxs3NNk7XUspOt9JMy83Py0yv1U_JzU4tLMpMTS1JT4hPzMnMTc6ySilJTU4oXsfK7pxblJuYpBGekFmSkFqVMYGMEABLhp_JUAAAA&lei=rKmIZMHcBtnDkPIP652eoAo
* https://www.google.com/search?client=firefox-b-1-d&sxsrf=APwXEddENDtYvGDvr-O3YHiWSz4B1NcIDQ:1686678161443&q=Cheetah&stick=H4sIAAAAAAAAAONgFuLUz9U3MDQzNDJT4gAxk1NMUrTss5Ot9JMy83Py0yv1M_PS8otyE3PiIQKZyUBmelF-aUFmXrpVUWpBUWpxal5JYklmWapCcUFqcmZq8SJWdueM1NSSxAwAo9_Y0WIAAAA&sa=X&ved=2ahUKEwj-46bl5cD_AhUILkQIHYXEDZMQ9OUBegQIHxAN&biw=1536&bih=843&dpr=2