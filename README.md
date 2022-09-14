# Extract Van Gogh Paintings Code Challenge

This repository contains a script for extracting van gogh paintings from a search results html page.

The same script works more generally for google search results page containing a **knowledge graph carrousel** of items.
## Running Instructions

### 1. Install the gems
```shell
bundle install
```
### 2. Run the script
Run the extract_items script with the following 2 arguments:
- path_to_html_file: The path to the HTML file from which data will get extracted
- root_node_name: The node name in the result JSON file. Eg: 'artworks'

```shell
extract_items path_to_html_file.html root_node_name
```

PS: You might need to give execution right to the script file, before being able to run it:
```shell
chmod +x extract_items.sh
```
### 3. Check the output json file

Running `extract_items file.html artworks` will produce a JSON file with the same name _file.json_

## Testing
### Automated tests
Tests are under the tests folder.
You can run the whole test suite with:
```
  rspec spec
```

PS:
- We use the watir gem, to render the HTML file, in order to let javascript dom changes to be processed. This is not an additional request, but a rendering of a local saved html file: `file:///`
- For [watir](https://github.com/watir/watir) to run, you need to install the chromedriver from Selenium. See [here](https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver).

