# PryWrench

This unpublished gem pulls data out of an HTML file.


## Usage

Probably just run the tests, but in theory...

```
require 'pry_wrench'

thumbnails = PryWrench.process_html(raw_html)

thumb = thumbnain.first
puts "Name: #{thumb[0]}"
```

## Development

Install dependencies with...

    $ bundle

Run the entire unit test suite with...

    $ rake
