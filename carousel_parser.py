"""Pull the artworks carousel out of a saved Google results page.

Google shows a scrolling row of related items at the top of some searches (here
it's Van Gogh paintings). Each one is an <a> that links to another Google search
and has a thumbnail, a name, and sometimes a year. This turns that into:

    {"artworks": [{"name", "extensions", "link", "image"}, ...]}

Two things about the HTML are worth knowing:

1. The class names (iELo6, pgNMRc and so on) are random-looking and Google
   changes them between pages, so I don't use them. I look for the shape instead:
   an <a> whose URL path is /search, with a stick= param, that has an <img>
   inside. On the sample page that's exactly the 47 items and skips the
   "More"/"See more" links (they have stick= but no image). If there's a
   <g-scrolling-carousel> wrapper I only look inside it so other sections of the
   page don't leak in.

2. The <img src> is always a 1x1 placeholder, so the real thumbnail is one of: a
   data-src URL, a base64 image set by an inline _setImagesSrc script, or nothing
   (in which case it'd need another request, so image comes out null).
"""

from __future__ import annotations

import codecs
import json
import re
import sys
from dataclasses import dataclass
from typing import Optional
from urllib.parse import urlparse

from bs4 import BeautifulSoup
from bs4.element import Tag

try:  # if lxml isn't installed bs4 raises this; we fall back below
    from bs4 import FeatureNotFound
except ImportError:  # very old bs4
    FeatureNotFound = Exception  # type: ignore

GOOGLE_BASE_URL = "https://www.google.com"

# Use lxml if it's there (faster), otherwise the built-in parser, so the only
# thing you really need installed is beautifulsoup4.
_HTML_BACKENDS = ("lxml", "html.parser")

# The inline scripts that set the deferred images look like:
#   (function(){var s='data:image/jpeg;base64,...';var ii=['dimg_1'];var r='';
#    _setImagesSrc(ii,s,r);})();
_IMAGE_SCRIPT_RE = re.compile(r"var s='(data:image/[^']*)';var ii=\[([^\]]*)\]")
_QUOTED_ID_RE = re.compile(r"'([^']+)'")


@dataclass
class Artwork:
    """One carousel entry. extensions is left out when it's empty, and the keys
    come out in the order name, extensions, link, image."""

    name: str
    extensions: list[str]
    link: str
    image: Optional[str]

    def to_dict(self) -> dict:
        result: dict = {"name": self.name}
        if self.extensions:
            result["extensions"] = self.extensions
        result["link"] = self.link
        result["image"] = self.image
        return result


def _make_soup(html: str) -> BeautifulSoup:
    for backend in _HTML_BACKENDS:
        try:
            return BeautifulSoup(html, backend)
        except FeatureNotFound:
            continue
    return BeautifulSoup(html, "html.parser")  # stdlib, always available


def _decode_js_string(value: str) -> str:
    """Un-escape the JS string escapes in the base64, e.g. \\x3d back to =.

    Only \\xHH (and, to be safe, \\uHHHH) turn up. base64 is plain ASCII so the
    latin-1 round-trip doesn't lose anything.
    """
    return codecs.decode(value.encode("latin-1", "backslashreplace"), "unicode_escape")


def _build_image_map(html: str) -> dict[str, str]:
    """Map each deferred <img id> to its real data: URI.

    If the same id gets set more than once I keep the first one, since that's the
    one the browser actually shows.
    """
    image_map: dict[str, str] = {}
    for match in _IMAGE_SCRIPT_RE.finditer(html):
        data_uri = _decode_js_string(match.group(1))
        for img_id in _QUOTED_ID_RE.findall(match.group(2)):
            image_map.setdefault(img_id, data_uri)
    return image_map


def _is_carousel_item(anchor: Tag) -> bool:
    """True if this <a> is a carousel item: a /search link with stick= that has an
    <img> inside.

    Works whether the href is relative (/search?...) or absolute
    (https://www.google.com/search?...), because saving a page rewrites them to
    the full URL.
    """
    href = anchor.get("href", "")
    if "stick=" not in href or anchor.find("img") is None:
        return False
    return urlparse(href).path == "/search"


