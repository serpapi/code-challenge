# Google Search Artwork Extractor

This Ruby program reads a saved Google search results page and returns the
artwork data required by SerpApi's Van Gogh paintings code challenge.
Extraction is fully offline: the input is an HTML file already saved to disk.

## Quick start

The project uses:

- Ruby 4.0.6
- RubyGems 4.0.16
- Bundler 4.0.16

On macOS, the recommended setup uses [Mise](https://mise.jdx.dev/) to install
the project Ruby. First install Mise and Ruby's build dependencies:

```sh
brew install mise openssl@3 libyaml gmp rust
```

If Mise is not already configured to read `.ruby-version`, enable that once:

```sh
mise settings add idiomatic_version_file_enable_tools ruby
```

Then install Ruby and the project dependencies:

```sh
mise install
mise exec -- gem update --system 4.0.16
mise exec -- gem install bundler --version 4.0.16 --no-document
mise exec -- bundle install
```

If Ruby 4.0.6 and Bundler 4.0.16 are already available, run:

```sh
bundle install
```

The lockfile includes ARM64 and x86-64 platforms for macOS and Linux.

## Run the extractor

```sh
mise exec -- bin/extract files/van-gogh-paintings.html
```

Pass any other saved HTML page in the same way. To save the output:

```sh
mise exec -- bin/extract files/van-gogh-paintings.html > result.json
```

The command prints formatted JSON:

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

The supplied Van Gogh page returns all 47 cards in page order, including those
behind the initial **Show more** state.

### Output fields

- `name`: required displayed artwork name.
- `extensions`: optional additional text displayed by Google, usually a year.
- `link`: required full HTTPS Google URL.
- `image`: optional image value stored in the saved page.

Blank optional fields are omitted. Image values are returned unchanged; the
program does not download or re-encode them. Where the written brief is
ambiguous, the output follows `files/expected-array.json`.

### Exit statuses

| Result | Status |
| --- | ---: |
| Success | 0 |
| Invalid arguments | 64 |
| Unsupported or malformed artwork data | 65 |
| Missing or unreadable input | 66 |

## Use from Ruby

```ruby
require_relative "lib/google_search"

html = File.binread("files/van-gogh-paintings.html")
result = GoogleSearch::ArtworkExtractor.new(html).call
artworks = result.fetch("artworks")
```

`ArtworkExtractor` accepts HTML text and returns ordinary Ruby hashes and
arrays. The command-line program handles reading the file and printing JSON.

## Design

Extraction follows five steps:

1. Parse the saved HTML with Nokolexbor.
2. Find the first section marked
   `data-attrid="kc:/visual_art/visual_artist:works"`.
3. Find and validate the artwork cards inside that section.
4. Read each card's name, optional extra text, link, and image.
5. Turn relative links into full Google URLs and return the cards in page order.

Images are read from `data-src`, `src`, or image values embedded in the
page's scripts. The script reader only recovers data already present in the
file; it does not execute JavaScript.

The extractor does not rely on Google's generated CSS class names. It starts
from the artwork section marker and checks every card's HTML structure. If one
card is invalid, extraction fails with a clear error instead of returning a
partial list.

Nokolexbor was chosen because SerpApi develops it and its published benchmark
on a saved Google results page reports 4.7× faster HTML parsing than Nokogiri,
with substantially larger gains for CSS selection.

## Tests and CI

Run the full test and style suite:

```sh
mise exec -- bundle exec rake
```

Or run each check separately:

```sh
mise exec -- bundle exec rspec
mise exec -- bundle exec rubocop
```

RSpec covers:

- complete JSON comparison for the supplied Van Gogh page;
- complete JSON comparison for four additional artist searches;
- all cards, their order, optional fields, links, and images stored in HTML
  attributes or page scripts;
- missing or invalid artwork data;
- extraction without relying on Google's generated class names; and
- extractor and benchmark command behavior.

One shared saved-page inventory includes the supplied Van Gogh page and
automatically discovers every additional HTML and expected-JSON pair. An
unpaired file fails test loading, while a complete new pair automatically joins
the exact-output, artwork-marker, generated-attribute, and layout checks.

GitHub Actions runs the complete RSpec suite and RuboCop on Linux.

## Saved test pages

| Search | Cards | Image behavior |
| --- | ---: | --- |
| Van Gogh | 47 | 8 images recovered from scripts; 39 URLs in `data-src` |
| Claude Monet | 50 | 8 images in `src`; 42 URLs in `data-src` |
| Pablo Picasso | 45 | 8 images in `src`; 37 URLs in `data-src` |
| Frida Kahlo | 49 | 6 images in `src`; 41 in `data-src`; 2 unavailable |
| Zdzisław Beksiński | 7 | All 7 images in `src` |

The additional pages cover different artist searches, image-loading behavior,
missing optional values, names with accents, Polish titles, and punctuation.

See [spec/fixtures/README.md](spec/fixtures/README.md) for capture details,
sanitization notes, expected-output review notes, and checksums.

## Benchmark

The benchmark defaults to the Van Gogh page:

```sh
mise exec -- bin/benchmark
```

It also accepts other local pages and custom timing:

```sh
mise exec -- bin/benchmark spec/fixtures/claude-monet-artworks.html
mise exec -- bin/benchmark --warmup 1 --time 3 spec/fixtures/pablo-picasso-artworks.html
```

The first row measures complete artwork extraction. The remaining rows show
the time spent parsing HTML, locating and checking cards, recovering images
from scripts, and building the returned artwork data. Each row measures a
different amount of work, so the individual times should not be added
together. `N/A` means that step is not needed for the selected page.

These measurements run inside an existing Ruby process. They exclude file
reading, JSON formatting, and process startup. To measure the full command on
macOS—including Mise, Bundler, and Ruby startup—use:

```sh
MISE_OFFLINE=1 mise exec -- /usr/bin/time -p \
  bin/extract files/van-gogh-paintings.html > /dev/null
```

Benchmark results will vary by machine and input page.

## Dependencies

| Dependency | Version | Purpose |
| --- | ---: | --- |
| Nokolexbor | 0.7.0 | Parse HTML |
| benchmark-ips | 2.15.1 | Run local benchmarks |
| RSpec | 3.13.2 | Test behavior and output |
| Rake | 13.4.2 | Run project checks |
| RuboCop Rails Omakase | 1.1.0 | Check Ruby style |

Nokolexbor is the only runtime gem. The remaining dependencies are development
tools.

## Limits

- The page must contain Google's visual-artist works marker and the supported
  card structure.
- Script-based image recovery supports the formats found in the included
  pages; it does not try to understand arbitrary JavaScript.
- The extractor does not fetch pages or missing images.

## AI assistance

This solution was developed with Codex assistance.

## References

- [Original SerpApi code challenge](https://github.com/serpapi/code-challenge)
- [Nokolexbor and its benchmarks](https://github.com/serpapi/nokolexbor#benchmarks)
- [benchmark-ips](https://github.com/evanphx/benchmark-ips)
- [RuboCop Rails Omakase](https://github.com/rails/rubocop-rails-omakase)
