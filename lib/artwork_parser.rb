def parse_artworks(artworks)
    artworks_result = artworks.map do |artwork|
      artwork_obj = {}
      name = artwork.at_xpath('.//span/..')&.text
      artwork_obj[:name] = name
      
      extensions = artwork.xpath('.//div[not(@class)]/div[2]')
      extensions_arr = extensions.map(&:text).compact
      artwork_obj[:extensions] = extensions_arr if extensions_arr.length > 0
      
      link = artwork.at_xpath('.//a')&.[]('href')
      artwork_obj[:link] = "https://www.google.com#{link}" if link
      
      image = artwork.at_xpath('.//img')&.[]('src')
      artwork_obj[:image] = image
      
      artwork_obj
    end
    { artworks: artworks_result }
end