# AGENTS.md

## Purpose

Build an original, production-quality Ruby solution for SerpApi's Van Gogh
paintings code challenge. The program reads a saved Google desktop search page
from disk and returns the JSON shape required by the challenge:

```json
{
  "artworks": [
    {
      "name": "The Starry Night",
      "extensions": [ "1889" ],
      "link": "https://www.google.com/search?...",
      "image": "data:image/jpeg;base64,..."
    }
  ]
}
```

Use these plain-language meanings throughout the project:

- **Saved test page**: an HTML file used as test input. Test code may call it a
  fixture.
- **Reviewed expected JSON**: the output checked by a saved-page test.
- **Artwork section marker**: Google's descriptive
  `data-attrid="kc:/visual_art/visual_artist:works"` attribute. Parser code calls
  the element carrying it the artwork root.
- **Card list**: the element whose direct children are all artwork cards.
- **Google-generated attributes**: undocumented class names and values in
  `jsname`, `jscontroller`, `jsdata`, and `data-md`. They may change without
  warning and must not drive extraction.

## Required behavior

- Parse the HTML itself. Do not read `files/van-gogh-paintings.json` or
  `files/expected-array.json` for result data at runtime.
- Make no HTTP requests during extraction or tests.
- Extract every artwork card in the order it appears in the HTML, including
  cards hidden behind the initial "Show more" state.
- Include a nonblank `name` and an absolute Google `link` for every valid item.
- Include `extensions` only when the page contains nonblank extra display text,
  usually a year. Do not infer dates or return `null` or an empty array.
- Include `image` when the saved page contains a recoverable thumbnail. Never
  download, transform, or re-encode an image.
- Match `files/expected-array.json` exactly for the supplied Van Gogh page,
  including item order and omitted optional keys.
- Keep the parser callable independently from the command-line program.
- Test the supplied page and genuine additional Google pages with RSpec.
- Use plain Ruby. Rails, persistence, an HTTP API, JavaScript execution, Docker,
  cloud infrastructure, caching, and background jobs are out of scope.

## Current execution constraint

Do not run Git commands or create branches, commits, pushes, or pull requests
unless the user explicitly changes this instruction. Inspect and verify files
directly in the working directory.

## Decision order

When instructions disagree, follow them in this order:

1. The user's current request.
2. Explicit challenge requirements in `README.md`.
3. The supplied Van Gogh input and expected JSON where the prose is ambiguous.
4. This file.
5. `PROJECT_PLAN.md`.
6. Existing repository conventions.

Keep `PROJECT_PLAN.md` aligned with the implemented contract. Do not hide a
conflict behind speculative behavior.

## Interview integrity

This is an interview submission. The candidate must be able to explain every
dependency and the complete extraction path.

- Produce an original implementation from the supplied files and public
  documentation.
- Do not inspect or copy another candidate's solution or pull request.
- The public SerpApi Claude Monet spec is evidence of output field names only.
  Its live requests and shared test state are not a template for this offline
  parser.
- Do not claim access to SerpApi's private code, architecture, versions, or
  scraping methods.
- Clearly distinguish public facts, observed saved-page behavior, and
  inferences.
- Prefer small, transparent code over abstractions unsupported by the saved
  pages.
- Never invent test results, benchmark results, capture history, or manual
  validation.
- Keep requirements traceable through focused tests and clear documentation.

## Scope

The quality signal is a reliable parser and understandable tests, not the
number of technologies used.

Required scope:

- Reproducible Ruby version and locked gems.
- HTML parsing with Nokolexbor.
- Deterministic JSON output.
- Exact-output and focused RSpec tests.
- Minimal extraction and benchmark command-line programs.
- RuboCop and CI.

Do not add runtime fetching, SerpApi calls, browser automation, a general
JavaScript parser, a universal Google-results parser, Rails/Rack, a database,
authentication, quotas, proxies, CAPTCHA handling, image downloads, machine
learning, or speculative fallbacks.

