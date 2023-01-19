require 'google_carousel_scraper'
require 'nokogiri'

RSpec.describe GoogleCarouselScraper do
  before :all do 
    # instantiate instance of scraper class
    g = GoogleCarouselScraper.new './../files/van-gogh-paintings.html'

    # Example Item in Carousel
    doc = Nokogiri::HTML.parse('<div><a aria-label="The Starry Night" aria-posinset="1" aria-setsize="51" class="klitem" data-hveid="47" data-sp="0,17,26" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw" href="/search?Msyi0sTc" role="button" style="height:193px;width:120px" title="The Starry Night (1889)"><div class="klzc" style="margin-bottom:0"><div class="klic" style="height:120px;width:120px"><g-img class="BA0A6c" style="height:120px;width:120px"><img alt="" class="rISBZc M4dUYb" data-deferred="1" data-key="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0" height="120" id="kximg0" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" width="120"/></g-img></div></div><div><div class="kltat"><span>The Starry </span><wbr/><span>Night</span><wbr/></div><div class="ellip klmeta">1889</div></div></a></div>')

    # isolate <a> tag and parse using the parse_carousel_item() method
    carousel_item = doc.xpath("//a")[0]
    @parsed_item = g.parse_carousel_item(carousel_item).last
  end

  describe '#parse_carousel_item' do 
    context 'given an item from the Google carousel' do 
      
      it 'parses the title correctly' do
        expect(@parsed_item[:name]).to eq("The Starry Night")
      end

      it 'parses the href link correctly' do
        expect(@parsed_item[:link]).to eq("/search?Msyi0sTc")
      end

      it 'parses the image correctly' do
        expect(@parsed_item[:image]).to eq("data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
      end

      it 'parses the year correctly, when it exists' do
        expect(@parsed_item[:extensions]).to eq(["1889"])
      end
    end
  end
end