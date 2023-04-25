require 'nokogiri'

class HtmlExtractor
    def initialize(html_path)
        @html_path = html_path
    end

    def get_image_attribute_from_div(div)
        if div.attributes.key?("href")
            data_src = div.children[0].children[0].children[1].children[0].children[0].attributes["src"]
        elsif div.children[0].attributes.key?("href") && div.children[0].children[0].children[0].children[1]
            if div.children[0].children[0].children[0].children[1].attributes.key?("src")
                data_src = div.children[0].children[0].children[0].children[1].attributes["src"]
            end
            if div.children[0].children[0].children[0].children[1].attributes.key?("src")
                data_src = div.children[0].children[0].children[0].children[1].attributes["src"]
            end
            if div.children[0].children[0].children[0].children[1].attributes.key?("data-src")
                data_src = div.children[0].children[0].children[0].children[1].attributes["data-src"]
            end
        else
            data_src = div.children[0].children[0].children[0].children[0].children[0].attributes["data-src"]
            data_key = div.children[0].children[0].children[0].children[0].children[0].attributes["data-key"]
        end
        return data_src ? data_src.value : data_key ? data_key.value : ""
    end

    def get_link_from_div(div)
        if div.attributes.key?("href")
            return "https://google.com" + div.attributes["href"].value
        elsif div.children[0].attributes.key?("href")
            return "https://google.com" + div.children[0].attributes["href"].value
        else
            return ""
        end        
    end
    
    def get_name_from_div(div)
        if div.children[0].attributes.key?("title")
            return div.children[0].attributes["title"].value
        elsif div.attributes.key?("title")
            return div.attributes["title"].value
        end                
    end

    def get_extensions_from_div(div)
        if div.attributes.key?("href")
            return [div.children[0].children[0].children[2].children[0].children[1].children[0].text]
        elsif div.children[0].attributes.key?("href") && div.children[0].children[1].children[0].children[0].children[1]
            return [div.children[0].children[1].children[0].children[0].children[1].text.strip]
        elsif div.children[0].children[1].children[1]
            return [div.children[0].children[1].children[1].children[0].text]
        else
            return []
        end
    end

    def extract_single_painting_information(carousel_div)
        link = get_link_from_div(carousel_div)
        name = get_name_from_div(carousel_div)
        if name
            image = get_image_attribute_from_div(carousel_div)
            extensions = get_extensions_from_div(carousel_div)            
            return {
                "name" => name,
                "extensions" => extensions,
                "link" => link,
                "image" => image
            }
    
        end
    end

    def get_photos_carousel_from_html()
        doc = Nokogiri::HTML(File.open(@html_path))
        return doc.css('g-scrolling-carousel')  
    end


    def extract_all_paintings_information
        photos_carousel = get_photos_carousel_from_html()
        all_results = []
        iterative_carousels = photos_carousel.children[0].children[0].children 
        if photos_carousel.children[0].children[0].children[0].children[0].children[0].attributes.key?("href")
            iterative_carousels = photos_carousel.children[0].children[0].children[0].children
        end
        for each_carousel in iterative_carousels do
            all_results.push(extract_single_painting_information(each_carousel))
        end
        return {
            "artworks" => all_results
        }   
    end

end
