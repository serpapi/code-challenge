# Getting Started

The project is written in python and assumes python3.* is already installed on the local machine.

Create a virtual environment to manage dependencies by running:

```sh
python -m venv venv
```

Activate the virtual environment and install dependencies:

```sh
source venv/bin/activate

pip install -r requirements.txt
```

The project is dependent on BeautifulSoup for scraping.

Run the scraper tool:
```sh
python main.py
```

The scraper will save the result in `result.json` file.

## Unit Tests

Tests are written in the `tests.py` file using python's inbuilt unittest.

To run the tests:

```sh
python -m unittest tests
```

## TODO

1. Update the scraper to be able to pull live data with user input
2. Update the scraper to pick Google's new format for painting data
3. Use the scraper as a starting point for a Google paintings API with API key authentication and option to save results as csv.



