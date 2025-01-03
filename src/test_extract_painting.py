import pytest
from extract_paintings import read_html_file, parse_html, extract_paintings

@pytest.fixture
def load_html_file():
    def _load(file_path):
        content = read_html_file(file_path)
        return parse_html(content)
    return _load

def test_extract_van_gogh_paintings(load_html_file):
    soup = load_html_file('files/van-gogh-paintings.html')
    paintings = extract_paintings(soup)
    assert len(paintings) > 0
    for painting in paintings:
        assert 'name' in painting
        assert 'extensions' in painting
        assert 'link' in painting
        assert 'image' in painting

def test_extract_leonardo_da_vinci_paintings(load_html_file):
    soup = load_html_file('files/leonardo-da-vinci-paintings.html')
    paintings = extract_paintings(soup)
    assert len(paintings) > 0
    for painting in paintings:
        assert 'name' in painting
        assert 'extensions' in painting
        assert 'link' in painting
        assert 'image' in painting

def test_extract_pablo_picasso_paintings(load_html_file):
    soup = load_html_file('files/pablo-picasso-paintings.html')
    paintings = extract_paintings(soup)
    assert len(paintings) > 0
    for painting in paintings:
        assert 'name' in painting
        assert 'extensions' in painting
        assert 'link' in painting
        assert 'image' in painting

if __name__ == '__main__':
    pytest.main()