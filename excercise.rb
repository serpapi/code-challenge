# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].sort.each { |file| require file }

def retrieve_paintings
  file = File.open('./files/van-gogh-paintings.html')
  search = PageSearch.new(file, 'div.EDblX.DAVP1 div.MiPcId.klitem-tr.mlo-c a').search
  extractor = Google::CarouselExtractor

  print Scrap.new(search, extractor).process
end

retrieve_paintings
