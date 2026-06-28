# SerpApi Code Challenge

## Prerequisites

- Ruby **2.7.8** (pinned to match SerpApi's stack; see `.ruby-version`)
  Verify:

```bash
ruby -v # should show 2.7.8
```

If you're not on 2.7.8, use a version manager ex. rbenv:

```bash
rbenv install 2.7.8
cd /path/to/repo # uses .ruby-version
ruby -v
```

Should work with asdf/chruby too.

### Setup & Run

```bash
bundle install
bundle exec rspec

# to try NaiveParser directly - file is hardcoded, no arg
ruby use_naive_parser.rb

# to try KnowledgePanelCarouselParser directly - requires an html file
ruby use_knowledge_panel_carousel_parser.rb spec/fixtures/2024/van-gogh-paintings.html
```

## What's Covered

- 2024 Van Gogh HTML - exact match against `expected-array.json`

- 2026 Google Knowledge Panel carousels - multiple variants:
  - link-row carousels
  - wp-grid-tile carousels
  - multiple extensions

- Negative cases:
  - GKP Overview pages
  - GKP non-carousel collections
  - non-GKP Google results

## Note on Git History

I started working before forking the upstream repo, so the commit history doesn't reflect my adventure. It certainly didn't take 10 minutes! Definitely took longer than 4 hours.

## Project Structure and Usage

```
.
├── .rspec
├── .rubocop.yml
├── .ruby-version
├── AGENTS.md
├── files
│   ├── expected-array.json
│   ├── van-gogh-paintings.html
│   ├── van-gogh-paintings.json
│   └── van-gogh-paintings.png
├── Gemfile
├── Gemfile.lock
├── LICENSE
├── modules
│   ├── knowledge_panel_carousel_parser.rb
│   └── naive_parser.rb
├── notes.md
├── README.md
├── spec
│   ├── fixtures
│   │   ├── 2024
│   │   │   ├── expected-array.json
│   │   │   └── van-gogh-paintings.html
│   │   └── 2026
│   │       ├── carousel-cast-star-trek-tng.html
│   │       ├── carousel-multi-extension-members-rammstein.html
│   │       ├── carousel-paintings-van-gogh.html
│   │       ├── no-carousel-episodes-star-trek-tng.html
│   │       ├── no-carousel-overview-muppets.html
│   │       └── no-knowledge-panel-ruby-on-rails.html
│   ├── knowledge_panel_carousel_parser_spec.rb
│   └── naive_parser_spec.rb
├── use_knowledge_panel_carousel_parser.rb
└── use_naive_parser.rb

note: files/ is the upstream challenge material. Tests use spec/fixtures/ - the 2024 directory contains json/html copied from files/
```

## The Journey

I hadn't used Ruby to scrape before (only Perl/Python), so I did a little research. Nokogiri and Ferrum were the two modules that kept showing up. Later determined that Ferrum wasn't necessary.

### Getting Started

Cloned the repo, started locally. Checked out `README.md`, opened the example HTML. Asked Google: "what are the google results called when they build a mini webpage with artworks and other tabs"? The answer - Google Knowledge Panels! The ones we're targeting will display an overview and some tabbed collections - best way to find them is search for a famous artist, musician, tv show, author, etc.

Inspected the HTML in Firefox, noting there were far more paintings available in the source than visible on the page. Examined the structure, first making notes of various class names.

### Initial Setup

In the interview, it was mentioned that the Rails application was still on Ruby 2 (something about 3 having decreased performance). So, I will set up an rbenv using 2.7. Added a `Gemfile` with appropriate pinned versions for 2.7, including RSpec. Copied over [SerpApi's own .rubocop.yml](https://github.com/serpapi/serpapi-ruby/blob/master/.rubocop.yml), which thankfully has nicer defaults than what I'm used to.

### Naive Parser

I decided to start with a naive parser that uses hard-coded class names, to see what kinds of issues I run into.

Started with a basic test to sanity check (i.e. am I returning JSON? Does it have a key called 'artworks'? Are we getting an array back?)

Iterating through classes was fine until I got to the images. The displayed ones have a unique ID that corresponds to a script containing a base64 image. The rest of them have an image that is just an empty gif, but also a data-src that contains what we need. Spent some quality time on [Regex101](https://regex101.com/), but managed to extract what I needed. There was one final gotcha with the end of base64 images.

At this point, I added the final spec to actually compare against the expected array. It passed! With a working naive parser module, I could move on to the real one.

### Generalized Parser

Found some good examples of present-day Knowledge panels, and examined the markup. As expected, a lot of my naive approach wouldn't work here. Instead, I found there's a single `.kp-wholepage` div on the page, which contains the current overview, carousel, or other tabs. Also noted the `data-attrid='kc:...'`, which looked useful.

The best find was that the image scripts were largely unchanged, and I could use pretty much the same code from the naive parser.

The first few carousels I found used an `<a>` element with some divs and a single img, which I named link-row items. I eventually stumbled across some carousels using wp-grid-tile. That's where some complexity started to sneak in - I needed to account for carousel variants.

I noticed extensions was an array, but couldn't find any good reason for it. With enough digging, I found my answer: https://github.com/serpapi/public-roadmap/issues/1892. Added the specific example to the test fixtures.

I also discovered an edge case with the Muppets KP Overview. It's not a carousel, but it would still parse into useless data. Other KP Overview pages didn't seem to have this problem, but I still added a guard against it (and corresponding spec).

I ended up with more test fixtures than required due to the discovery of variants and edge cases.

## AI Disclosure

I used Cursor for this challenge. Mostly Auto, for asking implementation questions. I disallowed direct code editing via AGENTS.md - while not reflective of how I work in a real-world setting, I was unfamiliar with Nokogiri and wasn't comfortable with allowing it to make sweeping code changes without my review.

While helpful, I had to push back on it a lot, and ended up having to reorganize some code. The AI made several assumptions and assertions without actually checking first, which I caught because I'd examined the markup before I started (it even admitted "That was fabricated, not measured" at one point). It also suggested searching on hard-coded `kc:` attributes which I think would have been too brittle.

It also repeatedly over-engineered solutions, breaking functionality into multiple tiny methods where it didn't really make sense to do so. Also has an unhealthy obsession with nested ternaries, which were simplified.

If you've made it this far, thank you for reading!
