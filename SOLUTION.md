# Extract van Gogh Paintings Code Challenge Solution

Michael Teter - <m@michaelteter.com>

The new files in `./solution/` folder provide an example solution with tests for the challenge.

## Usage

All activities should be done in the `./solution/` folder.

### Setup

```bash
make install
```

### Running the solution and the tests

To run the solution:

```bash
make run
```

To run the tests:

```bash
make test
```

## How the solution works

The solution opens the html file via Selenium with the
headless Chrome driver.  Once loaded and rendered, the
page source is sent to Nokogiri to for later use with
xpath queries for scraping data.

It is possible to skip Selenium and just open the html
source file in Nokogiri, but the resulting source is
different compared to going through Selenium (particularly
in the base64 img src thumbnails).  

I suspect some Google JavaScript was operating on page
content and hydrating the thumbnails, because the html file
vs Selenium output source html go from invalid short base64
strings to valid base64 image strings which can be used to
render the real images.

## Nokogiri xpath queries

Where possible, specific Nokogiri xpath queries were used
to keep the solution code brief and clean.  However,
there are some cases where we need to search for a css
class within a list of classes for one element; this
could be done using xpath tokenize, but `tokenize` is
available in xpath 2.0.

In the case of searching for a class within a possible list
of classes, we just iterate over all the elements and search
for the presence of the class name within the classes lists.

## Additional comments

The challenge instructions suggest to also test the solution
against additional (saved) html search pages, but I am
not able to get from Google Search a results page which
uses a carousel like the challenge sample html file has.

Perhaps Google has changed the layout significantly...?
Therefore, my solution only works for the sample file.
