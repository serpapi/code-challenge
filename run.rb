require './lib/image_carrousel_scrapper'
require './lib/image_carrousel_scrapper/drivers/nokogiri_driver'

i = ImageCarrouselScrapper.new(driver: ImageCarrouselScrapper::Drivers::NokogiriDriver,
                               file: File.open('./spec/fixtures/van-gogh-paintings.html'))
i.result(format: :raw)
