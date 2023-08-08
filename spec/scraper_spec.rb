require "spec_helper"
require "./lib/scraper"
require "date"

describe "Knowledge Graph for Claude Monet Paintings" do
  before :all do
    scraper = Scraper.new
    @response = JSON.parse(scraper.get_data)
  end

  before :each do
    @artwork = @response["artworks"].sample
  end

  it "return an 'artworks' key with an array value" do
    expect(@response["artworks"].is_a?(Array)).to be true
  end

  describe "artwork" do
    it "return array cells with 'name', 'extensions', 'link', and 'image' keys" do
      desired_keys = ["extensions", "image", "link", "name"]
      artwork_keys = @artwork.keys.sort
      expect(artwork_keys).to eql(desired_keys)
    end
  end

  it "return 'name' in string format" do
    name = @artwork["name"]
    expect(name).to be_a(String)
    expect(name).to_not be_empty
  end

  describe "extensions" do
    it "return an array of strings" do
      extensions = @artwork["extensions"]
      expect(extensions).to be_a(Array)
      expect(extensions.sample).to be_a(String)
    end

    it "return valid date string in year format, or an empty string" do
      date_string = @artwork["extensions"].first

      date_object = begin
        Date.strptime(date_string, "%Y")
      rescue Date::Error => e
      end

      if !date_object.nil?
        expect(date_object).to be_a(Date)
      else
        expect(date_string).to be_empty
      end
    end
  end

  describe "link" do
    it "return as a valid Google link" do
      link = @artwork["link"]
      expect(link).to be_a(String)
      expect(link.include?("https://www.google.com")).to be true
    end
  end

  describe "image" do
    it "return in valid JPEG format" do
      image = @artwork["image"]
      expect(image).to match(/data:image\/jpeg;base64/)
    end
  end
end