Only retain a genuine saved page when it contains the artwork section marker.
Do not fall back to movies, books, or another carousel when that marker is
absent. Each retained page currently contains one marker, but the parser does
not enforce uniqueness: it selects the first matching element in HTML order.

## Locked toolchain

The project currently uses these exact direct versions:

- Ruby 4.0.6.
- RubyGems 4.0.16 and Bundler 4.0.16. `Gemfile.lock` must continue to say
  `BUNDLED WITH 4.0.16`.
- Nokolexbor 0.7.0 for HTML parsing.
- benchmark-ips 2.15.1 for local, development-only measurements.
- RSpec 3.13.2 for tests.
- Rake 13.4.2 for the small task surface.
- RuboCop Rails Omakase 1.1.0 for the style baseline. Its name does not mean
  Rails is an application dependency.

Use mise, installed through Homebrew, as the recommended local Ruby manager.
Mise is a developer tool rather than a project gem. Direct dependencies remain
pinned, while Bundler records exact indirect dependencies in `Gemfile.lock`.

“Latest” means the stable versions deliberately selected on a recorded date;
it does not mean letting versions float between machines. Re-check official
release sources before an intentional upgrade, review the changelog, refresh
the lockfile, and run every check. Do not introduce prerelease, Git-sourced, or
duplicative gems without a documented need.

## Public interfaces

Keep file and process handling outside the core extractor:

```ruby
html = File.binread(path)
result = GoogleSearch::ArtworkExtractor.new(html).call
# => { "artworks" => [ ... ] }
```

`ArtworkExtractor` prepares the input, parses it with Nokolexbor, and hands
the parsed document to `ArtworkPage`. `ArtworkPage` owns the production stages
that locate cards, recover images stored in page scripts, and build the public
artwork output. The benchmark calls those same stages rather than maintaining
benchmark-only copies.

### Extraction command

```sh
bin/extract files/van-gogh-paintings.html
```

- Accept exactly one local HTML path.
- Read the file as bytes.
- On success, print pretty JSON and nothing else to standard output.
- Print short, useful errors to standard error.
- Return zero on success and nonzero for bad arguments, unreadable input, or
  an extraction error.
- Never fetch a URL, open a browser, or change the input file.
- Keep argument handling thin and delegate extraction to the library.

### Benchmark command

```sh
bin/benchmark
bin/benchmark another-page.html --warmup 1 --time 2
```

- With no path, use the Van Gogh page through an absolute path derived from the
  executable's directory.
- Accept multiple local HTML paths plus explicit `--warmup` and `--time`
  durations. Default to two seconds of warmup and two seconds of measurement for
  each timed job.
- Print the Ruby, Nokolexbor, benchmark-ips, and timing context once per command,
  even when multiple pages are selected. Follow it with one page report per
  input. Treat multi-page mode as a convenience; recommend one page per
  invocation for careful before-and-after comparisons because pages are timed
  sequentially in one process.
- Lead each page report with `Complete artwork extraction`. Every timed run
  must parse the saved HTML and extract all artworks through the public
  extractor.
- Always include these diagnostics:
  - `Parse HTML` builds a new Nokolexbor document from the in-memory HTML.
  - `Locate and validate artwork cards` starts with an already-parsed document
    and calls the production card-list discovery and validation.
  - Every row in `ArtworkLayoutRules::RULES` starts with an already-parsed
    document and already-located cards and calls the production rule.
  - `Recover images stored in page scripts` starts with an already-parsed
    document and already-located cards. It calls the production `ArtworkPage`
    stage that identifies cards needing script data and builds their image map.
  - `Build artwork output` starts with an already-parsed document,
    already-located cards, and an already-built script image map. It calls the
    production `ArtworkPage` stage that reads fields, normalizes links, chooses
    images, and builds the artwork array.
  Never copy production checks or extraction stages into benchmark code.
- Lead measurement columns with `time/run`, followed by `runs/s` and the
  variation reported by benchmark-ips. Calculate `time/run` as `1 / runs/s`
  and choose `ns`, `μs`, `ms`, or `s`.
