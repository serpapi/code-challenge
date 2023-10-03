require "./carousel_extractor.rb"

puts CarouselExtractor.carousels_from_file('./files/van-gogh-paintings.html')
puts CarouselExtractor.carousels_from_file('./files/keanu-reeves.html')
puts CarouselExtractor.carousels_from_file('./files/conifers.html')

