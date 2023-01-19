require 'google_carousel_scraper'

RSpec.describe GoogleCarouselScraper do
  before :all do 
    # instantiate instance of scraper class
    g = GoogleCarouselScraper.new './../files/van-gogh-paintings.html'
  end

  

end