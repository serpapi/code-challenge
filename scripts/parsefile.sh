#!/bin/zsh

# Check if an argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

file_path="$1"

ruby -r '../lib/carousel_parser' -e 'html = File.read("'$file_path'", encoding: "utf-8"); parser = CarouselParser.new(html); result = parser.parse;'
