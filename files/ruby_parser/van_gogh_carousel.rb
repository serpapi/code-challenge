require 'nokogiri'
require 'json'

HTMLS = {
  artworks: File.expand_path(File.join(__dir__, "../van-gogh-paintings.html")),
  cast: File.expand_path(File.join(__dir__, "../dune-actors.html")),
  albums: File.expand_path(File.join(__dir__, "../eminem-albums.html"))
}

class CarouselParser

  def self.get_carousel(filepath)

    html = File.read(filepath)
    doc = Nokogiri::HTML(html)

    carousel_name = doc.at_css("#kxbccs .kxbc, .F0gfrd+ .z4P7Tc")&.text
    data = { carousel_name => [] }

    # possibly could be implemented without if statements
    if doc.at_css(".MiPcId")

      artworks = doc.css(".MiPcId").map do |result|
        title = result.at_css(".klitem").attr("aria-label")
        link = "https://www.google.com#{result.at_css(".klitem").attr("href")}"
        extentions = result.at_css(".ellip.klmeta")&.text

        if result.at_css("img.rISBZc").attr("data-key")
          thumbnail = result.at_css("img.rISBZc").attr("data-key")
        elsif result.at_css("img.rISBZc").attr("data-src")
          thumbnail = result.at_css("img.rISBZc").attr("data-src")
        end

        data[carousel_name].push({
                                   title: title,
                                   link: link,
                                   extentions: [extentions],
                                   thumbnail: thumbnail
                                 })
      end
      # puts JSON.pretty_generate(data)
      return data

    elsif doc.at_css(".ct5Ked")
      all_script_tags = doc.css('script')

      # quick and dirty regex
      # flat_map for 2d -> 1d array
      matched_thumbnails = all_script_tags.to_s.scan(/<script nonce="\w+\D{1,2}?">\(\w+\(\){\w+\s?\w+='(.*?)';\w+\s?\w+=\['\w+'\];\w+\(\w+,\w+\);}\)\(\);<\/script>/).flat_map(&:itself)

      # there's possibly a better implementation of getting thumbnails and the rest of the data without using .zip()
      doc.css(".ct5Ked").zip(matched_thumbnails).map do |result, thumbnails|
        title = result.attr("aria-label")
        link = "https://www.google.com#{result.attr("href")}"
        extentions = result.at_css(".cp7THd .FozYP")&.text

        # for some reason it doesn't decode unicode chars.
        # in Python: bytes(thumbnail, 'ascii').decode('unicode-escape') works.
        # In Ruby, as far as I understand, encode("UTF-8") should work but here, it doesn't.

        # tested on replit.com with the same .encode() settings and and the same data:image URLs that present here and it works.
        thumbnail = thumbnails.encode!("UTF-8")

        data[carousel_name].push({
                                   title: title,
                                   link: link,
                                   extentions: [extentions],
                                   thumbnail: thumbnail
                                 })
      end
    end
    # puts JSON.pretty_generate(data)
    return data
  end
end
