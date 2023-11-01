require "nokogiri"

class Parser
  BASE_URL = "https://www.google.com"

  def initialize(text)
    @text = text
    @document = Nokogiri::HTML(text)
  end

  def parse
    artworks = parse_artworks
    artworks.map do |artwork|
      {}.tap do |result|
        result["name"] = parse_name(artwork)

        year = parse_year(artwork)
        result["extensions"] = [year] if year

        result["link"] = parse_link(artwork)
        result["image"] = parse_image(artwork)
      end
    end
  end

  private
    def parse_artworks
      @document.css("g-scrolling-carousel .klitem-tr")
    end

    def parse_name(artwork)
      artwork.css(".klitem .kltat")[0].text
    end

    def parse_year(artwork)
      meta = artwork.css(".klmeta")[0]
      meta.text if meta
    end

    def parse_link(artwork)
      link = artwork.css(".klitem")[0]["href"]
      BASE_URL + link
    end

    def parse_image(artwork)
      image_id = artwork.css(".klitem g-img > img")[0]["id"]
      image_regexp = /var s='(data:image\/[^;]+;base64,\S+)';var ii=\['#{image_id}'\]/

      scripts_with_images.each do |script|
        if script =~ image_regexp
          return $1.gsub("\\", "")
        end
      end
      nil
    end

    def scripts_with_images
      @scripts_with_images ||=
        @document.css("script").map(&:inner_text).select { |script| script.include?("data:image") }
    end
end
