# Arac

Arac is an easy-to-use Ruby library for web scraping. In the world of programming, "web scraping" refers to the process of extracting specific data from websites. This could involve sifting through the website's HTML content, finding specific elements (like headings, paragraphs, links, etc.), and pulling that data for further use.

Arac enables you to accomplish all this in a simple and efficient manner. Inspired by the precision of spiders' web construction (Arac is a playful twist on "Arachnid"), this library helps you weave your way through the web of HTML and pull out the data you need.

## Requirements

Arac requires Ruby 3.0.0 or later.

<!-- TODO(celicoo): publish to rubygems.org -->
<!-- ## Installation

To install Arac, you can use the standard gem installation command:

```bash
gem install arac
```

Or add this line to your application's Gemfile:

```bash
gem 'arac'
```

And then execute:

```bash
bundle install
``` -->

## Usage

### Usage for Reviewers of the Assignment

To review my solution, please follow these steps:

1. Pull the branch locally.
2. Navigate to the `arac/` directory.
3. Install the dependencies using `bundle install`.
4. Run the tests using `rspec`.

If you want to review the specific test suite related to the "Extract Van Gogh Paintings Code Challenge", you can find the tests in `spec/arac/serpapi_spec.rb`. This test file contains a suite of tests tailored to the requirements of the assignment. Here's how you can run them:

1. Ensure you are in the `arac/` directory.
2. Run the specific test suite using rspec `spec/arac/serpapi_spec.rb`.

If all tests pass, that indicates that the Arac library is successfully extracting the required information from the HTML.

### General Usage

Here's a simple usage example:

```ruby
require 'arac'

arac = Arac.new do
  item :title, selector: 'h1', methods: [[:text]]
  item :author, selector: '.author', methods: [[:text]]
end

html = "<html><body><h1>My First Heading</h1><p class='author'>John Doe</p></body></html>"

data = arac.capture_from(html)
puts data[:title] # Should output: My First Heading
puts data[:author] # Should output: John Doe
```

In this example, we initialize a new Arac instance with a block. Within this block, the `item` method is used to define the output specification. After setting up the output specification, we use the `capture_from` method to perform the data extraction. The extracted data can be accessed using the keys specified in the `item` method calls.

#### Nested Items Extraction

Arac supports nested item extraction. This allows you to scope your search within a specific part of the HTML document and extract multiple pieces of data from it. Here's an example:

```ruby
require 'arac'

arac = Arac.new do
  item :blog, selector: '.blog' do
    item :title, selector: 'h1', methods: [[:text]]
    item :author, selector: '.author', methods: [[:text]]
    item :content, selector: '.content', methods: [[:text]]
  end
end

html = "<html><body><div class='blog'><h1>Blog Title</h1><p class='author'>John Doe</p><p class='content'>This is some content.</p></div></body></html>"

data = arac.capture_from(html)
puts data[:blog][:title] # Should output: Blog Title
puts data[:blog][:author] # Should output: John Doe
puts data[:blog][:content] # Should output: This is some content.
```

In this example, the item `:blog` scopes the search to elements with the `.blog` class. Within this scope, the `title`, `author`, and `content` are then extracted. The resulting data can be accessed using nested keys in the returned hash.

In both examples, you can use the `:methods` option in the `item` method to specify the Nokogiri methods that should be called on each matching node. Each method should be represented as an array where the first element is the method name (as a symbol or a string), and the rest of the elements are the arguments to the method. The methods will be called in the order they appear in the array, and each one will be called on the return value of the previous method.

For example, `methods: [[:attr, 'href'], [:to_s]]` means that first the `attr` method will be called with the argument `'href'`, and then the `:to_s` method will be called on the result.

In the absence of a specific `:methods` option, the item method defaults to `methods: []`.

#### Array of Nested Items Extraction

Arac also supports extraction of arrays of nested items. This is useful when you need to extract similar data from multiple elements in the page. Here's an example:

```ruby
require 'arac'

arac = Arac.new do
  items :blogs, selector: '.blog' do
    item :title, selector: 'h1', methods: [[:text]]
    item :author, selector: '.author', methods: [[:text]]
    item :content, selector: '.content', methods: [[:text]]
  end
end

html = "<html><body><div class='blog'><h1>Blog Title 1</h1><p class='author'>John Doe</p><p class='content'>This is some content.</p></div><div class='blog'><h1>Blog Title 2</h1><p class='author'>Jane Doe</p><p class='content'>This is some other content.</p></div></body></html>"

data = arac.capture_from(html)
puts data[:blogs][0][:title] # Should output: Blog Title 1
puts data[:blogs][0][:author] # Should output: John Doe
puts data[:blogs][0][:content] # Should output: This is some content.
puts data[:blogs][1][:title] # Should output: Blog Title 2
puts data[:blogs][1][:author] # Should output: Jane Doe
puts data[:blogs][1][:content] # Should output: This is some other content.
```

## API Documentation

Detailed API documentation is included within the source code. You can refer to:

- [`lib/arac/extractor.rb`](lib/arac/extractor.rb): Defines the `Arac::Extractor` class, responsible for defining and performing data extraction based on a specified output specification.
- [`lib/arac/parser.rb`](lib/arac/parser.rb): Defines the `Arac::Parser` class, which is used to parse HTML and extract data based on CSS selectors.
