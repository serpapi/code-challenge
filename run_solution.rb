require_relative 'solution'

puts "Testing parsing of 'files/van-gogh-paintings.html'..."

puts GoogleArtworkCarouselParsing.parse("files/van-gogh-paintings.html").to_s
