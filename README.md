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

# Implementation

We need to parse the page and output the gallery's content as JSON, matching the structure in [files/expected-array.json](files/expected-array.json):

Output JSON structure:
```json
{
    "artworks": [
        {
            "name": "The Starry Night",
            "extensions": ["1889"],
            "link": "https://www.google.com/search?...",
            "image": "data:image/jpeg;base64,..." // or external URL
        }
    ]
}
```
## Locating the Needed Content

![Data](docs/screenshots/data.png)

**Artwork Gallery**: Can be located using the `[data-attrid="kc:/visual_art/visual_artist:works"]` selector.
**Gallery Items**: Each anchor (`a`) element in the gallery with an `href` attribute that begins with `/search?sca_esv`

## Output JSON - what's needed

### $.artworks[*].name
Each gallery item's `img` tag has an `alt` attribute containing the artwork's name. This value is also duplicated as the first item in the "extensions" section (see the screenshot). I chose to use the `alt` attribute.

Although both values match, in a real-world environment they should be double-checked.

### $.artworks[*].extensions

Each gallery item contains a list of text elements that can be accessed using `element.xpath('./div/div')`. These elements include:

1. The artwork name (first element)
2. Additional details like year, medium, etc. (subsequent elements)

When comparing against [files/expected-array.json](files/expected-array.json), we only want to include the additional details (elements after the first one) in the `extensions` array. The artwork name is already captured separately in the `name` field.

For example, for "The Starry Night":
- First element: "The Starry Night" (excluded from extensions)
- Second element: "1889" (included in extensions)

### $.artworks[*].link

Each **Gallery Item** link has a `href` attribute (see the screenshot).

### $.artworks[*].image

The "image" attributes in the expected JSON contain two types of URLs:

| Type | Base64-encoded thumbnails | External image references |
|------|--------------------------|--------------------------|
| When used | Items displayed immediately | Items after clicking "Show more" |
| Location | First page of gallery | Additional pages |
| Format | `data:image/jpeg;base64,...` | `https://encrypted-tbXX.gstatic.com/images?q=tbn:...` |
| Initial state | `img[src]` has placeholder | `img[src]` has placeholder |
| Data source | JavaScript replaces `img[src]` using `img[id]` | `img[data-src]` contains actual URL |
| `data-src` present? | No | Yes |
| Value to use | Final `img[src]` value | `img[data-src]` value |

**Solution**: Use `img[data-src]` if present, otherwise `img[src]`

⚠️ The fact that `img[src]` is being replaced by JavaScript with another value has implications for the implementation.

## Parsing the page: technology choice

Since the page relies on **JavaScript** execution, we have two options:
1. Parse the values for `img[src]` from the JavaScript code.
2. Execute JavaScript on the page to perform the task.

Here's a comparison of these two approaches:

| Aspect | Direct parsing (Nokogiri/ruby) | Headless browser (Ferrum) |
|--------|--------------------------------|---------------------------|
| Performance | ✅ Faster execution | ❌ More overhead, slower |
| Implementation | ❌ Tighter coupling to Google's code, **Fragile** | ✅ Simpler implementation |
| Testing needs | ❌ Requires extensive E2E testing: JS code may change | ✅ Less testing complexity |
| Long-term viability | ❌ More maintenance needed | ✅ More sustainable |
| CAPTCHA handling | ❌ No Javascript | ✅ Better handling |

**I chose to use Ferrum** as it seems to be the more sustainable approach. We can optimize this if/when performance becomes an issue.

Now that the `img[src]` placeholder is replaced by real value, we can use it to set the `image` attribute in the output JSON.

## Code architecture
We can start from being as simple as it gets: the whole implementation would fit in 50 LOC.

On the long run, for multiple types of Galleries and GalleryItems, it's recommended to have an abstract class for Gallery and GalleryItem.

Then gallery-specific differences will be implemented in corresponding Gallery/GalleryItem subclasses.

Use GalleryParserFactory that inspects the DOM and returns appropriate parser.


## Thread Safety

Ferrum’s Browser and its pages are not guaranteed to be thread-safe. Sharing a single browser instance across threads can lead to race conditions or unexpected behavior.

For a multi-threaded context, instantiate a new parser (and thus a new browser) per thread.