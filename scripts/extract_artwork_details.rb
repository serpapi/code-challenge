# frozen_string_literal: true

require 'nokogiri'
require 'json'
require 'open-uri'
require 'cgi'
require 'optparse'
require_relative '../lib/extractors/paintings/paintings_extractor'
require_relative '../lib/extractors/albums/albums_extractor'
require_relative '../lib/extractors/books/books_extractor'

GOOGLE_SEARCH_BASE_URL = 'https://www.google.com'

def extract_artwork_details(link)
  uri = URI.parse(link)
  params = CGI.parse(uri.query || '')
  params['q']&.first || ''
rescue StandardError
  ''
end

options = {
  input: File.expand_path('../files/da-vinci-paintings.html', __dir__)
}

begin
  OptionParser.new do |opts|
    opts.banner = 'Usage: extract.rb [options]'
    opts.on('--input PATH', 'Input HTML file') { |v| options[:input] = v }
  end.parse!
rescue StandardError
  nil
end

begin
  doc = Nokogiri::HTML(File.read(options[:input]))
rescue StandardError => e
  warn({ error: "Failed to read or parse input HTML file: #{e.message}" }.to_json)
  exit 2
end

gallery_extractors = [
  Extractors::Paintings::PaintingsExtractor,
  Extractors::Albums::AlbumsExtractor,
  Extractors::Books::BooksExtractor
]

artworks = gallery_extractors.flat_map { |extractor| extractor.new(doc).extract }

puts JSON.pretty_generate({ 'artworks' => artworks })
exit 0
