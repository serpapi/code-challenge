# Additional saved Google result pages

A fixture is a saved page used by tests. These four fixtures are genuine
Google desktop result pages that broaden coverage beyond the supplied Van Gogh
page without making a network request during extraction or testing.

Each `*.expected.json` file is the reviewed JSON that extraction must produce
for its matching page. Tests read these files as references and never
regenerate them.

Terms used below:

- The **artwork section marker** is Google's descriptive
  `data-attrid="kc:/visual_art/visual_artist:works"` attribute.
- An image **already in `src`** is stored directly on its image element.
- An image **in `data-src`** has a URL that Google intended to load later.
- A **data URI** stores the image itself as text inside the HTML instead of
  pointing to a separate URL.
- A **capture-specific selector** is a CSS selector used only to inspect and
  review one saved page. The production parser does not depend on it.

## Capture environment

Claude Monet was captured on July 15, 2026. Pablo Picasso, Frida Kahlo, and
Zdzisław Beksiński were captured on July 16, 2026. All four pages were
captured through the in-app browser in anonymous, signed-out sessions. The
pages identify themselves as English, United States, non-personalized desktop
results (`hl=en`, `gl=us`, and `pws=0`) at a captured browser size of 1280 by
720 browser units (CSS pixels). Each fixture retains the complete saved page
so tests prove the extractor can find the artwork section among unrelated
search results.

The files are development fixtures only. The extractor must not fetch their
URLs, execute their scripts, or use any expected JSON file at runtime.
Every retained page in this directory has exactly one artwork section marker.
Pages without that marker are not retained or treated as supported artwork
pages.

Together, these fixtures cover four distinct artist search terms. Each page has
independently reviewed expected JSON and an exact-output test.

## Reviewed expected-output policy

The expected objects follow the challenge contract: the sole top-level key is
`artworks`. Cards remain in the order they appear in the saved HTML. Displayed
names and extensions are trimmed only at their boundaries; blank extensions
are omitted. Relative card links are resolved against
`https://www.google.com` without following them. A nonblank `data-src` image
is preferred, followed by a real `src`, and the source string is otherwise
preserved byte-for-byte. No image was downloaded, validated remotely,
re-encoded, or inferred.

The expected files were produced offline with selectors chosen for each saved
page. They were then reviewed for card count, first and last item, complete
ordering, omitted optional extensions, image-source type, and absolute Google
links. The review selectors are recorded below so another person can check the
expected data independently; the production parser does not use them.

## Claude Monet artworks

- File: `claude-monet-artworks.html`
- Query: `monet paintings`
- Artwork section marker: `data-attrid="kc:/visual_art/visual_artist:works"`
- Review-only card path: `.RXkTC > .TILZre`
- Review-only fields: `.yfEcJe` for the name and `.DWyOHb` for the
  optional year
- Cards: 50, from `Impression, Sunrise` through `Le Bassin aux Nymphéas`
- Extensions: 46 present and four omitted: `Bouquet of Sunflowers`, `Path in
  the Wheat at Pourville`, `Irises`, and `On the Bank of the Seine,
  Bennecourt`
- Images: eight JPEG data URIs already present in `src`, followed by 42 HTTPS
  URLs in `data-src`
- Links: all 50 source links are relative Google `/search` links; all 50
  expected links are absolute HTTPS URLs under `www.google.com`

This page represents a different saved image state from the supplied Van Gogh
page. Its initially visible images are already in `src`; extraction must use
them directly instead of depending on `_setImagesSrc` assignments in saved
scripts. It also exercises a different card count, a different set of missing
years, Unicode text, and 42 image URLs in `data-src`.

## Pablo Picasso artworks

- File: `pablo-picasso-artworks.html`
- Navigation: searched for `Pablo Picasso`, then selected the `Artworks` tab in
  Google's information panel; the resulting query was `picasso paintings`
- Evidence that Artworks was selected: exactly one artwork section marker and
  an exact `Artworks` label whose `aria-current="page"` attribute marks it as
  the selected tab
- Review-only card path: `.RXkTC > .TILZre`
- Review-only fields: `.yfEcJe` for the name and `.DWyOHb` for the
  optional year
- Cards: 45, from `Guernica` through `The Two Saltimbanques`
- Extensions: 40 present and five omitted: `Tête de Femme`, `Woman's Head`,
  `War and Peace`, `The Women of Algiers`, and `Weeping Woman with
  Handkerchief`
- Images: eight JPEG data URIs already present in `src`, followed by 37 HTTPS
  URLs in `data-src`
- Links: all 45 source links are relative Google `/search` links; all 45
  expected links are absolute HTTPS URLs under `www.google.com`

This page covers a separate artist search with its own 45-card exact contract.
It also contains an unrelated Images result section. The artwork section
marker and selected tab, not merely the words `Images` or `Artworks` elsewhere
on the page, establish what this fixture contains.

## Frida Kahlo artworks

