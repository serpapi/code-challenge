require 'rspec'
require_relative "./google_carousel"
require_relative "./carousel_item"

RSpec.describe "Google Carousel" do
  describe "van gogh test painting" do
    it "pulls back 51 items from the carousel" do
      expect(GoogleCarousel.get_carousel.length).to eq(51)
    end
    it "contains an image property for each item" do
      expect(GoogleCarousel.get_carousel.all? {|item| !item["image"].empty? }).to eq(true)
    end
    it "contains a link" do
      expect(GoogleCarousel.get_carousel.all? {|item| !item["link"].empty? }).to eq(true)
    end

    it "contains a name" do
      expect(GoogleCarousel.get_carousel.all? {|item| !item["name"].empty? }).to eq(true)
    end
  end
end

RSpec.describe "Carousel Item" do
  it "can retrieve name" do
    mock = double
    c = CarouselItem.new(mock)
    allow(mock).to receive_message_chain(:css, :text) { "test name" }
    expect(c.name).to eq("test name")
  end

  it "can retrieve link" do
    mock = double(:[] => "/test")
    c = CarouselItem.new(mock)
    expect(c.link).to eq("https://www.google.com/test")
  end

  it "can retrieve date" do
    mock = double
    c = CarouselItem.new(mock)
    allow(mock).to receive_message_chain(:css, :text) { "test date" }
    expect(c.name).to eq("test date")
  end

  describe "#image" do
    it "returns data-key" do
      mock = double
      second_mock = double()
      c = CarouselItem.new(mock)
      allow(mock).to receive_message_chain(:css, :[]) { second_mock }
      expect(second_mock).to receive(:[]).twice.with("data-key").and_return("test-key")
      expect(c.image).to eq("test-key")
    end

    it "returns data-src" do
      mock = double
      second_mock = double()
      c = CarouselItem.new(mock)
      allow(mock).to receive_message_chain(:css, :[]) { second_mock }
      expect(second_mock).to receive(:[]).once.with("data-key")
      expect(second_mock).to receive(:[]).twice.with("data-src").and_return("test-src")
      expect(c.image).to eq("test-src")
    end
  end
end