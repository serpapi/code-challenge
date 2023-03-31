require_relative '../lib/google_carousel_scraper'
require 'nokogiri'

RSpec.describe GoogleCarouselScraper do 
    before :all do 
        scraper = GoogleCarouselScraper.new("./files/van-gogh-paintings.html")
        @artworks = scraper.scrape_artworks[:artworks]
    end

    describe "artworks" do
        context 'name test' do
            it 'all artworks should have a name' do
                expect(@artworks.all? { |artwork| artwork[:name] }).to eq(true)
            end
            it "first one should be `The Starry Night`" do
                expect(@artworks[0][:name]).to eq("The Starry Night")
            end
            it "last one should be `Portrait of Adeline Ravoux`" do
                expect(@artworks.last[:name]).to eq("Portrait of Adeline Ravoux")
            end
        end
        context "extension test" do
            it 'some artworks should have an extension' do
                expect(@artworks.any? { |artwork| artwork[:extensions] }).to eq(true)
            end
            it 'number with extensions defined should be greater than 40' do
                extensions_defined = @artworks.select { |obj| obj.key?(:extensions) }
                expect(extensions_defined.length).to be > 40
            end
            it 'all extensions have exactly 4 characters' do
                extensions_defined = @artworks.select { |obj| obj.key?(:extensions) }
                valid_length = extensions_defined.all? {|obj| obj[:extensions][0].length == 4}
                expect(valid_length).to eq(true)
            end
        end
        context "link test" do
            it "all artworks should have a valid link" do
                expect(@artworks.all? { |artwork| artwork[:link] && artwork[:link] =~ /\Ahttps:\/\/www\.google\.com/ }).to eq(true)
            end

            it 'some links should contain the artwork name in them' do 
                expect(@artworks.any? { |artwork| 
                    artwork[:link].include?(artwork[:name].gsub(" ", "+")) 
                }).to eq(true)
            end
        end
        context "image test" do
            it "some artworks should have an image" do 
                expect(@artworks.any? { |artwork| artwork[:image]} ).to eq(true)
            end

            it "all artworks images are valid" do 
                artworks_with_images = @artworks.select { |artwork| !artwork[:image].nil? }
                expect(artworks_with_images.all? {|artwork| artwork[:image] =~ /\Adata:image\/jpeg;base64/ }).to eq(true)
            end
        end
    end
end