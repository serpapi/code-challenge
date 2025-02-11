## Installation

```bash
# Ensure Ruby is installed, e.g.
# apt-get install ruby ruby-bundler

bundle install
```

## Usage

```bash
# Example
bundle exec ./lib/main.rb files/jackson-pollock-paintings.html | jq

# General
bundle exec ./lib/main.rb <path/to/file.html> [<path/to/file.html> ...]
```

The JSON documents will be printed to STDOUT.
Info messages will be printed to STDERR.

If there's a SerpAPI metadata file available at the same path with a `.json`
file suffix instead of a `.html` one, the output will contain absolute URLs.
Otherwise links will be relative.

## Testing

```bash
bundle exec rspec
```
