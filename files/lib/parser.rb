require 'nokogiri'
require 'json'

class Parser
    def initialize(document)
        @doc = File.open(document) { |f| Nokogiri::HTML(f) }
        @carousel_type = "" # ex. Artworks, Albums, etc.
        @carousel_results = Hash.new
    end

    def get_carousel_results
        return @carousel_results
    end

    def get_carousel_type
        return @carousel_type
    end

    def extract_name(node)
        return node.xpath(".//div[1]/text()").text
    end

    def extract_extensions(node)
        return node.xpath(".//div[position()!=1]/text()").to_a.map{ |ext| ext.text }
    end

    def extract_link(node)
        url = node.xpath("@href").text
        return url.start_with?("https://") ? url : "https://www.google.com#{url}"
    end

    def extract_image(node)
        image_id = node.xpath(".//img/@id").text
        if image_id.size != 0
            script_tag = @doc.xpath("//script[contains(text(), '#{image_id}')]").text
            # replace hex with chars
            image = script_tag.match(/(data:image[^'"]*?)('|");/)[1].gsub(/\\x\h{2}/) { |m| m[2, 2].hex.chr }
        else
            image = @doc.xpath(".//img/@data-src").text
        end
        return image
    end

    def extract_carousel
        results_arr = []
        nodes = @doc.xpath("//a[contains(@href, '/search?')][not(@role)][descendant::img]")
        @carousel_type = @doc.xpath("//span[@data-ti][@tabindex=0]/descendant::span/text()").to_s()

        nodes.each do |node|
            name = extract_name(node)
            extensions = extract_extensions(node)
            link = extract_link(node)
            image = extract_image(node)

            result = {
                "name": name,
                "extensions": (extensions if extensions.size != 0),
                "link": link,
                "image": image
            }.compact # exclude key if nil
            
            results_arr.push(result)
        end

        @carousel_results = {"#{@carousel_type}": results_arr}
        return
    end

    def write_json(out_file)
        json = JSON.pretty_generate(@carousel_results)

        File.open(out_file, 'w') do |f|
            f.write(json)
        end
    end
end