#!/usr/bin/env ruby

if ARGV.empty?
  warn <<~USAGE
    bundle exec #{$0} <path/to/file.html> [<path/to/file.html> ...]
  USAGE
  exit(1)
end

require_relative "./parse_utils"

errors = false
ARGV.each do |file|
  warn "Processing `#{file}`"
  data = ParseUtils.parse_file(file)
  puts JSON.dump(data)
rescue => e
  warn "Failed to process `#{file}`: #{e}"
  # print empty object to allow matching input filenames to output documents
  # when processing multiple files
  puts "{}"
  errors = true
end

exit(1) if errors
