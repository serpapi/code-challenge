# Notes

## Deviations from the original `expected-array.json`

### URL Format

The `link` field in `tests/ref/*.result.json` (which tests are ran against) have a minute difference from the provided `expected-array.json`.

In `expected-array.json` the URL is in the original form, in which `'` in URL query params are not escaped.

In my implementation however, since the original URL is resolved against `https://www.google.com` with Node.js `new URL()`, the output URL has `'`s in query params escaped. e.g.:

Original form:

```
https://example.com/?q=SerpApi's
```

My output:

```
https://example.com/?q=SerpApi%27s
```

Both are valid URLs, and they're functionally identical. Ali confirmed to me that "as long as URLs are working, this shouldn't be an issue", so I escaped the apostrophes in query params to match my implementation.

### `\x3d`

In `expected-array.json`, some image data URLs in `image` field ends with `x3d`. That caught my attention, and a quick confirmation against the original HTML suggested that this is a mistake.

In the original HTML, they're `\x3d`, not `x3d`. For JavaScript string literals, `\x[0-9a-f]{2}` denotes a character in hexadecimal character code. In this case, `\x3d` is actually `=` (which explains why it sometimes appears at the end of base64-encoded data URL).

Thus I changed my test expectations accordingly to match my correct implementation.
