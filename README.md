# Extract Van Gogh Paintings Code Challenge

This is an implementation of the aforementioned challenge using NodeJS with HTML parsing using Cheerio.

## Scope and assumptions

During the research for this project, I came across multiple types of carousel-like views on various search pages; a collection of what I came across has been added to the `files` directory.

The carousel view originally provided in the repository through the `van-gogh-paintings.html` file are currently reproducible only for search queries involving politicians, such as "[us presidents](files/us-presidents.png)".

The query "van gogh paintings" and similar ones currently bring up a different image view that does not resemble the original file, as seen on "[rembrandt works](files/rembrandt-works.png)".

For movie/film related queries, there are at least two different kind of carousels that are used based on the query: (a) one being a simple list of images, as seen on "[interstellar actors](files/interstellar-actors.png)" and (b) an expanding card on hover, as seen on "[star wars movies](files/star-wars-movies.mp4)".

Therefore:

* Based on the aforementioned cases, I use an expanded definition of "carousel" to additionally handle the aforementioned extra cases. However, I also exclude other combinations of images accompanying text, such as videos or reviews, as seen on "[chicken recipes](files/chicken-recipes.html)"; or other lists of persons, such as "[cricket players](files/cricket-players.html)". The  behaviour of handling additional carousels can be turned off if required as explained in the [usage](#usage) section.
* In accordance with the statement of the original problem, it is assumed that all the information is already available in the DOM and there is no need to load lazy-loaded elements that require additional HTTP calls.
* There are a few cases where the DOM nor the Javascript does not contain the replacement for a placeholder image, because the image is hidden and hasn't been loaded yet, as can be seen in the [rembrandt-works.html](files/rembrandt-works.html). In this case, I emit the placeholer image in the final array. In a real-world implementation, this could be improved upon by trying to load the image metadata and rejecting it if it is a 1x1 pixel.
* If there are multiple carousels on the page, only the first one is taken; an example of this is in [sci-fi-movies.html](files/sci-fi-movies.html).
* In the original version of the repository, the `expected-array.json` contains invalid trailing Base64 characters such as `x3d` which appear to be incorrect as they seem to be the Base64 padding encoded incorrectly, and also an invalid JSON structure with the floating `"artworks"` token. I believe these are mistakes; my implementation does not have these behaviours.

## Usage

Download the dependencies of the project using `npm ci`; the project was tested using node 20.x.

Once the dependencies are downloaded, use the following command to extract the JSON from the `files/` directory.

```bash
npm run extract -- -d files
```

If you want to prevent parsing of the additional carousel styles, use the following command:

```bash
npm run extract -- --v1 -d files
```

If you want to convert a specific file, use the following command instead:

```bash
npm run extract -- files/test.html
```

If you want to also customize the output filename/directory, use the following commands:

```bash
npm run extract -- files/test.html -o files/test.json
mkdir output_files && npm run extract -- -d files -o output_files
```

To run the tests associated with the project, run:

```bash
npm test
```
