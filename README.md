# Extract Van Gogh Paintings Code Challenge

Extracting a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

```
1. bundle install
2. rspec
```

The code that parses the HTML file is in [`parse.rb`](parse.rb). Besides the image, the data points are extracted using Nokogiri's `.xpath('...').attribute('x').value`. The image is extracted using a regex to match within that part of the javascript that loads the images into the page.

[`expected-array.json`](files/expected-array.json) was modified to include the opening and closing curly braces `{}` in order to make the file valid JSON.

I attempted to obtain search results returning a similar carousel, but was unable to find any. The [`rembrandt-paintings.html`](files/rembrandt-paintings.html) HTML file is representative of the type of response currently displayed by Google. These files are structured very differently than that given for the exercise.

