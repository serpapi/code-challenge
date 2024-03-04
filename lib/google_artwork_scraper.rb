class GoogleArtworkScraper

  attr_reader :parsed_file, :results

  def initialize(filepath)
    @parsed_file = Nokogiri::HTML(read_html(filepath))
    @results = {  
      "artworks" => []
    }
  end

  def scrape
    @parsed_file.css("a.klitem").each_with_index do |item,index|
      result = {
        "link" => "https://www.google.com" + item["href"]
      }

      img_id = item.css("img")[0]["id"]
      result["image"] = get_image(img_id)
    
      result["name"] = ""
      item.css("span").each do |s|
        result["name"] += s.text
      end
      
      if item.css("div.ellip").any?
        result["extensions"] = [item.css("div.ellip")[0].text]
      end

      @results["artworks"] << result
    end
    @results
  end

  private

    def read_html(filepath)
      File.read(filepath)
    end

    def get_image(img_id)
      script_tags = @parsed_file.css('script')
      img_src_script_tag = script_tags[-5]

      regex = /var s=\s*(.*?)\s*var ii=\['#{img_id}'\]/
      match = img_src_script_tag.content.match(regex)
      image = match.to_s.split("'")[-4]

      if image.nil?
        return nil
      else
        return image.gsub("\\","")
      end
    end
end