#!/bin/zsh

# Check if a html file path argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <html_file_path>"
  exit 1
fi

file_path="$1"
ruby -r '../lib/main' -e 'html = File.read("'$file_path'", encoding: "utf-8"); parser = Main.new(html); result = parser.parse_automated;'