- File: `frida-kahlo-artworks.html`
- Navigation: searched for `Frida Kahlo`, then selected the `Artworks` tab in
  Google's information panel; the resulting query was `frida kahlo
  paintings`
- Evidence that Artworks was selected: exactly one artwork section marker and
  an exact `Artworks` label whose `aria-current="page"` attribute marks it as
  the selected tab
- Review-only card path: `.RXkTC > .TILZre`
- Review-only fields: `.yfEcJe` for the name and `.DWyOHb` for the
  optional year
- Cards: 49, from `Frieda and Diego Rivera` through `Self Portrait with Curly
  Hair`
- Extensions: 46 present and three omitted: `Self-Portrait as a Tehuana`,
  `The Wounded Table`, and `Self Portrait with Stalin`
- Images: six JPEG data URIs already present in `src`, 41 HTTPS URLs in
  `data-src`, and two valid cards with no recoverable real image
- Image omissions: `The Broken Column` and `Self-Portrait with Thorn Necklace
  and Hummingbird`; their image elements and inline assignments contain only
  the known one-pixel placeholder
- Links: all 49 source links are relative Google `/search` links; all 49
  expected links are absolute HTTPS URLs under `www.google.com`

This saved page provides a real example of optional image omission. The two
placeholder-only cards remain valid and retain their name, year, and link;
only `image` is omitted. As with Picasso, an Images section also exists
elsewhere on the result page, while the information-panel navigation marks
Artworks as selected.

## Zdzisław Beksiński artworks

- File: `zdzislaw-beksinski-artworks.html`
- Navigation: searched for `Zdzisław Beksiński`, then selected the `Artworks`
  tab in Google's information panel; the resulting query was
  `zdzisław beksiński art`
- Evidence that Artworks was selected: exactly one artwork section marker and
  an exact `Artworks` label whose `aria-current="page"` attribute marks it as
  the selected tab
- Review-only card path: `.RXkTC > .TILZre`
- Review-only fields: `.yfEcJe` for the name and `.DWyOHb` for the
  optional year
- Cards: seven, from `Krajobraz cmentarny` through `Untitled "Faces"`; the
  complete page contains no additional `.TILZre` card or Show More control
- Extensions: all seven year fields are blank, so every result omits
  `extensions`
- Images: all seven JPEG data URIs are already present in `src`; there are no
  `data-src` URLs or image omissions
- Links: all seven source links are relative Google `/search` links; all seven
  expected links are absolute HTTPS URLs under `www.google.com`

This capture adds real-page coverage for a complete list in which every
optional extension is absent, every thumbnail is already in `src`, and the
output preserves Polish-language titles and embedded quotation marks. A
separate Images section also exists elsewhere on the page; the artwork section
marker and selected navigation state establish that this fixture is Artworks.

## Sanitization review

All four HTML pages were scanned for email addresses, Google API keys, JSON Web
Tokens (JWTs), authorization or cookie headers, common Google session-cookie
names, and private-key material; none were found. The visible `Sign in`
control confirms that no Google account was attached to any capture.

Google nevertheless embedded an approximate city inferred from the internet
connection's IP address outside the artwork section. In every page, three
copies of the location were replaced with `SANITIZED_LOCATION`, two copies of
its explanatory label were replaced with `SANITIZED_LOCATION_SOURCE`, and the
adjacent undocumented location value was replaced with
`SANITIZED_LOCATION_TOKEN`. These six substitutions per page do not change an
artwork card or expected field.

Google's cross-site request forgery (XSRF) protection strings matching
`AF5tSO…:<timestamp>` were unrelated to the tested artwork sections and were
replaced mechanically with `SANITIZED_XSRF_TOKEN`: 11 occurrences in the Monet
page, eight in the Picasso page, seven in the Frida page, and 13 in the
Beksiński page. A SHA-256 hash of each artwork section was the same before and
after sanitization, proving that the replacements did not change the tested
HTML. They also did not change any artwork field or expected output. Google
request and analytics identifiers needed to preserve the captured markup
relationships remain, but they are not authentication credentials. An empty
in-app browser sidebar element is also retained outside the search results; it
contains no comments or user data.

## SHA-256 checksums

A SHA-256 checksum is a file fingerprint used to detect changes. These
checksums describe the sanitized HTML and reviewed expected files:

| File | SHA-256 |
| --- | --- |
| `claude-monet-artworks.html` | `3dbb1b09f9ea5124027aad2272c4c7c1ba3d4ee566225046a91366641b8ec51f` |
| `claude-monet-artworks.expected.json` | `bc126be0108bb861602d239c5adf0e8566987d178e78a20d7803b68de33bae7e` |
| `pablo-picasso-artworks.html` | `d63d3fa98ad32ffeb4e2d03ec23823b17bba66c2fe0c6a2e3c32e0d413b98866` |
| `pablo-picasso-artworks.expected.json` | `41a6afc059c57ebc7435970baf941bfff963f0a37f50bbce05133568277f10f1` |
| `frida-kahlo-artworks.html` | `5397e8d5c70d8a22fc0c0b70d057921322f3eec47df40097d9249670affe7086` |
| `frida-kahlo-artworks.expected.json` | `65e5cd39108bb6134ba4d6b020a7ba23514283dde58b325da06b30254c4d5573` |
| `zdzislaw-beksinski-artworks.html` | `96f3555e81868eb91678710773d91d9fb7ed34d591a38a10c4feb18de2a5e4e7` |
| `zdzislaw-beksinski-artworks.expected.json` | `04707e6e043126e4435fe5399aac1bdb5cab6b83c4603f8ede4e3d0f75947c6d` |
