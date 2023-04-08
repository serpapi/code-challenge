require "nokogiri"
require "uri"
require "httparty"
require "base64"
require "json"
require "pry"

class ArtworkScraper
  def fetch_google_results(query)
    base_url = "https://www.google.com/search?q="
    search_url =
      base_url + URI.encode_www_form_component(query) +
        "&oq=#{URI.encode_www_form_component(query)}"

    headers = {
      "User-Agent" =>
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.3"
    }

    response = HTTParty.get(search_url, headers: headers)
    Nokogiri.HTML5(response.body)
  end

  def find_script_elements_with_set_image_srcs(doc)
    script_elements = doc.css("script")
    script_elements.collect.with_index do |s, i|
      i if s.text.include? "_setImagesSrc"
    end
  end

  def build_image_id_to_data_image_src_map(doc)
    mx = []
    script_elements = doc.css("script")
    relevant_script_indices =
      find_script_elements_with_set_image_srcs(doc).compact!
    relevant_script_indices.each do |i|
      script_element = script_elements[i]
      script_text = script_element.children[0].text
      hilarious =
        script_text
          .split("'")
          .collect
          .with_index do |s, i|
            s if i % 2 == 1
          end # only want odds, given structure
          .compact
          .each_slice(2)
          .collect { |x| [x[1], x[0]] } # flip it, map image id to corrected link
      mx << Hash[hilarious]
    end

    # Hash[hilarious] # this was annoying
    mx = mx.reduce { |acc, h| (acc || {}).merge h }
    mx.reject { |k, v| v.length <= 50 }
  end

  def extract_artwork_data_from_file(doc)
    artwork_data = []
    xpath = '//*[@id="kx"]/div[2]/div[2]/div/div'
    blob = doc.xpath(xpath)
    data_image_map = build_image_id_to_data_image_src_map(doc)
    children = blob[0].children[0].children[0].children[0].children

    children.each do |child|
      data = {}
      if child.children && child.children.length >= 1
        a = child.children[0]

        if a
          img = a.children[0]
          id = img.children[0].children[0].children[0].attr("id")
          if a.children[1] && a.children[1].children[1]
            @year = a.children[1].children[1].text
          end

          data["name"] = a.attr("aria-label")
          data["extensions"] = [@year] if @year.length != 0
          data["link"] = "https://www.google.com" + a.attr("href")
          data["image"] = data_image_map[id]
        end

        artwork_data << data

        # ----- Single child looks like this -------
        #
        # so if child == below, then child.children[0] would be the a href.
        #
        # <div class="iELo6" style="width: 153px; top: 8px; left: 8px; height: 167.429px;" jsdata="JI96Wc;unsupported;BBdLQg">
        #   <a href="/search?newwindow=1&amp;sxsrf=APwXEde-enqmcHJbZ-Wccv4s-yye6hWlTg:1680891772681&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&amp;sa=X&amp;ved=2ahUKEwi3vJDosZj-AhW4lGoFHYKuDfoQtq8DegQIFhAD">
        #     <img class="taFZJe" alt="The Starry Night" id="_fF8wZLeOKbipqtsPgt220A8_255" src="data:image/jpeg;base64,/9j/PLACEHOLDER" data-atf="1" data-frt="0">
        #     <div class="KHK6lb">
        #       <div class="pgNMRc">The Starry Night</div>
        #       <div class="cxzHyb">1889</div>
        #     </div>
        #   </a>
        # </div>
      end
    end
    { artworks: artwork_data }
  end

  def extract_artwork_data(doc)
    artwork_data = []
    xpath = '//*[@id="kp-wp-tab-ArtistToArtworks"]/div[1]/div/div/div[2]/div'
    blob = doc.xpath(xpath)
    data_image_map = build_image_id_to_data_image_src_map(doc)
    if blob && blob.length >= 1
      children = blob[0].children[0].children[1].children

      children.each do |child|
        data = {}
        a = child.children[0]
        if a
          img = a.children[0]
          id = img.attr("id")
          year = a.children[1].children[1].text
          data["name"] = a.children[0].attr("alt")
          data["extensions"] = [year] if year.length != 0
          data["link"] = "https://www.google.com" + a.attr("href")
          data["image"] = data_image_map[id]
        end
        artwork_data << data

        # ----- Single child looks like this -------
        # so if child == below, then child.children[0] would be the a href.
        # <div class="iELo6" style="width: 153px; top: 8px; left: 8px; height: 167.429px;" jsdata="JI96Wc;unsupported;BBdLQg">
        #   <a href="/search?newwindow=1&amp;sxsrf=APwXEde-enqmcHJbZ-Wccv4s-yye6hWlTg:1680891772681&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&amp;sa=X&amp;ved=2ahUKEwi3vJDosZj-AhW4lGoFHYKuDfoQtq8DegQIFhAD">
        #     <img class="taFZJe" alt="The Starry Night" id="_fF8wZLeOKbipqtsPgt220A8_255" src="data:image/jpeg;base64,/9j/PLACEHOLDER" data-atf="1" data-frt="0">
        #     <div class="KHK6lb">
        #       <div class="pgNMRc">The Starry Night</div>
        #       <div class="cxzHyb">1889</div>
        #     </div>
        #   </a>
        # </div>
      end
      { artworks: artwork_data }
    end
  end

  def download_images_and_save_json(artwork_data, artist_name)
    dir = "#{artist_name.gsub(" ", "_")}_artworks"
    Dir.mkdir(dir) unless File.exist?(dir)

    File.open("#{dir}/artworks.json", "w") do |f|
      f.write(JSON.pretty_generate(artwork_data))
    end
  end

  def run(argv)
    if ARGV[0] and ARGV[0].start_with? "--live"
      artist_name = ARGV[1..ARGV.length].join(" ") || "Van_Gogh"
      puts "Fetching Google image search results for #{artist_name} artwork..."
      doc = fetch_google_results("#{artist_name} artwork")
      artwork_data = extract_artwork_data(doc)
      download_images_and_save_json(artwork_data, artist_name)
    elsif ARGV[0] and ARGV[0].start_with?("--file")
      artist_name = "Van Gogh"
      file_location = ARGV[0].split("=")[1] || "files/van-gogh-paintings.html"
      puts "Reading file from this location: #{file_location}"
      f = File.read(file_location)
      doc = Nokogiri.HTML5(f)
      artwork_data = extract_artwork_data_from_file(doc)
      download_images_and_save_json(artwork_data, artist_name)
    else
      puts "Incorrect usage! Correct usages shown below!..."
      puts "Usage: ruby cli.rb --file"
      puts "Usage: ruby cli.rb --file=dir/some_file_location - this can be left blank as shown above, as it defaults to files/van-gogh-paintings.html"
      puts "Usage: ruby cli.rb --live <ARTIST_NAME> to directly hit the web and scrape it programmatically! (EXTRA CREDIT)"
    end
  end
end
