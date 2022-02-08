require 'nokogiri'

class ArtCrawler
    def initialize(data)
        @data = data
        @html = Nokogiri::HTML.parse(@data)
    end

    def getImageData(imgid)
        imgdata = @data.scan(/var s=\'([^']+)\'\;var ii\=\['#{ imgid }'\];/).first&.first
        return imgdata&.gsub "\\x3d", '='
    end

    def processTag(tag)
        link = tag.css('.klitem')
        if link.attr('aria-label')
            name = link.attr('aria-label')&.to_str
            href = link.attr('href')&.to_str
        else
            # Some changes as occured in the carousel structure between the van-gogh sample and the actual google page.
            # So in order to be able to test it on "2 more pages" I have to test version. And presence or not of the attribute 'aria-label' on element .klitem is one of the difference between the two versions.
            name = tag.attr('aria-label')&.to_str
            href = tag.attr('href')&.to_str
        end

        imgid = tag.css('img').first&.attr('id')
        date = tag.css('.klmeta').first&.content&.to_s
        image = getImageData(imgid)

        return {
            **(date ? {"extensions" => [ date ]}: {}),
            "image" => image,
            "link" => "https://www.google.com#{href}",
            "name" => name
        }
    end

    def run()
        results = []
        @html.css(".klitem-tr").each do |tag|
            results.push(processTag(tag))
        end
        return results
    end
end
