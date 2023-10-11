require 'nokogiri'
require 'json'

def parse_carousel(fn)
    html = File.read(fn)

    doc = Nokogiri::HTML(html, nil, 'utf-8')

    first_item = true
    prev_item = nil
    search_data = doc.xpath("//a[@class='klitem']").map do |item|
        name = item.attribute('aria-label').value
        link = "https://www.google.com#{item.attribute('href').value}"
        image_id = item.xpath(".//g-img/img").first.attribute('id').value

        if first_item
            script_regex = /\(function\(\)\{var s='(.*?)';var ii=\['#{image_id}'\];/
            first_item = false
        else
            script_regex = /var ii=\['#{prev_item}'\];_setImagesSrc\(ii,s\);\}\)\(\);\(function\(\)\{var s='(.*?)';var ii=\['#{image_id}'\];/
        end
        prev_item = image_id

        image = script_regex.match(html)&.[](1)&.gsub('\\', '')

        extensions = item.xpath(".//div[@class='ellip klmeta']").map { |i| i.children.map(&:text) }.flatten

        if !extensions.empty?
            next {
                name: name,
                extensions: extensions,
                link: link,
                image: image
            }
        end

        {
            name: name,
            link: link,
            image: image
        }
    end

    {
        artworks: search_data
    }
end