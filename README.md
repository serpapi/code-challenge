# Code Challenge

The objective is to extract name, link, extensions and image from 3 carousels. Instead of picking two very similar to "van gogh paintings" ("woody allen movies" and "michelangelo sculptures"), I've picked very different carousels.

As far as I've found, Google has 3 types of top carousels:

1. Horizontal list without sorting or filtering ("famous chefs", "US Presidents")
   1.1. First n names, links and extensions are part of the HTML.
   1.2. Names, links and extensions from the next page of the carousel are embedded in JS as hex-encoded HTML.
   1.3. First n images are embedded in JS as Base64.
   1.4. Images from the next page of the carousel are loaded via making requests.
2. Horizontal list with sorting or filtering ("van gogh paintings", "woody allen movies", "michelangelo sculptures")
   2.1. Name, link and extensions are part of the HTML.
   2.2. All images are embedded in JS as Base64.
3. 2D grid ("nobel prize winners", "katy perry songs")
   3.1. Name, link and extensions are part of the HTML.
   3.2. First n images are embedded in JS as Base64.
   3.3. Images from the next page of the carousel are loaded via making requests.

In this coding assignment, I'm extracting everything that doesn't involve making requests.

## What's included

1. Ruby code
2. RSpec tests
3. 100% test coverage, measured with SimpleCov
4. Strictly typed using Sorbet
   4.1. RSpec tests aren't typed yet, because of the amount of magic involved in the DSL.
   4.2. If run with MRI 2.7+, there are plenty of ruby warnings in the Sorbet codebase, as it isn't compatible yet with the latest Ruby.

## Notes

1. The sample HTML provided with the challenge, van-gogh-paintings.html, could not be used because Google's markup has diverged from that. If I were to use it, I'd need to handle both old and new markups for the same search page.

2. The structure of the expected JSON has been modified slightly to make sure the shape remains the same, even if certain keys (like extensions) have null values. I prefer to have the shape of the data consistent.
