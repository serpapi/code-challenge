# Most Interesting Thing About This Challenge

I started out this challenge expecting to just use `cheerio` to parse out the HTML, fetching the images and everything as necessary.
But lazy loading threw a wrench in my plans!! 🤕 And the instructions mention to not perform additional HTTP requests. So I noticed the lazily loaded
images are actually in the initial source code, it's just that they're in the `<script>` tags. So it took me a while to decide to use an Abstract Syntax Tree
to parse out the script tag and extract the lazy-loaded images. That was fun. I'm not sure it's the most robust thing to do, but the AST felt fairly generic
and the approach worked nicely against three pages: Van Gogh, Xbox games, and iOS games, as you can see in:

- files/xbox-games-solution.json
- files/ios-games-solution.json
- files/van-gogh-paintings-solution.json

# Extract Van Gogh Paintings Code Challenge Solution

This is a solution to the SerpApi coding challenge implemented using the runtime I'm most comfortable with, Node.js.
Apologies for not implementing using Ruby, since I'm not familiar with Ruby yet, but I have a really strong
track record of learning things quickly (feel free to ask me in the interview 😉), and I'm really excited about working with Rails.

What you need to run this:

- Node.js runtime, which you can install [here](https://nodejs.org/en/download)
- Once it's been installed, just navigate to the root of this repository and do

```bash
> npm install
```

- Once the packages in `package.json` have been installed successfully, just do

```bash
cat files/van-gogh-paintings.html | node run.js > files/van-gogh-paintings-solution.json
```

Which will write out the json response to `van-gogh-paintaings-solution.json`. The program reads from `stdin` and writes
to `stdout`, as is recommended in \*nix world as a standard interface and for composability with other pieces of software.
You can also run it against `files/xbox-games.html`, which I obtained by Googling `xbox games` and downloading the source.

I used the `cheerio` third-party `npm` package for this challenge, which enables us to perform jQuery css selectors against
the HTML document. This is needed because we're running server-side javascript, not client-side javascript, so the `document` global or the DOM is not available in the Node.js runtime.

You can find the tests implemented using `Jest` under the `tests/` directory. They're pretty similar to RSpecs and just as
readable. You can run the tests by doing in the root directory of this repository

```bash
> npm run test
```

## Next Steps

I wanted to deploy this as an Express.js API on Heroku, as I'm worried that you guys don't have `nodejs` installed
since you're a Ruby shop, and offering it as an API would make it hassle-free for you to run, but I didn't wanna spend more
than 4 hours, as Paige recommended. But I would've packaged it as a Docker image CLI or an HTTP API on Heroku free tier to
make it easier for you to run. 🤓
