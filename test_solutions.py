import json
import pytest
from hardcoded_solution import get_artworks as hardcoded_get_artworks
from generalized_solution import get_artworks as generalized_get_artworks


# hardcoded solution

def test_hardcoded_matches_expected():
    with open('files/expected-array.json') as f:
        expected = json.load(f)

    result = hardcoded_get_artworks()

    assert result == expected


# generalized solution

# exact match against van gogh expected array
def test_generalized_van_gogh_matches_expected():
    with open('files/expected-array.json') as f:
        expected = json.load(f)

    result = generalized_get_artworks('files/van-gogh-paintings.html')

    assert result == expected


# check marvel has items and each has a name and google link
def test_generalized_marvel():
    result = generalized_get_artworks('files/marvel.html')

    assert len(result['artworks']) > 0
    for item in result['artworks']:
        assert item.get('name')
        assert item.get('link', '').startswith('https://www.google.com')


# check beatles has items and each has a name and google link
def test_generalized_beatles():
    result = generalized_get_artworks('files/beatles.html')

    assert len(result['artworks']) > 0
    for item in result['artworks']:
        assert item.get('name')
        assert item.get('link', '').startswith('https://www.google.com')
