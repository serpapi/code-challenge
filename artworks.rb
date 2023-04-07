require './lib/google_parser'

relative_file_path = 'files/van-gogh-paintings.html'
absolute_file_path = File.expand_path(relative_file_path)
url = 'file://' + absolute_file_path
puts GoogleParser.new(url).parse
