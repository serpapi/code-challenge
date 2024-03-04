class GoogleArtworkScraper

  attr_reader :filepath, :parsed_file, :format_version, :results

  VERSION_LOOKUP = {
    "v1" => {
      "item_div_class" => "MiPcId",
      "year_div_class" => "ellip"
    },
    "v2" => {
      "item_div_class" => "iELo6",
      "year_div_class" => "cxzHyb"
    }
  }

  def initialize(filepath)
    @filepath = filepath
    @parsed_file = Nokogiri::HTML(read_html(filepath))
    @format_version = set_version
    @results = {  
      "artworks" => []
    }
  end

  def scrape
    raise "Unable to scrape: Invalid page version" unless VERSION_LOOKUP.keys.include?(@format_version)

    @parsed_file.css("div.#{item_div_class}").each do |item|
      result = {
        "link" => "https://www.google.com" + item.css("a")[0]["href"]
      }

      result["image"] = get_image(item)

      result["name"] = get_name(item)
      
      if item.css("div.#{year_div_class}").any?
        result["extensions"] = [item.css("div.#{year_div_class}")[0].text]
      end

      @results["artworks"] << result
    end

    return @results
  end

  def scrape_to_file
    scrape

    json_results = JSON.pretty_generate(@results)

    filename = @filepath.split("/").last.gsub(".html","")
    
    directory = defined?(RSpec) ? "spec/temp" : "result_files"

    unless File.directory?(directory)
      Dir.mkdir(directory)
    end

    File.open("#{directory}/#{filename}.json", "w") do |file|
      file.write(json_results)
    end
  end

  private

    def read_html(filepath)
      File.read(filepath)
    end

    def set_version
      if @parsed_file.css("div.#{VERSION_LOOKUP["v1"]["item_div_class"]}").any?
        "v1"
      elsif @parsed_file.css("div.#{VERSION_LOOKUP["v2"]["item_div_class"]}").any?
        "v2"
      else
        raise "Format not recognized"
      end
    end

    def item_div_class
      VERSION_LOOKUP[@format_version]["item_div_class"]
    end

    def year_div_class
      VERSION_LOOKUP[@format_version]["year_div_class"]
    end

    def get_image(item)
      img_id = item.css("img")[0]["id"]
      script_tags = @parsed_file.css('script')
      regex = /var s=\s*(.*?)\s*var ii=\['#{img_id}'\]/
      img_src_script_tag = nil

      script_tags.each do |script_tag|
        if script_tag.content.match(regex)
          img_src_script_tag = script_tag
          break
        end
      end

      if img_src_script_tag.nil?
        return nil
      else
        match = img_src_script_tag.content.match(regex)
        image = match.to_s.split("'")[-4]
        return image.gsub("\\","")
      end
    end

    def get_name(item)
      if @format_version == "v1"
        name = ""
        item.css("span").each do |s|
          name += s.text
        end
      elsif @format_version == "v2"
        name = item.css("div.pgNMRc").text
      end

      return name
    end
end