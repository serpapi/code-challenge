require 'nokogiri'
require 'pry'
require 'json'
require 'rspec'

BASE_URL = 'https://www.google.com'
FILE_PATH = './files/van-gogh-paintings.html'

raw_content = File.read(FILE_PATH)

doc = File.open(FILE_PATH) do
  |file| Nokogiri::HTML(file, nil, Encoding::UTF_8.to_s)
end

selector_klass = doc.css('g-scrolling-carousel a').first.parent['class'].split(' ').first
carousel_elements = doc.css(selector_klass.prepend('.'))

artworks = []
carousel_elements.each do |ele|
  entry = {}
  link = ele.css('a').first
  href = "#{BASE_URL}#{link['href']}"

  name = link['aria-label']
  year_match = link.css('div').last.inner_html
  year = year_match if year_match.to_i.to_s.size == year_match.size

  img_id = link.css('img').first['id']
  code_after_image = "';var ii=['#{img_id}'];_setImagesSrc(ii,s)"
  img_end_index = raw_content.index(code_after_image)

  unless img_end_index.nil?
    left_cut = raw_content.slice(0..img_end_index - 1)
    code_before_img_start = "function(){var s='"
    img_start_index = left_cut.rindex(code_before_img_start) + code_before_img_start.size
    img_base = left_cut.slice(img_start_index..img_end_index)
    img_base.tr!('\\', '')
  end

  entry[:name] = name
  entry[:extensions] = [year] unless year.nil?
  entry[:link] = href
  entry[:image] = img_base

  artworks << entry
end

result = { artworks: artworks }
expected_result = JSON.parse(File.read('./files/expected-array.json'), symbolize_names: true)

RSpec.describe 'Scraper' do
  expected_result[:artworks].each_with_index do |artwork, index|
    context "for artwork at index #{index}" do
      artwork.each_pair do |key, value|
        it "matches the #{key}" do
          expect(result[:artworks][index][key]).to eq(value)
        end
      end
    end
  end
end