- Check applicability before timing. `N/A` means the page does not contain the
  content that operation needs. In particular, script-image recovery is `N/A`
  when supported artwork cards already contain usable image sources. A
  readable page with no marker remains a successful report; HTML parsing is
  still measured and the artwork diagnostics are `N/A`.
- If the marker exists but the supported artwork HTML is malformed, print a
  concise error and return nonzero. Bad options and unreadable files also
  remain command errors.
- Do not add a ratio column for unlike operations.
- These measurements describe one local run. Never publish them as portable
  guarantees or use a speed threshold in CI.
- Do not put the long benchmark in the default Rake task or CI.

The benchmark repeats work inside an already-running Ruby process. The primary
timing excludes file reading, JSON generation, and Ruby, Bundler, or Mise
startup. Use `/usr/bin/time` around `bin/extract` when fresh process startup is
part of the question.

## JSON contract

The top-level result is:

```ruby
{ "artworks" => Array<Hash> }
```

Insert artwork keys in this readable order:

1. `name`
2. `extensions`, when present
3. `link`
4. `image`, when present

Field behavior:

- `name`: required, nonblank source text. Let the HTML parser decode entities.
  Preserve spelling, case, Unicode, and punctuation; trim surrounding space.
- `extensions`: one or more nonblank source strings in HTML order. Do not
  convert them to numbers, validate them as years, infer them, or emit an empty
  array.
- `link`: required. Resolve a relative source link against
  `https://www.google.com` without requesting it.
- `image`: optional. Return the saved page's thumbnail reference unchanged.
  Do not download, validate remotely, re-encode, truncate, or substitute it.

Return no internal debugging keys and no `nil` values.

## HTML extraction rules

### Parse HTML with Nokolexbor

Use Nokolexbor to build and inspect the HTML document. Do not parse HTML with a
regular expression. Regular expressions are allowed only inside tightly
selected script text to recover `_setImagesSrc` values already in the file.

### Find the artwork cards

1. Use `document.at_css` to select the first element with
   `data-attrid="kc:/visual_art/visual_artist:works"`.
2. If the marker is absent, raise `ArtworkSectionNotFound`. Do not scan for duplicate
   markers or search the whole document for images and Google links.
3. Within that artwork section, use `*:has(> * > a > img)` to find possible
   card-list elements.
4. Keep only candidates for which every direct child has the supported card
   shape. Require exactly one matching card list.
   A valid-looking list nested inside another candidate must not replace that
   malformed outer candidate and produce a partial result.
5. Parse every direct child. The shape shared by all retained cards is
   `card > a > (img + details)`. Details contain one displayed-name child and
   at most one extension-or-blank child.
6. After recognizing a card, require its anchor to have `href`. Require a
   nonblank image `alt` equal to the displayed name.
7. Reuse the recognized direct anchor and image during extraction. Do not run a
   broader descendant search that could select a link or image from the details.

Do not use undocumented Google-generated classes or values from `jsname`,
`jscontroller`, `jsdata`, or `data-md`, even as a fast path. A request-specific
image element ID may only connect that selected image to its explicit saved
`_setImagesSrc` assignment.

Do not search for the English labels `Artwork` or `Artworks` as a fallback.
Those labels can be absent, duplicated, or translated.

Ignore CSS visibility and preserve HTML order so hidden cards are included.
Do not remove duplicates unless a real saved page and its reviewed expected
JSON prove that repeated source cards should be collapsed.

### Recover image sources safely

Build the inline image map once per document and only for IDs requested by the
selected artwork cards:

1. Normalize the requested IDs. If none remain, return an empty map before
   looking for scripts.
2. First filter scripts by the literal `_setImagesSrc` text. A malformed call
   for a requested image must reach validation rather than disappearing behind
   a pattern that matches only well-formed calls.
3. Before running detailed patterns, keep only scripts that can contain a
   requested ID. Escape regular-expression characters in IDs and recognize the
   literal, supported simple-escape, and case-insensitive `\xNN` forms handled
   by the decoder.
