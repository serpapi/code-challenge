# Implementation Decisions and Verification Record

- **Status:** The local implementation is complete for the supplied page and four additional artist search terms.
- **Last full local verification:** July 17, 2026.
- **Runtime:** Ruby 4.0.6 managed by Mise.
- **Application shape:** A small offline Ruby library with extraction and benchmark command-line programs.

This document records the current contract, the reasons behind the design, the evidence covered by tests, and current operational limits. Setup and everyday commands are kept in `README.md`; detailed capture history and checksums for additional saved pages are in `spec/fixtures/README.md`.

## Challenge interpretation

The program reads a saved Google search results page and returns this JSON shape:

```json
{
  "artworks": [
    {
      "name": "The Starry Night",
      "extensions": ["1889"],
      "link": "https://www.google.com/search?...",
      "image": "data:image/jpeg;base64,..."
    }
  ]
}
```

The implementation follows these rules:

- Read artwork data from the supplied HTML, never from either reference JSON file.
- Make no network requests during extraction or tests.
- Return every card in the order it appears in the HTML, including cards hidden behind the initial “Show more” state.
- Require a nonblank `name` and an absolute Google `link` for every card.
- Include `extensions` only when the page contains nonblank extra display text. On the saved pages this is usually a year.
- Include `image` only when its value can be recovered from the saved page. A card without a recoverable image remains valid and omits the key.
- Recover images from `data-src`, a real `src`, or an image value assigned to the element by a saved `_setImagesSrc` script.
- Never download, decode, re-encode, or replace a thumbnail.
- Match `files/expected-array.json` exactly for the supplied Van Gogh page.
- Keep the parser callable independently from the file-reading command-line program.
- Fail clearly when the artwork section is missing, its card list is unclear, or required card data is malformed. Do not return a plausible partial result.

The challenge README informally says to return an array, while its expected file wraps the array in an `artworks` object. The machine-readable expected file is authoritative.

### Decisions made where the challenge is unclear

| Question | Decision |
| --- | --- |
| What is the top-level output? | `{ "artworks": [...] }`, matching `files/expected-array.json`. |
| Are only the eight visible cards included? | No. The supplied HTML and expected output contain 47 cards. |
| What happens when a year is blank? | Omit `extensions`; do not emit `[]`, `null`, or an invented value. |
| What counts as an image already present in the page? | A real `src`, a `data-src`, or an image value stored in a saved inline loader script. |
| What happens when no local image value exists? | Keep the card and omit `image`. |
| What happens when declared image data is malformed or conflicting? | Raise a short `InlineImageSourceError` without printing the image data. |
| How is the program run? | `bin/extract PATH`, backed by a plain Ruby object. |
| Should this be a Rails application? | No. The task does not need a web server, database, or long-running application. |
| What qualifies as an additional search scenario? | A genuine saved artwork page for a different artist query, with independently reviewed expected JSON. |

When requirements conflict, use this order:

1. The user’s current instructions.
2. The challenge README.
3. `files/expected-array.json` where the README is unclear.
4. `AGENTS.md` and this record.

## Scope

Included:

- Reproducible Ruby and locked gems.
- Local HTML parsing with Nokolexbor.
- Exact JSON output.
- RSpec tests using committed saved pages and focused HTML examples.
- Extraction and benchmark command-line programs.
- RuboCop, Rake, and Linux CI configuration.

Deliberately excluded:

- Fetching Google or SerpApi at runtime.
- Rails, Rack, Puma, MongoDB, or other persistence.
- A web API, frontend, authentication, caching, background work, or deployment infrastructure.
- Browser automation or JavaScript execution in the program or tests.
- A general-purpose Google results parser.
- Image downloads or transformations.
- Guessing selectors or fallback behavior without a saved page that requires them.
- Performance thresholds in tests or CI.

## Toolchain and dependencies

Versions were checked against stable releases on July 15–16, 2026. Direct gems are pinned in `Gemfile`; `Gemfile.lock` records the complete compatible dependency set.

