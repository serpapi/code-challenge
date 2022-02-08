require 'nokogiri'
require 'byebug'
require 'json'

class Scraper

  def parse_HTML(filepath)

    html = File.read(filepath)
    doc = Nokogiri::HTML(html)

    data = []

    if doc.at_css(".MiPcId")

      doc.css(".MiPcId").map do |result|
        name = result.at_css(".klitem").attr("aria-label")
        link = "https://www.google.com#{result.at_css(".klitem").attr("href")}"
        extentions = result.at_css(".ellip.klmeta")&.text
        image = result.at_css("img.rISBZc").attr("src")

        data << {
          name: name,
          extentions: [extentions],
          link: link,
          image: image
      }
      end
      puts JSON.pretty_generate(data)
      return data

    elsif doc.at_css(".ct5Ked")
      
      doc.css(".ct5Ked").map do |result|
        name = result.attr("aria-label")
        link = "https://www.google.com#{result.attr("href")}"
        extentions = result.at_css(".cp7THd .FozYP")&.text
        
        if(result.at_css("img.rISBZc"))
          image = result.at_css("img.rISBZc").attr("src")
        end

        data << {
          name: name,
          extentions: [extentions],
          link: link,
          image: image
      }
      end
    end
    puts JSON.pretty_generate(data)
    return data
  end
end

def get_file_path(filename)
  File.expand_path(File.join(File.dirname(__FILE__) , filename))
end

artworks = get_file_path("/files/van-gogh-paintings.html")
books = get_file_path("/files/shakespeare-books.html")
buildings = get_file_path("/files/tallest-building.html")

scraper = Scraper.new

scraper.parse_HTML(artworks)