4. Read the quoted source and only its explicitly associated element IDs.
5. Check every script containing a requested image ID. Repeated identical mappings are valid;
   conflicting sources for one requested ID raise `InlineImageSourceError`.
6. Decode only the JavaScript string escapes the project explicitly supports,
   including observed `\xNN` escapes. Never use `eval`, a JavaScript engine,
   `instance_eval`, `class_eval`, or a shell command.
7. Copy ordinary source text in chunks and inspect only escape boundaries so a
   large base64 value does not create one Ruby string per character.
8. If a requested artwork image has a declared mapping that is malformed or
   contains an unsupported escape, raise `InlineImageSourceError` with a short
   message that excludes HTML and image payloads.
9. A malformed or unsupported mapping for an unrelated page image may be
   ignored and must not abort artwork extraction.

For each selected image element, prefer sources in this order:

1. A nonblank usable `data-src` value.
2. A nonblank usable `src` value.
3. A saved inline source mapped to the image element's `id`.
4. No `image` key when none of those is recoverable.

Recognize the known one-pixel placeholder by its exact value and purpose. Do
not assume that every `data:image/gif` value is a placeholder.

### Normalize links without opening them

Parse and freeze the `https://www.google.com/` origin once. Parse each `href`
once and merge that parsed URI into the saved origin. Preserve the path, query
parameters, order, and escaping as closely as URI-safe normalization permits.
The HTML parser should decode attribute entities such as `&amp;`.

Accept only HTTPS links whose host is exactly `www.google.com`, whose effective
port is 443, and which contain no embedded username or password. Reject
unsupported schemes such as `javascript:`. Never follow a redirect or check
whether a link is reachable.

### Fail instead of returning partial data

- Missing artwork marker: raise `ArtworkSectionNotFound`.
- Artwork section with no valid cards: raise `ArtworkLayoutError`.
- More than one possible card list: raise `ArtworkLayoutError` with a clear
  ambiguity message.
- A direct card-list child that is not a valid card: fail instead of silently
  skipping it.
- Missing name or link, or a displayed name that disagrees with image `alt`:
  raise `MalformedCard` with the card number.
- Invalid or unsafe link: raise `InvalidLink` with the card number.
- Missing locally recoverable image: keep the card and omit `image`.
- Malformed declared image data for a requested artwork image: raise
  `InlineImageSourceError`.
- Blank extension: keep the card and omit `extensions`.

Errors should identify the problem and useful local context without including
megabytes of HTML or image data.

## Handling a future card structure

Do not add speculative parser branches. If a future saved page uses a
genuinely different artwork structure:

1. Record where and how the page was captured.
2. Identify the artwork marker and observed card shape.
3. Add a failing exact-output test first.
4. Extend shared extraction only when the meaning is truly the same.
5. Add a named strategy only when reusing the same parser logic would reduce clarity or
   correctness.
6. Run every existing saved-page contract afterward.

Fallback behavior must be visible in tests. Do not use broad rescue clauses
that turn parser bugs into empty results.

## Test requirements

RSpec is required by the challenge. Describe user-visible behavior rather than parser mechanics.

The saved-page contracts must prove exact Van Gogh output, all 47 cards in order, hidden cards,
the expected first and last names, omitted blank years, both saved image mechanisms, `\xNN`
decoding, placeholder rejection, exact absolute links, and preserved Unicode and punctuation.
Every additional real page must represent a different artist search term, contain the artwork
marker, and exactly match reviewed expected JSON. Removing Google-generated classes and JavaScript
attributes must not change its output.
The shared saved-page inventory must discover every additional HTML and expected-JSON pair, reject
orphaned files, and drive all cross-fixture checks.

Focused tests must cover:

- A missing marker, an empty artwork section, and an `Artworks` label without the marker.
- No card list, multiple possible lists, irrelevant siblings, and an invalid card among valid cards.
- Missing names, image `alt`, or links; name/alt conflicts; extra fields; blank or absent extensions.
- Absolute, invalid, and unsafe links, plus a valid card with no recoverable image.
- No requested inline IDs; IDs containing regular-expression characters or supported escapes.
- Malformed, unsupported, repeated, and conflicting requested-image mappings, while unrelated
  malformed mappings do not abort extraction.
- Large strings, UTF-8 near escapes, and escaped backslashes that are not decoded twice.
- Extraction-command success and errors, plus all benchmark paths, options, sections, rules,
  columns, variation, one shared runtime header, precise `N/A` behavior, and malformed-page errors.

Read saved pages with `File.binread` and paths based on `__dir__`. Tests must not use the network,
sleep, mutate saved pages, regenerate expected JSON, or depend on the caller's directory.
Correctness tests must not assert live speed or timing. A short benchmark-process test may assert
applicability and output shape; report-format tests may use injected measurements.

## Ruby style

Use RuboCop Rails Omakase as the baseline, then optimize for comprehension:

- Use conventional Ruby names, two-space indentation, double-quoted strings, and small public APIs.
- Prefer cohesive domain objects over generic `Service`, `Manager`, `Processor`, `Util`, or
  `Helper` buckets.
- Use expanded conditionals when both outcomes matter and early returns for clean exceptional paths.
- Order class methods, public methods (`initialize` first), then private methods in reading order.
- Keep private methods together below `private`, with no blank line after the
  keyword, and indent those method definitions one level.
- Use `!` only when a meaningful non-bang method exists.
- Avoid metaprogramming, monkey patches, refinements, global state, mutable constants, broad
  `StandardError` rescues, unexpected caller-data mutation, and unnecessary type/DTO frameworks.
- Comment upstream quirks and safety decisions, not Ruby syntax. Prefer clear transformations over
  dense chains when parsing volatile input.

Plain Ruby remains the simpler choice because this is not a web application.

## Dependencies and saved-page hygiene

- Give every direct dependency a one-sentence justification in `README.md` or `PROJECT_PLAN.md`.
- Keep Nokolexbor as the only runtime gem unless a demonstrated need appears.
- Keep development tools out of runtime loading and use `bundle exec` for gem-provided commands.
- Do not add a dependency when a few clear standard-library lines provide the needed behavior.
- Treat `files/` as immutable challenge input; never reformat or rewrite its minified files.
- Put real additional pages in `spec/fixtures/` and record subject, capture date, locale/device when
  known, differences, and sanitization.
- Remove personal data, cookies, account identifiers, keys, and unrelated data when safe for the
  tested artwork section. Never store browser profiles, environment files, coverage, or temp files.
- Do not call a hand-written Google page a capture. Small labeled HTML examples are valid unit tests.
- Avoid printing base64 image data into test failures or review notes.

## Documentation

- `README.md`: reviewer setup, commands, behavior, short design, errors, coverage, and limits.
- `PROJECT_PLAN.md`: current decisions, remaining work, and dated verification—not duplicated
  historical research or completed-phase journals.
- `spec/fixtures/README.md`: capture history, differences, sanitization, and checksums.

Keep each fact in one primary document, explain specialized terms on first use, and follow any
hiring-process rule for AI/tooling disclosure accurately.

## Commands and change workflow

Use these commands after mise and the gems are installed:

```sh
mise install
mise exec -- bundle install
mise exec -- bundle exec rspec
mise exec -- bundle exec rubocop
mise exec -- bundle exec rake
mise exec -- bin/extract files/van-gogh-paintings.html
mise exec -- bin/benchmark
```

For each implementation change: read the relevant requirement and evidence; inspect only the needed
HTML or script fragment; state the intended behavior; add or identify a focused failing test; make
the smallest cohesive change; run the focused test, full RSpec suite, and RuboCop; compare Van Gogh
output with `files/expected-array.json`; review changed files directly; and update affected docs.

Do not weaken an expectation, delete a saved page, or add a broad rescue merely
to make a test pass.