| Component | Version | Purpose |
| --- | ---: | --- |
| Ruby | 4.0.6 | Exact project runtime selected by the user. |
| Mise | 2026.7.6 | Installs and selects Ruby locally; it is not a project gem. |
| RubyGems | 4.0.16 | Ruby package tooling. |
| Bundler | 4.0.16 | Resolves and locks gems. |
| Nokolexbor | 0.7.0 | The only runtime gem; parses HTML5. |
| benchmark-ips | 2.15.1 | Repeats benchmark operations and reports runs per second. |
| RSpec | 3.13.2 | Test framework requested by the challenge. |
| Rake | 13.4.2 | Small task interface for tests and linting. |
| RuboCop Rails Omakase | 1.1.0 | A maintained Ruby style baseline. Rails itself is not installed. |

RSpec 4.0.0.beta1 was excluded because it is a prerelease. “Latest” means the newest compatible stable version, not the numerically highest version when dependency constraints conflict.

### Why these choices

- **Mise:** The current Rails installation guide recommends it, it supports per-project Ruby versions, and it honors `.ruby-version`. Homebrew installs Mise and native build libraries; Homebrew Ruby is not the project runtime.
- **Nokolexbor:** Chosen because SerpApi develops it and its published benchmark on a saved Google results page reports 4.7× faster HTML parsing than Nokogiri, with substantially larger gains for CSS selection. Parsing and CSS selection are the core HTML operations used by this extractor.
- **RSpec:** The challenge recommends it and SerpApi publicly uses it. This takes priority over 37signals’ usual Minitest preference.
- **RuboCop Rails Omakase:** It supplies a readable, maintained default style without creating a large custom configuration. Its name does not require Rails.
- **benchmark-ips:** SerpApi’s Nokolexbor benchmark uses the same tool. It is loaded only by the benchmark program, not normal extraction.

### macOS setup summary

```sh
brew install mise openssl@3 libyaml gmp rust
mise settings add idiomatic_version_file_enable_tools ruby
mise install
mise exec -- gem update --system 4.0.16
mise exec -- gem install bundler --version 4.0.16 --no-document
mise exec -- bundle install
```

The project uses `.ruby-version` as the single Ruby version declaration. Do not use `sudo gem install` or the Apple-provided system Ruby.

## Repository structure

```text
.
├── .github/workflows/ci.yml
├── .ruby-version
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── bin/
│   ├── benchmark
│   └── extract
├── files/                         # Supplied challenge files
├── lib/google_search.rb
├── lib/google_search/
│   ├── artwork_layout_rules.rb
│   ├── artwork_page.rb
│   ├── artwork_extractor.rb
│   ├── artwork_extraction_benchmark.rb
│   ├── artwork_extraction_benchmark_report.rb
│   └── inline_image_sources.rb
└── spec/
    ├── fixtures/                  # Additional saved pages and expected JSON
    ├── google_search/
    ├── support/fixture_files.rb
    ├── benchmark_cli_spec.rb
    ├── cli_spec.rb
    └── spec_helper.rb
```

The supplied files under `files/` are treated as read-only challenge inputs. Additional saved pages belong under `spec/fixtures/` with a capture record and separately reviewed expected JSON.

## Design

### Processing flow

`ArtworkExtractor` prepares and parses the input in the first step, then
passes the document to `ArtworkPage` for the remaining production stages.

1. Parse the saved HTML once with Nokolexbor.
2. Find the first artwork section marked with:

   ```css
   [data-attrid="kc:/visual_art/visual_artist:works"]
   ```

3. Inside that section, ask the HTML parser for possible card lists using:

   ```css
   *:has(> * > a > img)
   ```

4. Accept exactly one list whose every direct child has the supported card shape.
5. Read every card in HTML order.
6. Build the image map only for cards that need an inline-script image.
7. Validate and normalize card fields.
8. Return `{ "artworks" => [...] }`.

The supported card shape, in abbreviated form, is:

```text
card > a > (img + details(name[, extension-or-blank]))
```

This relationship is shared by all 198 cards in the five retained saved pages. The parser accepts an omitted optional extension field, but does not accept extra unexplained fields.

