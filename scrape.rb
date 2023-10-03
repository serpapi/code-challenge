require './carousel_extractor'

puts CarouselExtractor.carousels_from_file('./files/van-gogh-paintings.html')
puts CarouselExtractor.carousels_from_file('./files/keanu-reeves.html')
puts CarouselExtractor.carousels_from_file('./files/conifers.html')
