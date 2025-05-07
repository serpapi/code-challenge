# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

### Extractor Configuration (Selectors)

Each extractor (Paintings, Albums, Books) uses a YAML configuration file to define the selectors for extracting relevant fields from the HTML. This makes the extraction logic robust and easy to maintain when HTML structures change.

- **Selector Config Files:**
  - `lib/extractors/paintings/config/selectors.yml`
  - `lib/extractors/albums/config/selectors.yml`
  - `lib/extractors/books/config/selectors.yml`

- **Key Fields Extracted:**
  - `name`: The title of the artwork, album, or book
  - `extensions`: Additional info such as year or genre (as an array)
  - `link`: The URL to the detail page or resource
  - `image`: The image URL for the item

- **Selectors Format Example:**
  ```yaml
  name:
    xpath: ".//div[contains(@class, 'JjtOHd')]"
    css: ".JjtOHd"
  extensions:
    xpath: ".//div[contains(@class, 'ellip') and contains(@class, 'yF4Rkc') and contains(@class, 'AqEFvb')]"
    css: ".ellip.yF4Rkc.AqEFvb"
  link:
    xpath: ".//a/@href"
    css: "> a"
  image:
    xpath: ".//img/@src | .//img/@data-src"
    css: "img"
  ```

- **How Extraction Works:**
  - Each extractor (e.g., `PaintingsExtractor`) loads its selectors from the corresponding YAML file.
  - The `BaseExtractor` uses these selectors to extract the required fields from each HTML item.
  - If the HTML structure changes, update the selectors in the YAML file only—no Ruby code changes are needed.

- **Adding or Updating Extractors:**
  1. Create or update the relevant YAML file with new selectors.
  2. The extractor will automatically use the updated selectors on the next run.

---

### Extraction Script (Dynamic Extraction)

The extraction script (`scripts/extract_artwork_details.rb`) dynamically extracts artworks from Google search result pages for three types:
- **Paintings** (e.g., Van Gogh, Da Vinci)
- **Music Albums** (e.g., Lady Gaga)
- **Books** (e.g., J.K. Rowling)

No `--type` or `--output` argument is needed. The script prints the result directly to stdout as a JSON object with this structure:
- **artworks**: Contains all extracted items (paintings, albums, books) as a single array.

If no artworks are found, the output will be `{ "artworks": [] }`. The script is structured for easy future expansion by adding new extractors.

#### How to Run the Script

You can run the extraction script on any HTML file in the `files` directory. Here are example commands for all available HTML files:

```bash
ruby scripts/extract_artwork_details.rb --input files/van-gogh-paintings.html         # Van Gogh paintings
ruby scripts/extract_artwork_details.rb --input files/da-vinci-paintings.html        # Da Vinci paintings
ruby scripts/extract_artwork_details.rb --input files/claude-monet-paintings.html    # Claude Monet paintings
ruby scripts/extract_artwork_details.rb --input files/lady-gaga-albums.html          # Lady Gaga albums
ruby scripts/extract_artwork_details.rb --input files/jk-rowling-books.html          # J.K. Rowling books
```

You can also run extraction using the provided Rake task:

```bash
rake artwork:extract[files/van-gogh-paintings.html]   # Van Gogh paintings
rake artwork:extract[files/da-vinci-paintings.html]   # Da Vinci paintings
rake artwork:extract[files/claude-monet-paintings.html]   # Claude Monet paintings
rake artwork:extract[files/lady-gaga-albums.html]     # For music albums
rake artwork:extract[files/jk-rowling-books.html]     # For books
```

- The output will be printed to stdout as a JSON object containing an `artworks` array.
- All types (paintings, albums, books) are extracted into the same array structure.
- No extra HTTP requests are needed; all data is parsed directly from the HTML file.

#### Output Example
```json
{
  "artworks": [
    { "name": "The Starry Night", "extensions": ["1889"], "link": "...", "image": "..." },
    ...
  ]
}
```

All extracted artworks are included in the `artworks` array.
### Running the Tests

RSpec tests are included to ensure extraction works for all supported types (paintings, music albums, books) and different HTML structures:

```bash
bundle install
bundle exec rspec
```

- The tests check that the output is a JSON object with an `artworks` array at the top level, regardless of the input file.
- There are dedicated test cases for Van Gogh paintings, Da Vinci paintings, Lady Gaga albums, and J.K. Rowling books.
- Additional specs check that each artwork has non-empty `name`, `extensions`, `link`, and `image` fields.
- There is also a test for the Rake task (`spec/rake_task_spec.rb`) to ensure extraction works when run via Rake.
- Tests will print detailed diagnostics if there are any extraction or script errors.

### Extending the Extractor

To support additional sections (such as albums), expand the code in `scripts/extract_artwork_details.rb` to add new sections and output them under the `artworks` key.

---