### Finding the artwork section and card list

The `data-attrid` value describes the artist’s works section. It is narrower and more meaningful than searching the whole page for images or Google links.

`document.at_css` selects the first matching section. Every retained real page currently contains exactly one, but the parser does not scan the document merely to reject a duplicate that has never been observed.

English labels such as `Artwork` and `Artworks` are not fallbacks. They may be absent, duplicated elsewhere, or translated. Movies, books, ordinary image results, and other Google sections are also not accepted as substitutes.

The parser does not use Google-generated class names or the values of `jsname`, `jscontroller`, `jsdata`, or `data-md`. Those undocumented values can change without warning. Request-specific image element IDs are used only to connect a selected image to its explicit inline source assignment.

The parser validates the entire card list. One malformed card causes a clear failure instead of being dropped from an otherwise plausible partial result. More than one valid card list is treated as unclear and also fails.

### Card fields

`name`:

- Comes from the displayed-name element.
- Must be nonblank.
- Must match the image’s nonblank `alt` text.
- Keeps source spelling, punctuation, case, and Unicode after trimming surrounding whitespace.

`extensions`:

- Contains nonblank extra display strings in their original order.
- Is omitted when no nonblank value exists.
- Is not restricted to four-digit years and is never inferred from another source.

`link`:

- Must be present.
- A relative path is resolved against `https://www.google.com/`.
- An absolute link must use HTTPS and the Google host.
- Is never opened or checked over the network.

`image`:

- Uses a real nonblank `data-src` first.
- Otherwise uses a real non-placeholder `src`.
- Otherwise uses the inline image mapped to the element ID.
- Is omitted when none of those sources is present.

Keys are inserted as `name`, optional `extensions`, `link`, and optional `image`. JSON objects do not require key order, but this order makes output easy to compare with the supplied expected file.

### Inline image recovery

The supplied Van Gogh page contains two image forms:

- 39 cards store the thumbnail URL in `data-src`; their `src` is a one-pixel placeholder.
- 8 cards store a JPEG data URI in a saved script that associates the value with an image element ID.

`InlineImageSources` reads only script text containing the literal `_setImagesSrc` marker and one of the requested image IDs. It understands the narrow assignment form observed in the saved pages. It does not interpret JavaScript generally.

The decoder supports the required JavaScript string escapes:

- `\xNN`
- escaped single and double quotes
- escaped backslash and slash

It copies ordinary text in chunks and examines only escape boundaries. This avoids unnecessary allocations without changing the decoded value.

Behavior is intentionally different for requested artwork images and unrelated page data:

- A malformed, unsupported, or conflicting mapping for a requested artwork image raises `InlineImageSourceError`.
- A malformed mapping for an unrelated page image does not abort artwork extraction.
- Repeated identical mappings are accepted.
- Missing mapping data means the otherwise-valid card simply omits `image`.

The program never uses `eval`, a JavaScript engine, a browser, a shell command, or an HTTP request to recover an image.

### Main objects

| Object | Responsibility |
| --- | --- |
| `ArtworkLayoutRules` | Finds the artwork section, finds one complete card list, and checks the supported card shape. |
| `ArtworkExtractor` | Prepares and parses HTML, then delegates the parsed document to `ArtworkPage`. |
| `ArtworkPage` | Coordinates card discovery, script-image recovery, field and link extraction, and construction of the public result. It exposes those production stages to the benchmark. |
| `InlineImageSources` | Reads requested image assignments from saved scripts and safely decodes their string values. |
| `ArtworkExtractionBenchmark` | Measures complete extraction and focused production stages, including applicable layout rules. |
| `ArtworkExtractionBenchmarkReport` | Formats one runtime header and page reports with time per run, rate, variation, and precise `N/A` values. |
| `bin/extract` | Reads one local file, invokes the extractor, and prints JSON. |
| `bin/benchmark` | Reads local files, invokes the benchmark, and prints reports. |

`ArtworkLayoutRules::RULES` currently contains one card-shape rule. The collection is intentionally retained because more evidence-backed rules may be added later. Extraction and benchmarking use the same rule implementation so they cannot silently disagree.

