require './lib/google_parser'

module Artworks
  def self.run(path)
    url = 'file://' + path
    puts GoogleParser.new(url).parse
  end
end

if $0 == __FILE__
  relative_file_path = 'files/van-gogh-paintings.html'
  absolute_file_path = File.expand_path(relative_file_path)
  absolute_file_path = ARGV[0] if ARGV[0]
  Artworks.run(absolute_file_path)
end
