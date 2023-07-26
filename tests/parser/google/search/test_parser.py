import os

import pytest

from serpapi.parser.google.search.models import SearchPage
from serpapi.parser.google.search.parser import GoogleSearchParser


def get_test_src_paths():
    ROOT_DIR = os.path.abspath(os.curdir)

    return [
        os.path.join(ROOT_DIR, "files/van-gogh-paintings.html"),
        os.path.join(ROOT_DIR, "files/da_vinci_artwork.html"),
        os.path.join(ROOT_DIR, "files/kazimir_malevich_artwork.html"),
    ]


@pytest.mark.parametrize("src_path", get_test_src_paths())
def test_fill_carousel_items(src_path):

    with open(src_path, "r") as f:
        data = f.read()

    entity = SearchPage()
    GoogleSearchParser(data)._fill_carousel_items(entity)

    carousel_items = entity.carousel_items
    assert carousel_items
    assert len(carousel_items)
    for i in carousel_items:
        assert i.name
        assert i.link
        assert i.image
