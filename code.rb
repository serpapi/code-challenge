require "nokogiri"
require "json"

# from README.md
# Extract the painting `name`, `extensions` array (date), and Google `link`

class ArtParser

  def parse(path)

    result = []
    File.open(path, "r") do |file|
      file_content   = file.read()
      doc    = Nokogiri::HTML(file_content)
      image_id = 0

      # moved 'images' out of .each as they can be processed at once and be referred by
      # image_id (obtained data is already indexed by image_id and image_ids are 0...n )
      images = file_content.scan(/var s='(data:image\/jpeg;base64,\S+)';/)
      # puts(images.length)

      doc.css(".klitem").each do |painting|

        # id = painting.parent.css("g-img/img/@id")
        # puts (file_content.scan(/kximg0\S+var s='(data:image\/jpeg;base64,\S+)';/)

        # image name
        name = painting.at_css(".kltat").content or nil

        # extensions
        klmeta = painting.at_css(".klmeta")
        extensions = klmeta ? klmeta.text.split() : [nil]

        # Google link
        href = painting.attr("href") or nil
        link = "www.google.com#{href}"

        # image (indexed by image_id)
        image = images[image_id]

        out = {
          "name"         => name,
          "extensions"   => extensions,
          "link"         => link,
          "image"        => image ? image[0] : nil
        }

        result.append(out)
        image_id += 1

      end # doc each

      result = {"artworks" => result}
      # result = JSON[{"artworks" => result}]
      # puts(result)
      return result

    end #File

  end # method

end # class

# ArtParser.new.parse(path="./files/van-gogh-paintings.html")
# ArtParser.new.parse(path="./files/pablo-picasso-paintings.html")
# ArtParser.new.parse(path="./files/leonardo-da-vinci-paintings.html")

