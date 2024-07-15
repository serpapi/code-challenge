# frozen_string_literal: true

require 'nokolexbor'
require_relative 'web_page_loader'

class PaintingsExtractor
  ITEM_SELECTOR = 'a.klitem'
  private_constant :ITEM_SELECTOR

  def initialize(file_path)
    @file_path = file_path
    @web_page_loader = WebPageLoader.new(file_path, ITEM_SELECTOR)
  end

  def extract_paintings
    paintings = []

    @web_page_loader.with_html_loaded do
      html_doc.css(ITEM_SELECTOR).each do |painting|
        extensions = extract_extensions(painting)

        paintings << {}.tap do |h|
          h['name'] = painting.attribute('aria-label').to_s
          h['extensions'] = [extensions] unless extensions.nil? || extensions.empty?
          h['link'] = extract_google_href(painting)
          h['image'] = extract_image_data(painting)&.to_s
        end
      end
    end

    { 'artworks' => paintings }
  end

  private

  def html_doc
    @html_doc ||= Nokolexbor::HTML(@web_page_loader.html)
  end

  def extract_image_data(painting)
    image_element = painting.css('img')
    image_id = image_element.attr('id')&.value

    image_data_map[image_id]
  end

  def extract_google_href(painting)
    slug = painting.attribute('href')
    return nil if slug.nil?

    "https://www.google.com#{slug}"
  end

  def extract_extensions(painting)
    painting.css('div.klmeta').text.strip
  end

  def image_data_map
    @image_data_map ||= begin
      scripts = html_doc.css('script')

      scripts.each_with_object({}) do |script, map|
        script.text.scan(/var\s*s\s*=\s*'([^']*)'.*?var\s*ii\s*=\s*\['([^']*)'\]/m) do |s, ii|
          map[ii] = s.gsub('\\', '')
        end
      end
    end
  end
end