### Errors

| Condition | Error/result | CLI exit |
| --- | --- | ---: |
| Success | JSON on standard output; no diagnostic | 0 |
| Wrong number of arguments | One-line usage | 64 |
| Missing or unreadable file | Short path error | 66 |
| Missing artwork section marker | `ArtworkSectionNotFound` | 65 |
| Unclear or unsupported artwork layout | `ArtworkLayoutError` | 65 |
| Malformed required card data | `MalformedCard` | 65 |
| Malformed requested image data | `InlineImageSourceError` | 65 |
| Unsafe or unsupported link | `InvalidLink` | 65 |

Expected input errors contain useful card or element context but never the complete HTML or base64 image. Unexpected programming errors are not broadly rescued; Ruby retains its normal backtrace.

## Saved-page coverage

A saved page used by tests is called a fixture. Each saved page has a reviewed expected JSON file that defines its required output.

| Saved page | Cards | Important behavior | Image sources |
| --- | ---: | --- | --- |
| Supplied Van Gogh | 47 | 2024 page; hidden cards; four missing extensions | 8 inline JPEGs, 39 `data-src` URLs |
| Claude Monet | 50 | Newer page; four missing extensions | 8 JPEG values already in `src`, 42 `data-src` URLs |
| Pablo Picasso | 45 | Explicitly selected Artworks tab; five missing extensions | 8 JPEG values in `src`, 37 `data-src` URLs |
| Frida Kahlo | 49 | Three missing extensions; two valid cards without recoverable images | 6 JPEG values in `src`, 41 `data-src` URLs, 2 omissions |
| Zdzisław Beksiński | 7 | Every extension is absent | 7 JPEG values in `src` |

The four additional pages were captured signed out on July 15–16, 2026 and reviewed offline. Page-specific location and request-protection values were replaced without changing the artwork section. Full capture details, independent expected-output review notes, sanitization checks, and file checksums are in `spec/fixtures/README.md`.

Every retained real page contains the required artist-works `data-attrid`. A former movies page and its separate parser path were removed because they did not satisfy that requirement.

### Additional search coverage

The project treats distinct artist search terms as the required variation for
the additional examples. Claude Monet, Pablo Picasso, Frida Kahlo, and
Zdzisław Beksiński each have a genuine saved page and independently reviewed
expected JSON, satisfying that requirement with four additional searches.

## Test coverage

### Exact saved-page contracts

- Exact parsed equality for the supplied Van Gogh page and all four additional pages.
- One shared test inventory explicitly includes the supplied page, discovers every additional
  HTML and expected-JSON pair, and rejects an unpaired fixture before tests run.
- Van Gogh returns exactly 47 cards, from `The Starry Night` through `Poppy Flowers`, including hidden cards.
- The four Van Gogh records with blank dates omit `extensions`.
- All 8 inline Van Gogh JPEGs and all 39 `data-src` URLs remain attached to the correct cards.
- No one-pixel placeholder is returned.
- Relative Google links become exact absolute links.
- Unicode and punctuation, including `Café Terrace at Night`, are preserved.
- Frida’s two cards without recoverable thumbnails remain present and omit `image`.
- Beksiński’s seven cards all omit `extensions`.

### Independence from Google-generated attributes

Tests remove every `class`, `jsname`, `jscontroller`, `jsdata`, `jsaction`, `data-md`, `data-hveid`, `data-ved`, `data-atf`, and `data-csiid` attribute from each real saved page. Extraction must still exactly match the unchanged expected JSON.

Image element IDs remain because they are explicit data associations used by `_setImagesSrc`, not card-discovery signals.

### Focused behavior

Focused HTML and script examples cover:

