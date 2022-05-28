require_relative "GoogleAppBarExtractor"

html = File.read(__dir__ + "/files/van-gogh-paintings.html")

extractor = GoogleAppBarExtractor.new

puts extractor.extractCards(html)