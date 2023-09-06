module Google
  class CarouselItemParser
    def initialize(item_html:, images_by_id:)
      @item_html = item_html
      @images_by_id = images_by_id
    end

    def name
      item_html["aria-label"]
    end

    def extensions
      meta_content = item_html.at_css("div.klmeta")&.text

      if meta_content.nil?
        meta_content =
          item_html.xpath("./div/div/div[3]/div/div[2]/div").text
      end

      (meta_content.nil? || meta_content.empty?) ? nil : [meta_content]
    end

    def link
      "https://www.google.com#{item_html["href"]}"
    end

    def image
      img_node = item_html.css("img").first

      if img_node["id"].nil?
        img_node["data-src"]
      else
        images_by_id[img_node["id"]]
      end
    end

    def to_h
      h = {}
      h[:name] = name
      h[:extensions] = extensions unless extensions.nil?
      h[:link] = link
      h[:image] = image
      h
    end

    private

    attr_reader :item_html, :images_by_id
  end
end
