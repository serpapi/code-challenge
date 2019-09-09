require 'rspec'
require 'active_support'
require 'active_support/core_ext'
require 'json'

require_relative 'carousel'

# TESTS
describe "Code Challenge" do

  describe "Extract Van Gogh Paintings" do
    browser = Browser.new(headless=false)
    browser.start_driver

    url = File.expand_path('files/van-gogh-paintings.html')
    # url = 'https://www.google.com/search?q=horror+movies&hl=en'
    artworks = get_carousel(browser, url)
    if artworks.empty?
      puts "No carousel found"
    else
      expected_array = {artworks: artworks}
      filename = 'carousel-array.json'
      File.write(filename, JSON.pretty_generate(expected_array))
      puts "Done! Saved #{expected_array[:artworks].length} carousel items to #{filename}"
    end

    context "when generic artworks array" do
      it "contains artworks array" do
        expect(expected_array).to be_an(Hash)
        expect(expected_array[:artworks]).to be_an(Array)
      end

      it "all carousel items have names" do
        expect(expected_array[:artworks].all? { |hash| (hash[:name].is_a? String) && hash[:name].present? }).to be true
      end

      it "all carousel items have links" do
        expect(expected_array[:artworks].all? { |hash| (hash[:link].is_a? String) && hash[:link].present? }).to be true
      end

      it "all carousel items have images" do
        expect(expected_array[:artworks].all? { |hash| (hash[:image].is_a? String) && hash[:image].present? }).to be true
      end

      it "at least 1 carousel item has extensions" do
        expect(expected_array[:artworks].any? { |hash| (hash[:extensions].is_a? Array) && hash[:extensions].present? }).to be true
      end
    end

    context "when van gogh artworks array", if: url =~ /van.?gogh.?paintings/i do
      if url =~ /van.?gogh.?paintings/i
        it "artworks array has 51 items" do
          expect(expected_array[:artworks].count).to eq 51
        end

        it "first artwork array item name is 'The Starry Night'" do
          expect(expected_array[:artworks][0][:name]).to eq 'The Starry Night'
        end

        # works with https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night...
        # and with   file:///C:/search?gl=us&hl=en&q=The+Starry+Night...
        it "first artwork array item link contains 'search?gl=us&hl=en&q=The+Starry+Night...'" do
          expect(expected_array[:artworks][0][:link]).to include('search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
        end

        it "first artwork array item image contains 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkG...'" do
          expect(expected_array[:artworks][0][:image]).to start_with('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkG')
        end
        it "first artwork array extensions is '[\"1889\"]'" do
          expect(expected_array[:artworks][0][:extensions]).to eq ["1889"]
        end
      end
    end
  end
end
