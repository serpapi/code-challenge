require 'nokogiri'

def extract_data_from_html(file_path)
  doc = Nokogiri::HTML(File.open(file_path), nil, Encoding::UTF_8.to_s)

  paintings_data = []

  # This is just a mock-up and might not directly work since we don't know the actual HTML structure.
  doc.css('g-scrolling-carousel div a').each do |painting|
    name = painting['aria-label']
    extensions =  painting.css('.klmeta').map(&:text).map(&:strip)
    link = 'https://www.google.com' + painting['href']
    imageNodes = painting.css('img')
    image = imageNodes.first['src'] if imageNodes.any?

    painting_data = {
        name: name,
        link: link,
        image: image
      }
      painting_data[:extensions] = extensions unless extensions.empty?
      
      paintings_data << painting_data
  end

  paintings_data = paintings_data.select { |painting| !painting[:name].nil? }

  {artworks: paintings_data}
end
