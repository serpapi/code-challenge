# frozen_string_literal: true

require 'nokogiri'
require 'json'

class Extractor
  def initialize(html_path, json_path)
    @html_file = File.read(html_path)
    @json_file = File.read(json_path)
    @paintings = []
  end

  def call
    extract_from_html
    extract_from_json
    @paintings
  end

  private

  def extract_from_html
    doc = Nokogiri::HTML(@html_file)

    doc.css('#extabar g-scrolling-carousel div > div > div').each do |painting|
      content = painting.css('a div:nth-child(2) div')
      extensions = content[1] ? [content[1].text] : nil

      @paintings << build_painting(content.first.text, extensions, painting)
    end
  end

  def extract_from_json
    data = JSON.parse(@json_file)

    artworks = data.dig('knowledge_graph', 'artworks') || []
    artworks.each do |artwork|
      name = artwork['name']
      image = artwork['image'] || nil

      painting = @paintings.find { |p| p[:name].downcase == name.downcase }

      painting[:image] = image if painting
    end
  end

  def build_painting(name, extensions, painting)
    {
      name:,
      extensions:,
      link: "https://www.google.com#{painting.css('a').first['href']}",
      image: painting.css('g-img img').first['src']
    }.compact
  end

  def extract_painting_name(element)
    name = element.text.match(/(?:\*|)([^*]+)(?:\*|)/)&.[](1)&.strip
    name.gsub!(/^vincent van gogh\s+/i, '')
    name
  end

  def extract_google_link(element)
    link = element.at_css('a')
    link ? "https://www.google.com#{link['href']}" : nil
  end
end

### example ###

html_path = './files/van-gogh-paintings.html'
json_path = './files/van-gogh-paintings.json'

paintings = Extractor.new(html_path, json_path).call
result_json = JSON.pretty_generate(paintings)
result_path = "./files/result/#{Time.now.to_f}.json"

File.write(result_path, result_json)

puts
puts '### Success ###'
puts
puts "The result has been successfully saved in the file: '#{result_path}'"
puts
puts
