"""Tests for the carousel parser.

A few layers:
  - the main test checks the output matches the challenge's own
    expected-array.json exactly (that's the graded one);
  - some smaller tests check the shape (key order, the link format, the mix of
    image types) so if something breaks you can tell what;
  - a couple of unit tests for the tricky bits (the escape decoding, and keeping
    the first image when an id repeats);
  - the "other layouts" test runs every *.html + *.expected.json pair in
    tests/fixtures/, so dropping a new saved page in there adds a test on its own.
"""

import json
import pathlib

import pytest

import carousel_parser as carousel

REPO = pathlib.Path(__file__).parent
FILES = REPO / "files"
FIXTURES = REPO / "tests" / "fixtures"

VAN_GOGH_HTML = FILES / "van-gogh-paintings.html"
VAN_GOGH_EXPECTED = FILES / "expected-array.json"


def _load_json(path: pathlib.Path) -> dict:
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


@pytest.fixture(scope="module")
def van_gogh() -> list[dict]:
    return carousel.parse_file(str(VAN_GOGH_HTML))


@pytest.fixture(scope="module")
def van_gogh_expected() -> list[dict]:
    return _load_json(VAN_GOGH_EXPECTED)["artworks"]


# --------------------------------------------------------------------------- #
# Headline: 100% match against the provided expected output.
# --------------------------------------------------------------------------- #
def test_van_gogh_exact_match(van_gogh, van_gogh_expected):
    assert van_gogh == van_gogh_expected


# --------------------------------------------------------------------------- #
# Output contract on the Van Gogh page.
# --------------------------------------------------------------------------- #
def test_extracts_every_item(van_gogh):
    assert len(van_gogh) == 47


def test_key_order_matches_serpapi(van_gogh):
    # name, extensions (when present), link, image, in that order.
    with_ext = next(a for a in van_gogh if "extensions" in a)
    assert list(with_ext) == ["name", "extensions", "link", "image"]
    without_ext = next(a for a in van_gogh if "extensions" not in a)
    assert list(without_ext) == ["name", "link", "image"]


def test_every_item_has_a_nonempty_name(van_gogh):
    assert all(a["name"] and isinstance(a["name"], str) for a in van_gogh)


def test_links_are_absolute_google_search_urls(van_gogh):
    assert all(a["link"].startswith("https://www.google.com/search?") for a in van_gogh)
    assert all("stick=" in a["link"] for a in van_gogh)


def test_extensions_omitted_only_for_undated_items(van_gogh):
    undated = {a["name"] for a in van_gogh if "extensions" not in a}
    assert undated == {
        "Sunflowers",
        "Mulberry Tree",
        "Skull of a Skeleton with Burning Cigarette",
        "Vase with Cornflowers and Poppies",
    }
    # Every present extensions value is a non-empty list of strings.
    for artwork in van_gogh:
        if "extensions" in artwork:
            assert artwork["extensions"]
            assert all(isinstance(x, str) and x for x in artwork["extensions"])


def test_images_split_across_the_two_present_sources(van_gogh):
    base64 = [a for a in van_gogh if a["image"] and a["image"].startswith("data:image")]
    urls = [a for a in van_gogh if a["image"] and a["image"].startswith("http")]
    # No thumbnail on this page needs an extra request, so none are null.
    assert len(base64) == 8
    assert len(urls) == 39
    assert len(base64) + len(urls) == len(van_gogh)


def test_first_and_last_items_spot_check(van_gogh):
    first = van_gogh[0]
    assert first["name"] == "The Starry Night"
    assert first["extensions"] == ["1889"]
    assert first["image"].startswith("data:image/jpeg;base64,/9j/")

    last = van_gogh[-1]
    assert last["name"] == "Poppy Flowers"
    assert last["image"].startswith("https://encrypted-tbn")


# --------------------------------------------------------------------------- #
# Helper units for the two easy-to-get-wrong pieces.
# --------------------------------------------------------------------------- #
def test_decode_js_string_unescapes_hex():
    assert carousel._decode_js_string(r"AAAA\x3d\x3d") == "AAAA=="
    assert carousel._decode_js_string("no-escapes") == "no-escapes"


def test_image_map_keeps_first_assignment():
    html = (
        "<script>var s='data:image/jpeg;base64,FIRST';var ii=['id_a'];</script>"
        "<script>var s='data:image/jpeg;base64,SECOND';var ii=['id_a'];</script>"
        "<script>var s='data:image/png;base64,PAD\\x3d';var ii=['id_b','id_c'];</script>"
    )
    mapping = carousel._build_image_map(html)
    assert mapping["id_a"] == "data:image/jpeg;base64,FIRST"
    assert mapping["id_b"] == "data:image/png;base64,PAD="
    assert mapping["id_c"] == "data:image/png;base64,PAD="


# --------------------------------------------------------------------------- #
# CLI entry point.
# --------------------------------------------------------------------------- #
def test_cli_emits_wrapped_json(capsys):
    exit_code = carousel.main(["carousel_parser.py", str(VAN_GOGH_HTML)])
    assert exit_code == 0
    payload = json.loads(capsys.readouterr().out)
    assert list(payload) == ["artworks"]
    assert len(payload["artworks"]) == 47


def test_cli_usage_error_without_argument():
    assert carousel.main(["carousel_parser.py"]) == 2


def test_cli_missing_file_reports_error(capsys):
    assert carousel.main(["carousel_parser.py", "does-not-exist.html"]) == 1
    assert "not found" in capsys.readouterr().err


def test_stdlib_html_parser_produces_identical_result(van_gogh, van_gogh_expected):
    # The lxml -> html.parser fallback must not change the output.
    html = VAN_GOGH_HTML.read_text(encoding="utf-8")
    from bs4 import BeautifulSoup

    soup = BeautifulSoup(html, "html.parser")
    image_map = carousel._build_image_map(html)
    result = [
        carousel._extract_artwork(a, image_map).to_dict()
        for a in carousel._item_anchors(soup)
    ]
    assert result == van_gogh_expected


# --------------------------------------------------------------------------- #
# Other layouts. Proves the parser generalizes, and auto-tests real captures.
# --------------------------------------------------------------------------- #
def _discover_layout_pairs() -> list[pathlib.Path]:
    pairs = []
    for directory in (FIXTURES, FILES):
        for html_path in sorted(directory.glob("*.html")):
            if html_path.with_suffix(".expected.json").exists():
                pairs.append(html_path)
    return pairs


@pytest.mark.parametrize("html_path", _discover_layout_pairs(), ids=lambda p: p.stem)
def test_other_layout_exact_match(html_path):
    expected = _load_json(html_path.with_suffix(".expected.json"))["artworks"]
    assert carousel.parse_file(str(html_path)) == expected


def test_carousel_scoping_excludes_look_alike_links():
    # the monet fixture has decoys outside <g-scrolling-carousel>: a "More" link
    # (no image) and an image-bearing "People also search for" link
    result = carousel.parse_file(str(FIXTURES / "monet_carousel.html"))
    names = {a["name"] for a in result}
    assert "Édouard Manet" not in names  # image-bearing decoy, dropped by scoping
    assert "More" not in names
    assert len(result) == 5


def test_missing_thumbnail_resolves_to_null():
    result = carousel.parse_file(str(FIXTURES / "monet_carousel.html"))
    parasol = next(a for a in result if a["name"] == "Woman with a Parasol")
    assert parasol["image"] is None
