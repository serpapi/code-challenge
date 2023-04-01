require_relative '../lib/google_carousel_scraper'
require 'nokogiri'

RSpec.describe GoogleCarouselScraper do 
    before :all do 
        scraper = GoogleCarouselScraper.new("./files/portrait-of-marie-therese.html")
        @artworks = scraper.scrape_artworks[:artworks]
    end

    describe "artworks" do
        context 'name test' do
            it 'all artworks should have a name' do
                expect(@artworks.all? { |artwork| artwork[:name] }).to eq(true)
            end
            it "first one should be `Guernica`" do
                expect(@artworks[0][:name]).to eq("Guernica")
            end
            it "last one should be `Woman with book`" do
                expect(@artworks.last[:name]).to eq("Woman with book")
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
                expect(artworks_with_images.all? {|artwork| artwork[:image] =~ /\A(data:image\/jpeg|data:image\/gif);base64/ }).to eq(true)
            end
        end
    end
end