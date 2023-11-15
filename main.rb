# frozen_string_literal: true

require_relative "lib/page"

if __FILE__ == $PROGRAM_NAME
  page = Page.from_file_path "files/van-gogh-paintings.html"
  puts page.as_json

  page = Page.from_file_path "files/rembrandt-paintings.html"
  puts page.as_json
end
