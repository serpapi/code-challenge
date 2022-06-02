require 'nokogiri'
require 'json'
require_relative 'MainLayoutExtractor'
require_relative 'NewLayoutExtractor'

class GoogleAppBarExtractor

  def predict_layout(html_dom)

    items = html_dom.css('.klitem-tr')
    if items.class == Nokogiri::XML::NodeSet
      if items[0].name == 'a'
        return 'new'
      end
    end

    'old'
  end

  def extract_cards(html)
    html_parser = Nokogiri::HTML
    if predict_layout(html_parser.parse(html)) == 'old'
      extractor = MainLayoutExtractor.new(html_parser)
    else
      extractor = NewLayoutExtractor.new(html_parser)
    end

    extractor.extract_cards(html)

  end
end