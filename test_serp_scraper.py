# Workin Test

import pytest
from bs4 import BeautifulSoup
from unittest import mock
from main import serp_scraper

@pytest.fixture
def sample_html():
    return """
    <html>
        <body>
            <a class="klitem" href="https://www.example.com/painting1">
                <div class="kltat">Painting 1</div>
                <div class="ellip klmeta">1889</div>
                <img class="rISBZc" src="thumbnail1.jpg">
            </a>
            <a class="klitem" href="https://www.example.com/painting2">
                <div class="kltat">Painting 2</div>
                <div class="ellip klmeta">1508</div>
                <img class="rISBZc" src="thumbnail2.jpg">
            </a>
        </body>
    </html>
    """

def test_serp_scraper_with_valid_html(sample_html):
    with mock.patch('builtins.open', mock.mock_open(read_data=sample_html)):
        artworks = serp_scraper('dummy_file_path')

    assert len(artworks) == 2

    artwork1 = artworks[0]
    assert artwork1['name'] == 'Painting 1'
    assert artwork1['extensions'] == ['1889']
    assert artwork1['link'] == 'https://www.example.com/painting1'
    assert artwork1['image'] == 'thumbnail1.jpg'

    artwork2 = artworks[1]
    assert artwork2['name'] == 'Painting 2'
    assert artwork2['extensions'] == ['1508']
    assert artwork2['link'] == 'https://www.example.com/painting2'
    assert artwork2['image'] == 'thumbnail2.jpg'

def test_serp_scraper_with_empty_html():
    with mock.patch('builtins.open', mock.mock_open(read_data='')):
        artworks = serp_scraper('dummy_file_path')

    assert artworks == []

def test_serp_scraper_with_missing_classes(sample_html):
    modified_html = sample_html.replace('klitem', 'nonexistent')

    with mock.patch('builtins.open', mock.mock_open(read_data=modified_html)):
        artworks = serp_scraper('dummy_file_path')

    assert artworks == []

def test_serp_scraper_with_alternative_classes(sample_html):
    modified_html = sample_html.replace('klitem', 'ct5Ked klitem-tr PZPZlf')
    modified_html = modified_html.replace('kltat', 'FozYP')

    with mock.patch('builtins.open', mock.mock_open(read_data=modified_html)):
        artworks = serp_scraper('dummy_file_path')

    assert len(artworks) == 2

    artwork1 = artworks[0]
    assert artwork1['name'] == 'Painting 1'
    assert artwork1['extensions'] == ['1889'] or artwork1['extensions'] == []
    assert artwork1['link'] == 'https://www.example.com/painting1'
    assert artwork1['image'] == None

    artwork2 = artworks[1]
    assert artwork2['name'] == 'Painting 2'
    assert artwork2['extensions'] == ['1508'] or artwork1['extensions'] == []
    assert artwork2['link'] == 'https://www.example.com/painting2'
    assert artwork2['image'] == None
