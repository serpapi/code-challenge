require 'json'
require 'nokogiri'
require_relative 'parser'

def readFile path
  File.read(path)
end

def parse path
  puts '------------------' + path
  parser = Parser.new File.read(path)
  result = parser.parse
  puts JSON.pretty_generate(result)
  return
end

def main
  if ARGV.length == 0 then
    puts "Usage: ruby lib/main.rb path_to_file.html"
    exit 1
  end
  parse ARGV[0].to_str
  return
#  parse "./files/van-gogh-paintings.html"
#  parse "./files/picasso-paintings.html"
#  parse "./files/dali-paintings.html"
end

main()
