require "httparty"
require "nokogiri"
require 'json'
require 'base64'

def read_html_file(file_path)
  File.read(file_path)
rescue Errno::ENOENT => e
  puts "Error: File not found - #{e.message}"
  exit
rescue IOError => e
  puts "Error: Unable to read file - #{e.message}"
  exit
end

def parse_html(content)
  Nokogiri::HTML(content)
rescue Nokogiri::SyntaxError => e
  puts "Error: Failed to parse HTML - #{e.message}"
  exit
end

def extract_thumbnail(script_tags, image_id)
  script_tags.each do |script|
    match = /var\s+s\s*=\s*'([^']+)';\s*var\s+ii\s*=\s*\[\s*'#{image_id}'\s*\];/.match(script.content)
    return Base64.strict_encode64(Base64.decode64(match[1])) if match
  end
  nil
rescue ArgumentError => e
  puts "Error: Failed to decode base64 string - #{e.message}"
  nil
end

def process_carousel(img_carousel, script_tags)
  artworks = []
  img_carousel.css('a').each do |ele|
    title = ele['aria-label'] ? ele['aria-label'] : next
    extensions = ele.css('.ellip.klmeta').map { |element| element.text }
    image_url = "https://www.google.com#{ele['href']}"
    image = ele.at_css('img')
    next unless image
    image_id = image['id']
    thumbnail = extract_thumbnail(script_tags, image_id)
    
    artwork_data = {
      name: title,
      extensions: extensions,
      link: image_url,
      image: thumbnail
    }
    artworks << artwork_data
  end
  artworks
end

def write_to_json(file_path, data)
  formatted_json = JSON.pretty_generate(data)
  File.write(file_path, formatted_json)
  puts "Images extracted to #{file_path}!"
end

begin
  # Main execution flow
  file_path = './files/van-gogh-paintings.html'
  html_content = read_html_file(file_path)
  parsed_html = parse_html(html_content)
  img_carousel = parsed_html.css('g-scrolling-carousel')
  script_tags = parsed_html.css('script')
  
  artworks = process_carousel(img_carousel, script_tags)
  json_data = { artworks: artworks }
  
  output_file_path = './img-extractor-output.json'
  write_to_json(output_file_path, json_data)
rescue => e
  puts "An error occurred: #{e.message}"
end
