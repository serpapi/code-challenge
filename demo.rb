#!/usr/bin/env -S ruby
# frozen_string_literal: true

require './extract_paintings'

GOOGLE_FILE = 'files/van-gogh-paintings.html'

args = ARGV
if args.delete('-h')
  puts "Usage:\n\n" \
       "  To dump the parsed data direcly to the Terminal\n"\
       "    ./demo.rb\n\n"\
       "  or to a file:\n"\
       "    /.demo.rb result_file.txt\n"
elsif args.size > 1
  puts "This demo takes one one parameter. Use '-h' to print a help message."
else
  output = ExtractPaintings.parse_html(GOOGLE_FILE)
  if args.empty?
    puts output
  else
    open(args.first, 'w') {|f| f << output  }
  end
end
