require 'nokogiri'
require 'json'

class ArtworkExtractor
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def process
    html = File.read(file_name)
    doc = Nokogiri::HTML(html)

    img_dict = extract_base64_image_data(doc)
    extract_artworks(doc, img_dict)

    # UNCOMMENT THIS
    # To print the answer in a pretty JSON format
    # artworks = extract_artworks(doc, img_dict)
    # puts JSON.pretty_generate('artworks' => artworks)
  end

  private
  
  def extract_base64_image_data(document)
    img_dict = {}

    document.css('script').each do |script|
      script_code = script.inner_html

      next unless script_code.include?("_setImagesSrc")

      func_blocks = script_code.split(/\}\)\(\);\s*(?=\()/).reject(&:empty?)

      func_blocks.each do |block|
        next unless block.include?("_setImagesSrc")

        s_match = block.match(/var\s*s\s*=\s*'([^']*)'/)
        ii_match = block.match(/var\s*ii\s*=\s*\['([^']*)'\]/)

        next unless s_match && ii_match

        s = s_match[1]
        ii = ii_match[1]

        img_dict[ii] = s
      end
    end

    img_dict
  end

  def extract_artworks(document, img_dict)
    artworks = []
    carousel = document.at_css('g-scrolling-carousel')

    carousel.css('div.MiPcId').each do |node|
      artwork = {}

      name_div = node.at_css('div.kltat')
      meta_div = node.at_css('div.ellip.klmeta')
      link_node = node.at_css('a.klitem')
      img_node = node.at_css('img')

      artwork['name'] = name_div.text.strip if name_div
      artwork['extensions'] = [meta_div.text.strip] if meta_div
      artwork['link'] = "https://www.google.com#{link_node['href']}" if link_node

      img_id = img_node['id'] if img_node
      artwork['image'] = img_dict[img_id] if img_id

      artworks << artwork
    end

    artworks
  end
end

extractor = ArtworkExtractor.new('./files/van-gogh-paintings.html')
extractor.process