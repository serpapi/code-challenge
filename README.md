# Extract Van Gogh Paintings Code Challenge

This repository contains a script for extracting van gogh paintings from a search results html page.

The same script works more generally for google search results page containing a **knowledge graph carrousel** of items.
## Running Instructions

### 1. Install the gems
```shell
bundle install
```
### 2. Run the script
Run the extract_items script with the path to results page as an argument
```shell
extract_items path_to_html_file.html
```
### 3. Check the output json file

Running `extract_items file.html` will produce a JSON file with the same name _file.json_

## Testing
### Automated tests
Tests are under the tests folder.
You can run the whole test suite with:
```
  rspec tests
```

### Manual tests
TO BE COMPLETED