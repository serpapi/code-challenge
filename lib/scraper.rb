class Scraper

  attr_reader :parsed_file, :results

  def initialize(filepath)
    @parsed_file = Nokogiri::HTML(read_html(filepath))
    @results = []
  end

  def scrape
    @parsed_file.css("a.klitem").each do |item|
      result = {
        "image": item.css("img")[0]["src"],
        "link": "https://www.google.com" + item["href"]
      }
    
      result["name"] = ""
      item.css("span").each do |s|
        result["name"] += s.text
      end
      
      if item.css("div.ellip").any?
        result["extensions"] = [item.css("div.ellip")[0].text]
      end
    
      @results << result
    end
  end

  private

    def read_html(filepath)
      File.read(filepath)
    end

end