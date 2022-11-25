### Google Carousel Image Parser

#### Description

Contains a parser class that looks for an HTML element with tag
`g-scrolling-carousel` (the carousel) and then its child anchor and
`g-img` tags.

The page has some JavaScript that needs to be run to properly fill
image sources. For this, Selenium is used with the requirement that
the user will have Selenium and Chrome installed on their machine.

NodeJS and other solutions were considered but this was easier, in
the given time - plus, fewer lines to review this way.

#### Preparation

```sh
cd /path/to/repo
cd google-carousel-image-parser
# Gemfile expects `.ruby-version` file
# work has been tested with Ruby v2.7.6 and v3.1.2
bundle install
```

#### Tests

```sh
cd /path/to/repo
cd google-carousel-image-parser
ruby test_google_carousel_image_parser.rb
```

Sample passing results:

```
Loaded suite test_google_carousel_image_parser
Started
.
Finished in 5.589912 seconds.
----------------------------------------------------------------------------------------
1 tests, 540 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
----------------------------------------------------------------------------------------
0.18 tests/s, 96.60 assertions/s
```

#### Interactive

Run IRB from the `google-carousel-image-parser` directory, then:

```ruby
require_relative 'google_carousel_image_parser'
file_path = '/path/to/your/file.html'
GoogleCarouselImageParser.new(absolute_file_path: file_path).parse
```
