require 'rspec'
require 'nokogiri'
require 'json'
require 'base64'

RSpec.describe "Image Extractor" do
  let(:file_path) { './files/van-gogh-paintings.html' }
  let(:json_file_path) { './img-extractor-output.json' }  
  let(:html_content) { File.read(file_path) }
  let(:json_content) { File.read(json_file_path) }
  let(:parsed_html) { Nokogiri::HTML(html_content) }
  let(:carousel) { parsed_html.at_css('g-scrolling-carousel') }

  describe "File Handling and Parsing" do
    it "reads the HTML file successfully" do
      expect(File).to exist(file_path)
      expect(html_content).not_to be_empty
    end

    it "parses HTML content with Nokogiri" do
      expect(parsed_html).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe "Data Extraction" do
    it "has scrolling carousel" do
      expect(carousel).not_to be_nil
    end
  end

  describe "JSON Output" do
    it "JSON file has been generated and has content" do
      expect(File).to exist(json_file_path)
      expect(json_content["artworks"].size).to be > 1
      expect(json_content).not_to be_empty
    end 
  end

end
