# Extract Van Gogh Paintings Code Challenge

[![CI](https://github.com/brentgreeff/serpapi-code-challenge/actions/workflows/ci.yml/badge.svg)](https://github.com/brentgreeff/serpapi-code-challenge/actions/workflows/ci.yml)

## Dev Setup

```bash
bundle install
lefthook install
```

```bash
bundle exec rspec
```

## Fixtures

The challenge HTML file has been moved from `files/van-gogh-paintings.html` to
`spec/fixtures/source-html/van-gogh-paintings.html`, and the expected output from
`files/expected-array.json` to `spec/fixtures/json-result/van-gogh-paintings.json`,
to co-locate them with the integration tests.

## Approach

The HTML file (`van-gogh-paintings.html`) is a full Google search result page — 12MB of
markup, inline scripts, base64 images, and lazy-loading machinery. Feeding it directly to
an LLM as context is impractical: it exceeds context limits and makes it nearly impossible
to reason about structure.

**First attempt — strip the noise.** `bin/clean-html` uses Nokolexbor to parse the page
and remove all `<script>`, `<style>`, and `<noscript>` tags, producing a lean HTML snapshot
focused on visible content. Useful, but the stripped file still doesn't tell you what the
JavaScript was doing — and it turns out the carousel thumbnails are injected by script at
runtime.

**Better approach — serve and inspect live.** Rather than reading raw HTML, we run a local
HTTP server (`bin/serve-html`) and connect Playwright CLI to it. This lets Claude drive a
real browser against the page, query the live DOM, and understand exactly how elements are
structured — class names, image injection patterns, lazy-loading ids — without ever having
to read the raw file. Playwright's `eval` can extract structured data from any selector
in a single round-trip.

This combination — clean HTML for orientation, Playwright for precision — dramatically
reduces the time needed to identify correct selectors and understand Google's deferred image
loading pattern (base64 jpegs stored in inline `<script>` tags, injected into `<img>`
elements by id at runtime).

### Image extraction — three cases

Google uses two different thumbnail strategies in the same carousel, confirmed by inspecting
the live DOM with Playwright:

1. **Visible items (first ~8)** — the `<img>` has an `id` attribute (e.g. `_L_FkZ4q...`).
   The actual jpeg is stored in an inline `<script>` tag as
   `var s='data:image/jpeg;base64,...'; var ii=['_L_FkZ4q...'];`
   `ImageExtractor` parses all script tags once and builds an `id → base64` map.
   `CarouselItem` looks up `img.id` in that map.

2. **Lazy-loaded items (the rest)** — the `<img>` has no `id` and its `src` is a 1×1 gif
   placeholder. The real thumbnail URL is stored in a `data-src` attribute
   (e.g. `https://encrypted-tbn0.gstatic.com/images?...`). No HTTP request needed —
   the URL is already in the HTML.

3. **No image** — `<img>` has neither `id` nor `data-src`. Returns `nil`.

## Scripts

### `bin/clean-html`

Parses a Google search result HTML file with Nokolexbor and strips `<script>`, `<style>`,
and `<noscript>` tags, producing a smaller snapshot suitable for DOM inspection in a browser.

```bash
bin/clean-html                                      # van-gogh-paintings.html → van-gogh-paintings-clean.html
bin/clean-html files/other.html                     # other.html → other-clean.html
bin/clean-html files/other.html files/out.html      # explicit output path
```

Run this first when adding a new fixture file — it lets you inspect the carousel DOM
structure without wading through thousands of lines of inline JS.

### `bin/serve-html`

Serves the `files/` directory over HTTP so the HTML fixtures can be opened in a browser
or inspected with Playwright CLI (which blocks the `file://` protocol).

```bash
bin/serve-html          # → http://localhost:8765
bin/serve-html 9000     # custom port
```

Open http://localhost:8765/van-gogh-paintings-clean.html for a stripped-down view
suitable for DOM inspection.

### `bin/debug-compare`

Runs the extractor against `van-gogh-paintings.html` and compares each field to the expected fixture JSON, reporting mismatches with the exact character position where strings diverge.

```bash
bin/debug-compare                    # defaults to van-gogh-paintings
bin/debug-compare monet-paintings    # any basename in spec/fixtures/
```

Useful when the integration spec fails but RSpec truncates the long base64 image strings and hides the actual difference.

---

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.

Programming language wise, Ruby (with RSpec tests) is strongly suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.
