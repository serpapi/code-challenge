package spider

type Context struct {
	Body string
	Req  *Request
}

type Request struct {
	URL    string
	Method string
}