- Missing artwork sections and empty sections.
- A text label without the required marker.
- More than one possible card list.
- A malformed possible list containing a valid-looking nested list.
- A malformed card beside valid cards.
- Descendant links and images that must not replace the card's validated direct anchor or image.
- Missing names, links, image `alt` text, and extension elements.
- Conflicting displayed names and image descriptions.
- Extra detail fields that must not be invented as extensions.
- Unsafe link schemes.
- Cards with no local image value.
- Inline mappings with supported escapes, multiple IDs, repeated values, conflicts, malformed calls, unsupported escapes, regular-expression characters in IDs, large strings, and surrounding UTF-8.
- Malformed mappings for requested artwork images failing while unrelated mappings are ignored.
- Extraction and benchmark command success and error exits.
- Benchmark sections, precise `N/A` and malformed-page behavior, multiple pages with one runtime header, timing option validation, variation, and stable report ordering.

Tests read bytes with `File.binread`, derive paths from `__dir__`, make no network requests, do not sleep, and do not rewrite expected files. They assert benchmark output shape, never a specific speed.

## Benchmark design

Run the default Van Gogh benchmark with:

```sh
mise exec -- bin/benchmark
```

Each timed job defaults to two seconds of warmup and two seconds of measurement.
Other local pages and explicit measurement windows are supported:

```sh
mise exec -- bin/benchmark --warmup 1 --time 3 spec/fixtures/claude-monet-artworks.html
```

Each page report begins with its primary measurement:

- `Complete artwork extraction` parses the saved HTML and extracts every
  artwork through the public extractor on each timed run.

The default report then includes diagnostics rather than hiding them behind an
option:

- `Parse HTML` isolates Nokolexbor parsing.
- `Locate and validate artwork cards` starts with an already-parsed document
  and reuses production card-list discovery and validation.
- `Validate already-located cards` measures the current entry in
  `ArtworkLayoutRules::RULES` after the document has been parsed and the card
  list located. Future evidence-backed rules will appear as additional
  diagnostic rows without changing the default command.
- `Recover images stored in page scripts` starts with the parsed document and
  located cards. It calls the production `ArtworkPage` stage that identifies
  cards without usable direct image sources and builds their saved script-image
  map. It is `N/A` when no selected card needs script data.
- `Build artwork output` starts with the parsed document, located cards, and
  prepared script-image map. It calls the production `ArtworkPage` stage that
  reads fields, normalizes links, chooses images, and builds the artwork array.
  HTML parsing, card discovery, and script scanning are outside this row.

Each supported measurement shows these columns in decision-first order:

- `time/run`: time for one run, calculated as the inverse rate and displayed in
  `ns`, `μs`, `ms`, or `s`.
- `runs/s`: completed runs per second.
- `variation`: the relative variation reported by benchmark-ips for this local
  measurement.

These timed boundaries are intentionally different. Diagnostic rows help
explain complete extraction, but they are neither competing implementations
nor additive stages.

For a multi-page invocation, Ruby and dependency versions plus the selected
timing windows appear once, followed by one page report per input. Pages are
measured sequentially in one process, so careful before-and-after comparisons
should use one page per invocation. `N/A` means the page does not contain the
content that operation needs. Script-image recovery is therefore `N/A` when
all selected cards already carry usable image sources. A readable page without
the marker remains a successful report and still measures HTML parsing. Once
the marker exists, malformed artwork HTML is a concise command error with a
nonzero exit instead of being hidden as `N/A`.
Invalid options and unreadable paths remain command errors.

The benchmark repeats work inside one already-running Ruby process. The primary
timing excludes input-file reading, JSON generation, and Ruby, Bundler, or Mise
startup. Use `/usr/bin/time` around `bin/extract` to measure a fresh command
invocation.

Normal benchmark windows are intentionally excluded from Rake and CI. No benchmark speed is a correctness requirement.

### Recorded local benchmark evidence

On July 17, 2026, the default two-second warmup and two-second measurement on
the development Mac with Ruby 4.0.6 produced:

| Measurement | time/run | runs/s | variation |
| --- | ---: | ---: | ---: |
| Complete artwork extraction | 4.32 ms | 231.3 | ±1.3% |
| Recover images stored in page scripts | 1.61 ms | 620.0 | ±1.6% |

