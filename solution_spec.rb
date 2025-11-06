require_relative 'solution.rb'
require 'rspec/autorun'


def has_correct_format
  it "has_string_names" do
    expect(@parsed_data.all?{|artwork| artwork[:name].is_a? String}).to be true
  end

  it "has_date_extensions" do
    expect(@parsed_data.all?{|artwork| !artwork.has_key?(:extensions) || (artwork[:extensions].size == 1 && artwork[:extensions][0].match?(/^\d+?$/))}).to be true
  end

  it "has_string_links" do
    expect(@parsed_data.all?{|artwork| artwork[:link].is_a? String}).to be true
  end

  it "has_string_images" do
    expect(@parsed_data.all?{|artwork| artwork[:image].is_a?(String) || (puts(artwork[:image].class))}).to be true
  end
end


describe "Parse Van Gogh Paintings" do

  before :all do
    @parsed_data = GoogleArtworkCarouselParsing.parse("files/van-gogh-paintings.html")
  end

  has_correct_format

  it "has_correct_almond_blossoms" do
    almond_blossoms_search = @parsed_data.select{|artwork| artwork[:name] == "Almond Blossoms"}
    expect(almond_blossoms_search.size).to eq 1
    almond_blossoms = almond_blossoms_search[0]
    expect(almond_blossoms[:extensions]).to eq ["1890"]
    expect(almond_blossoms[:link].start_with? "https://www.google.com/search?sca_esv=c2e426814f4d07e9&gl=us&hl=en&q=Almond+Blossoms").to be true
    expect(almond_blossoms[:image].start_with? "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTE").to be true
    expect(almond_blossoms[:image].end_with? "PUGVsUw6PMIMdD0my5cnwsQ9QOo43CsVVC5d1zlvU4qAFy5C5pwKLQdrAXLlmOoyCzP//Z").to be true

  end

end

describe "Maya Lin Sculptures" do

  before :all do
    @parsed_data = GoogleArtworkCarouselParsing.parse("files/maya-lin-sculptures.html")
  end

  has_correct_format

  it "has_correct_eclipsed_time" do
    eclipsed_time_search = @parsed_data.select{|artwork| artwork[:name] == "Eclipsed Time"}
    expect(eclipsed_time_search.size).to eq 1
    eclipsed_time = eclipsed_time_search[0]
    expect(eclipsed_time[:extensions]).to eq ["1995"]
    expect(eclipsed_time[:link].start_with? "https://www.google.com/search?sca_esv=a7a7f7107bf5a5bb&q=Eclipsed+Time").to be true
    expect(eclipsed_time[:image].start_with? "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhMSExMWFhU").to be true
    expect(eclipsed_time[:image].end_with? "iKmxpjUZauXIFItkbDYqbb6+9IuXIqyNzyh5piuXJZMeKP//Z").to be true

  end

end

describe "Norman Rockwell Illustrations" do

  before :all do
    @parsed_data = GoogleArtworkCarouselParsing.parse("files/norman-rockwell-illustrations.html")
  end

  has_correct_format


  it "has_correct_freedom_of_speech" do
    freedom_of_speech_search = @parsed_data.select{|artwork| artwork[:name] == "Freedom of Speech"}
    expect(freedom_of_speech_search.size).to eq 1
    freedom_of_speech = freedom_of_speech_search[0]
    expect(freedom_of_speech[:extensions]).to eq ["1943"]
    expect(freedom_of_speech[:link].start_with? "https://www.google.com/search?sca_esv=a7a7f7107bf5a5bb&q=Freedom+of+Speech").to be true
    expect(freedom_of_speech[:image].start_with? "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExIWFhUVGBYV").to be true
    expect(freedom_of_speech[:image].end_with? "v9p/gn/rWVlGgtjf7I/2n+Cf+tSJYYeJ9aysp6BsddU3ga11TeBrKyloGxvqm8DWG23ga1WUaBsaNpvsn4VNhEIOoNZWUaBsf/9k\\x3d").to be true

  end


end
