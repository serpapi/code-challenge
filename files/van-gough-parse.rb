require 'nokogiri'

class GoogleCarouselParser
  def parse
    html_file = "van-gogh-paintings.html"

    html = File.open(html_file).read

    parsed_data = Nokogiri::HTML(html)

    images_thumbnails = html.scan(/var s='(data:image\/jpeg;base64,\S+)';/).map { |image| image[0] }

    art_works = parsed_data.css('.klitem').each_with_index.map do |art_work, index|
      name = art_work.at_css('.kltat').content ? art_work.at_css('.kltat').content : "" 

      extensions = art_work.at_css('.klmeta') ? [art_work.at_css('.klmeta').text] : nil

      link = "https://www.google.com#{art_work.attr('href')}"

      image = images_thumbnails[index] || nil

      {
        name: name,
        link: link,
        image: image,
        extensions: extensions
      }
    end

   result = {'artworks': art_works}
  end
 
 end

 gcp = GoogleCarouselParser.new
 parser = gcp.parse
 puts parser
