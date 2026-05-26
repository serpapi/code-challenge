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

**Serve and inspect live.** Rather than reading raw HTML, we run a local HTTP server
(`bin/serve-html`) and connect Playwright CLI to it. This lets Claude drive a real browser
against the page, query the live DOM, and understand exactly how elements are structured —
class names, image injection patterns, lazy-loading ids — without ever having to read the
raw file. Playwright's `eval` can extract structured data from any selector in a single
round-trip.

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

## Adding a new fixture

1. Search Google **in an incognito window** for a carousel page (actors, albums, movies, etc.)
   Incognito prevents your Google account email and session tokens from being embedded in the saved HTML.
2. `File → Save Page As → Web Page, Complete` — save the `.html` to `spec/fixtures/source-html/<name>.html`.
   Delete the companion `<name>_files/` directory — it contains browser assets not needed for parsing.
3. Preview what the extractor finds:
   ```bash
   bin/generate-fixture <name>
   ```
4. If the output looks correct, write the JSON fixture:
   ```bash
   bin/generate-fixture <name> --save
   ```
5. Run the integration tests to confirm:
   ```bash
   bin/rspec spec/integration/
   ```

If `bin/generate-fixture` raises `CarouselExtractor::UnknownLayoutError`, the page uses a CSS class
layout not yet recognised. Use `bin/serve-html` + Playwright to inspect the live DOM, identify the
item/name/extension/image selectors, and add a new adapter in `lib/layouts/`
(see [roadmap](../docs/roadmap.md)).

## Scripts

### `bin/serve-html`

Serves the `spec/fixtures/source-html/` directory over HTTP so HTML fixtures can be opened
in a browser or inspected with Playwright CLI (which blocks the `file://` protocol).

```bash
bin/serve-html          # → http://localhost:8765
bin/serve-html 9000     # custom port
```

Open http://localhost:8765/van-gogh-paintings.html to inspect the live DOM with Playwright.

### `bin/generate-fixture`

Runs the extractor against an HTML fixture and prints the results for review. Pass `--save`
to write the output as a JSON fixture, which the integration test will then pick up.

```bash
bin/generate-fixture her-movie-cast-Google-Search          # preview
bin/generate-fixture her-movie-cast-Google-Search --save   # write fixture
```

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
