# Google Search Scrolling Carousel Parser

## Dependencies

```shell
bundle install
```

## Specs

```shell
% bin/rspec

# Randomized with seed 27526
# ..............
#
# Finished in 0.10585 seconds (files took 0.0838 seconds to load)
# 14 examples, 0 failures
#
# Randomized with seed 27526
```

## Implementation

For the purposes of this exercise I implemented two parser classes
(`Google::CarouselV1`, `Google::CarouselV2`) as specialized subclasses of a
`Google::SearchResultParser` parent class.

I use `Nokogiri` to handle the basic HTML parsing logic.

With more time I'd extend the parent class to automatically detect which parser
to use for a given document.