Immediately before the script-matcher optimization, an isolated recovery run
with the same timing windows measured 3.13 ms. The matching code now consumes
ordinary quoted text in runs, compiles one requested-ID pattern from shared
character fragments, and advances through every assignment with explicit
match offsets. The isolated post-change result was 1.55 ms, about 50% lower.

Link normalization continues to parse each link once and merge it with a
cached Google origin. Extraction now also reuses the direct anchor and image
recognized during card validation instead of searching each card again. Exact
output and focused malformed-input tests remain the acceptance gate for
optimization work. These figures are local diagnostic evidence, not portable
performance claims or CI thresholds.

## Developer workflow

Use the project-managed runtime for all commands when Mise is not activated in the shell:

```sh
mise exec -- bundle check
mise exec -- bundle exec rspec
mise exec -- bundle exec rubocop
mise exec -- bundle exec rake
mise exec -- bin/extract files/van-gogh-paintings.html
mise exec -- bin/benchmark
```

The default Rake task runs RSpec and RuboCop. The normal benchmark is intentionally separate.

To compare extracted JSON manually without relying on object key order:

```sh
mise exec -- bin/extract files/van-gogh-paintings.html > /tmp/actual.json
jq --sort-keys . /tmp/actual.json > /tmp/actual.sorted.json
jq --sort-keys . files/expected-array.json > /tmp/expected.sorted.json
diff -u /tmp/expected.sorted.json /tmp/actual.sorted.json
```

This is only a review aid; the RSpec exact-output test is the automated contract.

## Recorded verification

The following results were recorded during the July 17, 2026 full local verification:

- Ruby 4.0.6, RubyGems 4.0.16, and Bundler 4.0.16 reported the selected versions.
- `bundle check` reported that every dependency was installed.
- After a targeted compatible `parser` gem lockfile update, `bundle outdated --strict` reported `Bundle up to date!`.
- `bundle platform` confirmed Ruby 4.0.6 and the locked `aarch64-linux`, `arm64-darwin`, generic Ruby, `x86_64-darwin`, and `x86_64-linux` platforms.
- All 21 Ruby, executable, task, and dependency files passed Ruby syntax checks.
- CI YAML, all five expected JSON files, and the supplied reference JSON parsed successfully.
- `bundle exec rspec` passed 100 examples with zero failures.
- `bundle exec rubocop` inspected 21 files with zero offenses.
- `bundle exec rake` reran RSpec and RuboCop successfully.
- From a temporary working directory, `bin/extract` exactly matched all five expected files: 47 Van Gogh, 50 Monet, 45 Picasso, 49 Frida, and 7 Beksiński cards.
- Removing the documented Google-generated attributes from every real saved page still produced exact expected output.
- Production scans found no HTTP client, JavaScript evaluation, process launch, or runtime reference to the expected/reference JSON files.
- Fixture scans found no saved email, API key, JWT, private key, authentication header, named Google session cookie, unsanitized request-protection value, or original location text.
- Requiring the normal extraction library did not load benchmark-ips or benchmark classes.
- Workspace checks found no `.env`, coverage output, log, temporary report, packaged gem, or vendored bundle.

Remote Linux CI is configured but has not run. Running it requires publishing the work, and the user has prohibited commits and pushes.

### Original challenge file checksums

These SHA-256 values were recorded to prove the supplied inputs remained unchanged:

| File | SHA-256 |
| --- | --- |
| `files/van-gogh-paintings.html` | `844f72fcd612556233e1a1d0001eaf7fa8571dea0964468e33e13f5266169e06` |
| `files/expected-array.json` | `86128efdadb45fa67367cc4fa1b9c76fbe3f7f7177d428cd695754bc4db12e2c` |
| `files/van-gogh-paintings.json` | `3732e360070614d7d917f1f76fc7fac2fe8748deba63e9812ce3a36bc2eb13ac` |
| `files/van-gogh-paintings.png` | `c19ebd49b3c7484fdc5c665c1e5d87a54bd9dae61efbb718191f6c373a8df3f4` |

## Security and data handling

The saved HTML is treated as untrusted input:

