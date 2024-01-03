class CarouselItem
  def initialize(node)
    @node = node
  end

  def name
    @node.css(".kltat").text
  end
  
  def link
    "https://www.google.com#{@node["href"]}"
  end

  def date
    @date ||= @node.css(".klmeta").text
  end

  def image
    img = @node.css("img")[0]
    if (img["data-key"])
      return img["data-key"]
    end
    if img["data-src"]
      return img["data-src"]
    end
  end

  def to_json
    object = {
      "name": self.name,
      "link": self.link,
      "image": self.image
    }
    if !self.date.empty?
      object["extensions"] = [self.date]
    end
    object.to_json
  end
end