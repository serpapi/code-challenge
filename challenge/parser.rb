require 'uri'

module Challenge
  class Parser
    ITEM_CSS = 'a.klitem,a.klitem-tr'
    ITEM_META_CSS = '.klmeta'
    BASE_URL = 'https://www.google.com/'

    attr_reader :document, :image_scripts

    def initialize(document)
      @document = document
      set_image_scripts
    end

    def parse
      items = document.css(ITEM_CSS)
      items.map { |item| parse_item(item) }
    end

    private

    def set_image_scripts
      @image_scripts = document.css('script').select do |script|
        script.text.include?('setImagesSrc') && script.text.include?('data:image')
      end
    end

    def parse_item(item)
      name = item.attributes['aria-label']&.value
      href = item.attributes['href'].value
      link = URI.join(BASE_URL, href).to_s
      image_tag = item.at_css('img')
      image = image_extractor.extract(image_tag)
      extensions = get_extensions(item)

      result = { name:, link:, image: }
      result[:extensions] = extensions unless extensions.empty?
      result
    end

    def get_extensions(item)
      metadata = item.css(ITEM_META_CSS)
      return unless metadata

      metadata.map(&:text)
    end

    def image_extractor
      @image_extractor ||= ImageExtractor.new(image_scripts)
    end
  end

  class ImageExtractor
    REGEX_GROUP_NAME = 'data_uri'

    def initialize(scripts)
      @scripts = scripts
    end

    def extract(image_tag)
      @id = image_tag.attr('id')
      return unless @id

      search_image_in_script
      return unless @match

      image_data_uri = @match[REGEX_GROUP_NAME]
      image_data_uri.gsub('\\', '')
    end

    private

    def search_image_in_script
      @scripts.each do |script|
        @match = regex.match(script.text)
        break if @match
      end
    end

    def regex
      %r[(?<#{REGEX_GROUP_NAME}>data:image/.{3,4};base64,([a-z]|[A-Z]|[0-9]|\+|/|\\)*)';var..{1,2}=\[.#{@id}]
    end
  end
end
