import pytest
import json

from src import extract

JSON_FILE = 'files/expected-array.json'

@pytest.fixture()
def expected():
    with open(JSON_FILE) as f:
        data = f.read()

    data = '{' + data  + '}'
    json_data = json.loads(data)

    return json_data

@pytest.fixture()
def result():
    return extract.extract_from_html()






# test name attributes
@pytest.fixture()
def expected_name(expected):
    return expected["artworks"][0]["name"]

@pytest.fixture()
def result_name(result):
    return result["artworks"][0]["name"]

def test_expected_name(expected_name):
    assert expected_name == "The Starry Night"


def test_names(result_name, expected_name):
    assert result_name == expected_name



    


# test extensions attributes
@pytest.fixture()
def expected_extensions(expected):
    return expected["artworks"][0]["extensions"]

@pytest.fixture()
def result_extensions(result):
    return result["artworks"][0]["extensions"]

def test_extensions(result_extensions, expected_extensions):
    assert result_extensions == expected_extensions