def _item_anchors(soup: BeautifulSoup) -> list[Tag]:
    """The carousel item anchors.

    If there's a <g-scrolling-carousel> wrapper I only look inside it, so
    look-alike links elsewhere on the page don't get picked up. If there isn't one
    I look at the whole page (the Van Gogh sample has no wrapper).
    """
    carousels = soup.find_all("g-scrolling-carousel")
    scopes = carousels if carousels else [soup]

    anchors: list[Tag] = []
    seen: set[int] = set()
    for scope in scopes:
        for anchor in scope.find_all("a", href=True):
            if _is_carousel_item(anchor) and id(anchor) not in seen:
                seen.add(id(anchor))
                anchors.append(anchor)
    return anchors


def _resolve_image(img: Tag, image_map: dict[str, str]) -> Optional[str]:
    """The real thumbnail: data-src URL, then the base64 from the script, then a
    plain http src, otherwise None."""
    data_src = img.get("data-src")
    if data_src and data_src.startswith("http"):
        return data_src

    deferred = image_map.get(img.get("id", ""))
    if deferred:
        return deferred

    src = img.get("src")
    if src and src.startswith("http"):
        return src

    return None  # not in the page, would need another request


def _item_name(anchor: Tag, img: Optional[Tag], lines: list[str]) -> str:
    """The full name.

    Google does this two ways. Sometimes the name is in img[alt]. Other times alt
    is empty, the visible text is cut short ("The Starry...") and the full name is
    in the anchor's aria-label or data-entityname. So I try those first, then alt,
    then the first bit of text. The alt-layout pages don't have those attributes
    so they aren't affected.
    """
    for candidate in (
        anchor.get("aria-label"),
        anchor.get("data-entityname"),
        img.get("alt") if img else None,
    ):
        if candidate and candidate.strip():
            return candidate.strip()
    return lines[0] if lines else ""


def _item_extensions(lines: list[str], name: str) -> list[str]:
    """The visible lines left over after the name.

    In the alt layout the name is one line, but in the aria-label layout it wraps
    over a couple ("The Starry" + "Night"), so I eat the leading lines that add up
    to the name and keep the rest. If none of them line up, just drop the first
    line.
    """
    if not lines:
        return []
    target = " ".join(name.split())
    accumulated = ""
    consumed = 0
    for line in lines:
        candidate = " ".join((accumulated + " " + line).split())
        if candidate and (candidate == target or target.startswith(candidate)):
            accumulated, consumed = candidate, consumed + 1
            if candidate == target:
                break
        else:
            break
    return lines[max(consumed, 1):]


def _extract_artwork(anchor: Tag, image_map: dict[str, str]) -> Artwork:
    img = anchor.find("img")
    lines = [text.strip() for text in anchor.stripped_strings if text.strip()]

    # name comes from an attribute (see _item_name), extensions are what's left
    name = _item_name(anchor, img, lines)
    extensions = _item_extensions(lines, name)

    href = anchor["href"]
    link = GOOGLE_BASE_URL + href if href.startswith("/") else href
    image = _resolve_image(img, image_map) if img else None
    return Artwork(name=name, extensions=extensions, link=link, image=image)


def parse_artworks(html: str) -> list[dict]:
    """Parse a saved Google page and return the carousel as a list of dicts."""
    soup = _make_soup(html)
    image_map = _build_image_map(html)
    return [_extract_artwork(a, image_map).to_dict() for a in _item_anchors(soup)]


def parse_file(path: str) -> list[dict]:
    with open(path, encoding="utf-8") as handle:
        return parse_artworks(handle.read())


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print("usage: python carousel_parser.py <path-to-serp.html>", file=sys.stderr)
        return 2
    try:
        artworks = parse_file(argv[1])
    except FileNotFoundError:
        print(f"error: file not found: {argv[1]}", file=sys.stderr)
        return 1
    print(json.dumps({"artworks": artworks}, indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main(sys.argv))
    except BrokenPipeError:
        # someone closed the pipe (e.g. | head), just exit quietly
        sys.exit(0)
