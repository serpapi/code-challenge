# Extract Van Gogh Paintings Code Challenge

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

---

## Solution

Parses the Knowledge Graph carousel out of a saved Google results page into an
array of `{ name, extensions, link, image }` objects.

The Van Gogh paintings case is the required deliverable and is covered. The same code handles other entity types (albums, buildings, cast) because only the *locator* changes per type.

### Running it

```sh
bundle install
bundle exec rspec     # specs
bundle exec rubocop   # lint
```

Run it against any saved results page (prints JSON to stdout):

```sh
ruby -Ilib -rcarousel_extractor -rjson \
  -e 'puts JSON.pretty_generate(CarouselExtractor.call(File.read(ARGV[0])))' \
  files/van-gogh-paintings.html
```

### Output

An array of symbol-keyed hashes, in the key order of `files/expected-array.json`.
The run command above pretty-prints for readability; the byte-for-byte claim is
about compact `to_json` — serialized that way, the Van Gogh case is identical to
the expected output:

```json
{ "name": "The Starry Night", "extensions": ["1889"], "link": "https://www.google.com/search?...", "image": "data:image/jpeg;base64,..." }
```

`extensions` is omitted entirely when a tile has no secondary line (e.g.
yearless paintings). The only field we *know* the meaning of is the paintings
date (from the expected fixture); for other types `extensions` carries
whatever the tile's second line is (year, or a character name for a cast
carousel).

### Approach / design notes

- **Locate by stable schema, not styling.** Tiles are found via the Knowledge
  Graph `data-attrid` (e.g. `kc:/visual_art/visual_artist:works`), never by
  minified classes, `jsname`, or per-request ids, those are not stable.
- **Allowlist of carousel tags, not "any tile container."** Scoping extraction to
  a known carousel container keeps off-target tiles out. The Grateful Dead albums
  page is the clearest case: alongside the 12 album tiles it carries eBay/Target
  shopping thumbnails that *also* wrap an `<img>` in a `/search?q=…` anchor. A
  matcher keying only on "image+text tiles linking to /search" scrapes those two
  in as extra entries (14 instead of 12); scoping to the
  `kc:/music/artist:albums` container ignores them. Other off-target shapes the
  allowlist skips: a non-entity strip (`kc:/common/topic:social media presence`
  on the Unilever page) or an *entity* carousel of a type we haven't validated
  (`kc:/business/business_operation:founder`, a company's founders). To support a
  new type, add its tag to `CAROUSEL_ATTRIDS` plus a fixture and a spec.
- **Per-tile extraction depends on structure.** `name` and `extensions` come from
  the leaf text `<div>`s under each anchor (name from the first div, falling back to
  `img@alt`); `link` from the anchor. The split is positional — the first leaf is
  the name and any leaf after it becomes an extension — so a tile with extra
  decorative text would leak into `extensions`. Across the current fixtures each
  tile has at most one secondary line, so this stays clean.
- **Thumbnails without extra requests.** The first tiles render a placeholder
  `<img>` whose real bytes arrive later in the page: searching the HTML for the
  base64 string from `expected-array.json` led to `_setImagesSrc(...)` `<script>`
  blocks that map an image id to a `data:` URI (with `\xNN` escapes to unescape).
  Tiles past the inlined batch carry the thumbnail URL directly in `data-src`.
  Either way the value is already in the file, so extraction makes no network
  calls. This mixed result (inline base64 for the first tiles, in-page URLs for
  the rest) is exactly what `expected-array.json` contains.

### Verified against (spec/fixtures/)

| query | carousel tag | result |
| --- | --- | --- |
| Van Gogh paintings | `visual_art/visual_artist:works` | exact `expected-array.json` match |
| Grateful Dead albums | `music/artist:albums` | 12 tiles; sibling eBay/Target shopping thumbnails excluded |
| Frank Lloyd Wright buildings | `architecture/architect:designed` | no dates (extensions omitted) |
| Breaking Bad cast | `tv/tv_program:cast` | extensions = character |
| Mark Gonzales skateboard art / Unilever brands | — | `[]` (organic SERP / wrong-module) |

### Layout

```
lib/carousel_extractor.rb  # the extractor
spec/                      # RSpec: exact match + per-type + negatives
spec/fixtures/             # alternate-layout result-page captures
files/                     # challenge-provided fixtures (html + expected-array)
```

### Notes / tradeoffs

- **`extensions` is kept generic on purpose.** The expected fixture only tells
  us what the *paintings* second line means (the date). Rather than infer
  per-type semantics, I opted for simplicity and am passing through each tile's
  secondary as-is: a year for albums, a character name for cast, and nothing
  for buildings.
- **Allowlist over pattern/shape matching.** I'm detecting carousels by an
  explicit set of `data-attrid` tags instead of "any container with N image+text
  anchors."
  Matching the shape would generalize to unseen types for free, but it also
  risks false-positives on carousel-shaped modules that aren't entity collections
  I chose to limit support to KG tags we have proven we can handle.
  Adding a new type requires adding the tag to a list, capturing an HTML
  fixture, and adding a spec.
- **Multiple carousels are all returned.** When a page exposes more than one
  allowlisted carousel (e.g. a polymath who is both architect and visual artist),
  every populated carousel's tiles are concatenated in `CAROUSEL_ATTRIDS` order.
  A matched block with no image tiles contributes nothing, so degenerate strips
  (like da Vinci's empty architect block) drop out for free. The result is a
  flat, untyped array — I don't try to guess which single carousel the caller
  wanted. In every observed real page only one allowlisted carousel is actually
  populated, so this never changes a single-carousel result.
- **Where I stopped.** Fixtures are all `en`/`us` desktop captures; I didn't probe
  other locales or mobile layouts, handle "View more" expansions/pagination, or
  dedupe repeated tiles. The locator and per-tile extraction are independent, so
  those would slot in without reworking the core.