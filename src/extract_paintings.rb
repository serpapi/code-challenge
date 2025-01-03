require 'nokogiri'
require 'json'

def read_html_file(file_path)
  content = File.read(file_path, encoding: 'utf-8')
  content
end

def parse_html(html_content)
  Nokogiri::HTML(html_content)
end

def extract_paintings(doc)
    paintings = []
  
    base64_pattern = /data:image\/jpeg;base64,[^'"]+/
  
    doc.css('.iELo6').each do |item|
      title_element = item.at_css('.pgNMRc')
      link_element = item.at_css('a')
      date_element = item.at_css('.cxzHyb')
      thumbnail_element = item.at_css('img.taFZJe')
  
      title = title_element ? title_element.text.strip : nil
      link = link_element ? "https://www.google.com" + link_element['href'] : nil
      date = date_element ? date_element.text.strip : nil
      
      script_tags = doc.css('script')
  
      thumbnail = nil
      script_tags.each do |script_tag|
        if script_tag.text =~ base64_pattern
          match = base64_pattern.match(script_tag.text)
          thumbnail = match ? match.to_s : nil
          break
        end
      end
  
      unless thumbnail
        puts "No script tag found for item with title: #{title}"
      end
  
      if title && link
        painting_info = {
          'name' => title,
          'extensions' => date ? [date] : [],
          'link' => link,
          'image' => thumbnail
        }
        paintings << painting_info
      end
    end
  
    paintings
  end

def format_data(paintings)
  JSON.pretty_generate({ artworks: paintings })
end

def write_to_json_file(data, output_path)
  File.open(output_path, 'w', encoding: 'utf-8') do |file|
    file.write(data)
  end
end

def input_path(default = File.join(__dir__, '..', 'files', 'van-gogh-paintings.html'))
  print "Enter input path [#{default}]: "
  path = gets.chomp
  path.empty? ? default : path
end

def main
  begin
    input_path_value = input_path
    unless File.exist?(input_path_value)
      raise "File not found: #{input_path_value}"
    end

    output_path = File.join(__dir__, '..', 'files', 'extracted-paintings.json')

    html_content = read_html_file(input_path_value)
    doc = parse_html(html_content)
    paintings = extract_paintings(doc)
    formatted_data = format_data(paintings)
    write_to_json_file(formatted_data, output_path)

    puts "Extracted data written to #{output_path}"
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

if __FILE__ == $0
  main
end