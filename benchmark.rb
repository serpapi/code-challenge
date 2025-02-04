require 'nokogiri'
require 'benchmark'
require_relative 'parser'

html = File.read("files/van-gogh-paintings.html")

# custom parser
average_time = 0
accumelated_time = 0
1000.times do
  execution_time = Benchmark.realtime do

      tokens = tokenize(html)
      doc = parse(tokens)
      scripts  = css(doc,"script")
      image_map = extract_inline_js_images_google(scripts)

      artworks = css(doc,'.iELo6').map do |node|
        img_node = css_first(node, 'img')
        img_src = img_node[:attributes]["src"]

        if img_src.nil? || img_src.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
          img_src = img_node[:attributes]["data-src"]
        end

        if img_src.nil? || img_src.empty?
          img_id = img_node[:attributes]["id"]
          img_src = image_map[img_id]
        end

        href =  css_first(node,'a')[:attributes]["href"]
        link = href.empty? ? "" : "https://www.google.com" + href
        extension = css_first(node,'div.cxzHyb')[:text]
        name = css_first(node,'div.pgNMRc')[:text]

        artwork = {
          "name" => name,
          "extensions" => extension.empty? ? nil : [extension],
          "link" => link,
          "image" => img_src,
        }.compact
      end
  end
  accumelated_time += execution_time
end
average_time = accumelated_time / 1000
puts "Average Execution time for van gogh: #{average_time*1000} ms"


# Nokogiri
average_time = 0
accumelated_time = 0
1000.times do
  execution_time = Benchmark.realtime do

    doc = Nokogiri::HTML(html)
    scripts = doc.css("script")
    image_map = extract_inline_js_images_google_nokogiri(scripts)

    artworks = doc.css('.iELo6').map do |node|
      img_node = node.at_css('img')
      img_src = img_node&.[]('src')

      if img_src.to_s.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
        img_src = img_node&.[]('data-src')
      end

      # Fallback to image map using ID
      if img_src.to_s.empty?
        img_id = img_node&.[]('id')
        img_src = image_map[img_id] if img_id
      end

      # Extract link
      link_node = node.at_css('a')
      href = link_node&.[]('href')
      link = href.empty? ? "" : "https://www.google.com" + href

      # Extract metadata
      extension = node.at_css('div.cxzHyb').text
      name = node.at_css('div.pgNMRc').text

      # Build artwork hash
      {
        "name" => name.empty? ? nil : name,
        "extensions" => extension.empty? ? nil : [extension],
        "link" => link.empty? ? nil : link,
        "image" => img_src.to_s.empty? ? nil : img_src
      }.compact
    end

  end
  accumelated_time += execution_time
end
average_time = accumelated_time / 1000
puts "Average Execution time for van gogh Using Nokogiri: #{average_time*1000} ms"
