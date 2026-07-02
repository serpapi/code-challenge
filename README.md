# Google artworks carousel extractor

Small Python script that pulls the artworks carousel (the row of paintings, or
people, that Google shows at the top of some searches) out of a saved results
page and gives you back an array. It only reads the local HTML file, it doesn't
make any requests.

Output looks like this:

```json
{ "artworks": [ { "name": "The Starry Night", "extensions": ["1889"], "link": "https://www.google.com/search?...", "image": "data:image/jpeg;base64,..." } ] }
```

## Install

```bash
pip install -r requirements.txt
```

You really only need beautifulsoup4. It'll use lxml if you've got it (bit
faster), and if not it just falls back to Python's built-in html.parser. pytest
is only for the tests.

## Run

```bash
python carousel_parser.py files/van-gogh-paintings.html
```

That prints the `{"artworks": [...]}` JSON to the terminal.

## Test

```bash
pytest
```

## What the task wanted

Just so I didn't miss anything, here's what the
[instructions](instructions/README.md) asked for and what I did:

- Get the `name`, the `extensions` (the date), and the Google `link` for each one.
- Also grab the thumbnails that are actually in the page, and skip the ones that
  would need another request. Those come out as `null`.
- Read the HTML file directly, no extra HTTP calls.
- Write my own test. There's a fair few in `test_parser.py`.
- Try it on a couple of other similar pages. I saved a few real ones, see below.
- They suggest Ruby but say use whatever. I went with Python as that's what I'm
  most comfortable in.

The output matches their `files/expected-array.json` exactly, base64 images and
all.

## How it works

Couple of things about the HTML that aren't obvious until you actually look at it.

### Finding the items

Each item in the carousel is the same little block repeated:

```html
<div class="iELo6">
  <a href="/search?...&q=The+Starry+Night&stick=...">
    <img class="taFZJe" alt="The Starry Night" id="_L_..." src="<1x1 gif>">
    <div class="KHK6lb">
      <div class="pgNMRc">The Starry Night</div>   <!-- name -->
      <div class="cxzHyb">1889</div>               <!-- year -->
    </div>
  </a>
</div>
```

The class names (`iELo6`, `pgNMRc` and so on) are just random-looking hashes and
Google changes them between pages, so I didn't want to rely on those. What seems
stable is the shape: a link pointing at `/search`, with a `stick=` bit in it,
that has an image inside it. On the sample page that gets you exactly the 47 items
and leaves out the "More"/"See more" links (they have `stick=` too but no image,
so there's actually 56 of those links and only 47 real items).

One thing that caught me out: I first checked `href.startswith("/search")`, but
when you save a page the browser rewrites the links to the full
`https://www.google.com/search?...`, so that missed everything. I switched to
checking the URL path is `/search` and now both work.

If there's a `<g-scrolling-carousel>` wrapper on the page I only look inside that,
so stuff like "People also search for" doesn't sneak in. If there isn't one I
just look at the whole page.

### The name is in two different spots

Google does this carousel two different ways depending on the search, which was a
bit annoying:

- Sometimes the full name is just in the image's `alt` (the van gogh file,
  Picasso and Monet are like this).
- Other times the `alt` is empty, the visible name is cut short and split over two
  lines ("The Starry" then "Night"), and the actual full name is in the link's
  `aria-label` (or `data-entityname`).

So I look at `aria-label`, then `data-entityname`, then the `alt`, then the first
bit of text, and use the first one that's actually there. The extensions are then
whatever text is left over after the name. The first type of page doesn't have
those attributes so it isn't affected and still matches exactly.

### Thumbnails (the img src is never the real image)

The `src` on the img is always a 1x1 transparent gif placeholder, so the real
image is somewhere else. In order:

1. `data-src="https://encrypted-tbn..."`, which is just the URL (39 of the 47).
2. A base64 one set by a little inline script:
   `var s='data:image/jpeg;base64,...';var ii=['<img id>',...]` then
   `_setImagesSrc` (8 of them). Two gotchas here. The `=` at the end of the base64
   is written as `\x3d` in the script so you have to un-escape it (mine came out 3
   characters too long until I twigged), and the same id can get set more than
   once so you keep the first one.
3. If neither of those, an actual `http` src if there is one.

If there's nothing, the image would need another request, so I just set it to
`null` like the task says.

## Output format

- The keys come out in the order `name`, `extensions`, `link`, `image`.
- If there's no date I leave `extensions` off completely rather than putting an
  empty list.
- `image` is either a `data:` URI, an `https://` URL, or `null`.
- The whole thing is wrapped in `{"artworks": [...]}` to match their file.

## Tests

`test_parser.py` is in a few layers so if something breaks you can tell what:

1. The main one: the output has to match `expected-array.json` exactly.
2. Some checks on the shape (key order, links being absolute, the split of base64
   vs URL images, the first and last item).
3. A couple of little unit tests for the fiddly bits (the escape decoding, and
   keeping the first image when an id repeats).
4. The command line: it prints the right JSON, errors properly if you give it no
   file, and the lxml/html.parser fallback gives the same answer.
5. The other pages: it picks up every `.html` + `.expected.json` pair in
   `tests/fixtures/`, so I can drop a new page in and it gets tested automatically.

## Fixtures

Mostly real saved pages. I also wrote three small HTML pages by hand for three
things my real pages don't happen to include: a missing thumbnail (so `image`
comes out `null`), an image sitting on the plain `src` rather than `data-src`,
and the other name layout where the name is in `aria-label` instead of `alt`.

Real ones:

- `files/van-gogh-paintings` (the one they gave): 47 items, matches exactly.
- `picasso_paintings` (US): a real saved page with the absolute links, 45 items.
- `monet_paintings_fr` (French): searched with `gl=fr&hl=fr`, 49 items, just to
  check the accents and a different language don't break it.
- `power_cast` (UK): this one's a grid of cast members rather than a carousel, 51
  people, and the "extension" is their character name. Same code handles it.

Hand-written:

- `vangogh_aria_layout`: the second name layout (empty alt, name in aria-label).
- `monet_carousel`: the g-scrolling-carousel wrapper, all three image types plus a
  null one, a no-date item, and some decoy links that should be ignored.
- `star_wars_movies`: a non-painting one with no wrapper, and an image on the
  actual src.

## A few notes

- I didn't use a proper JS engine to run Google's scripts, just a regex to pull
  the base64 out. Felt like overkill for this and it's easier to follow.
- The `\x3d` thing genuinely took me a while, the images kept coming out slightly
  wrong and I couldn't work out why at first.
- The absolute vs relative link thing only showed up once I tried a real page I'd
  saved myself, which I suppose is exactly why they ask you to test on other pages.
- Kept lxml optional so you don't strictly need it installed.

## Stuff I didn't do

- The other kind of grid/mosaic. The grids that use the same `/search?stick=`
  links work fine (that's the power_cast one), but Google also does grids with
  `wp-grid-tile` and no stick links, and I haven't handled those. That would want
  its own separate bit of code and I'd want a real example to build it against.
- There's a thing where Google loads a carousel in afterwards with
  `window.jsl.dh('id','<html>')`. I had a go at it and it works, but none of my
  actual test pages needed it so I didn't leave it in.
- If a page had more than one carousel it'd currently just lump them together.