- Never execute its scripts.
- Never insert its values into shell commands.
- Never request its links or images.
- Reject unsafe link schemes and non-Google absolute links.
- Keep errors short and exclude full HTML and image data.
- Read only the local path explicitly supplied to the command.
- Never overwrite an input or expected file.
- Keep CI permissions read-only and require no secrets.

Additional saved pages must be captured signed out, checked for personal or session data, minimally sanitized, and documented. Their expected JSON must be reviewed independently rather than generated and accepted from the production parser.

## Risks

| Item | Current response |
| --- | --- |
| Google changes the required `data-attrid` or card shape | Fail clearly. Expand support only with a saved page and exact expected output. |
| A selector accidentally matches unrelated page content | Continue scoping to the artist-works marker and validating every card in one complete list. |
| A placeholder is returned as a thumbnail | Preserve image-priority and exact-output tests. |
| Inline JavaScript parsing becomes too broad | Keep the decoder limited to observed data assignments and never execute code. |
| A saved page leaks private data | Capture signed out, scan it, sanitize only unrelated page values, and document checksums. |
| Expected JSON is generated by the parser it is meant to test | Build and review it independently from the production parser. |
| Dependency versions change | Recheck stable releases, review the lockfile change, and rerun the full local suite. |
| Ruby 4 exposes a native-gem difference on Linux | Run the configured Linux CI when publishing is authorized; do not silently claim it has passed. |
| Local benchmark numbers are mistaken for guarantees | Label the machine and runtime, keep results out of CI, and never set a timing threshold. |

No functional requirements remain open. Remote Linux CI is the only
intentionally unexecuted verification step.

## Important references

Version-sensitive sources were checked July 15–16, 2026.

### Challenge and SerpApi

- [SerpApi code challenge](https://github.com/serpapi/code-challenge)
- [December 2024 supplied-page refresh](https://github.com/serpapi/code-challenge/commit/49645f7186bd4e4251d5c3fa8d93438406c797bb)
- [Senior Fullstack Engineer role](https://serpapi.com/careers/senior-fullstack-engineer)
- [Demystify a SerpApi Request](https://serpapi.com/blog/demystify-a-serpapi-request/)
- [How RSpec Reporter improves our daily productivity](https://serpapi.com/blog/how-rspec-reporter-improves-our-daily-productivity/)
- [Nokolexbor repository](https://github.com/serpapi/nokolexbor)
- [Nokolexbor benchmark source](https://github.com/serpapi/nokolexbor/blob/master/bench/bench.rb)
- [Nokolexbor 0.7.0 release](https://github.com/serpapi/nokolexbor/releases/tag/v0.7.0)

### Ruby and tooling

- [Ruby 4.0.6 release](https://www.ruby-lang.org/en/news/2026/07/14/ruby-4-0-6-released/)
- [Official Rails Ruby installation guide](https://guides.rubyonrails.org/install_ruby_on_rails.html)
- [Mise Ruby backend](https://mise.jdx.dev/lang/ruby.html)
- [Bundler Ruby version directive](https://bundler.io/guides/gemfile_ruby.html)
- [RubyGems 4.0.16](https://rubygems.org/gems/rubygems-update/versions/4.0.16)
- [Bundler 4.0.16](https://rubygems.org/gems/bundler/versions/4.0.16)
- [Nokolexbor 0.7.0](https://rubygems.org/gems/nokolexbor/versions/0.7.0)
- [benchmark-ips 2.15.1](https://rubygems.org/gems/benchmark-ips/versions/2.15.1)
- [RSpec 3.13.2](https://rubygems.org/gems/rspec/versions/3.13.2)
- [Rake 13.4.2](https://rubygems.org/gems/rake/versions/13.4.2)
- [RuboCop Rails Omakase 1.1.0](https://rubygems.org/gems/rubocop-rails-omakase/versions/1.1.0)

### Ruby style

- [Rails Doctrine](https://rubyonrails.org/doctrine)
- [RuboCop Rails Omakase](https://github.com/rails/rubocop-rails-omakase)
- [Basecamp Fizzy style guide](https://github.com/basecamp/fizzy/blob/main/STYLE.md)
