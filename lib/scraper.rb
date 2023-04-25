require 'nokogiri'
require 'open-uri'
require 'json'
require 'awesome_print'
require_relative 'painting'
require_relative 'parser'

class Scraper

  def initialize(file_name = "files/van-gogh-paintings.html")
    file = File.read(file_name)
    @file_name = file_name.split('/').last.sub('.html', '')
    @doc = Nokogiri::HTML(file) do |config|
      config.options |= Nokogiri::XML::ParseOptions::HUGE
    end
  end

  def scrape
    raise StandardError.new('Google carousel is not present on the page!') if carousel.empty?
    artworks = []
    carousel.css('a').each do |painting_wrapper|
      parser = Parser.new(painting_wrapper)


      next unless parser.painting_exists?

      artworks << Painting.new(
        image: parser.image,
        name: parser.name,
        link: parser.link,
        extensions: parser.extensions
      ).to_json
    end

    File.open("files/#{@file_name}-parsed.json","w") do |f|
      f.write({ artworks: artworks }.to_json)
    end

    { artworks: artworks }
  end

  def carousel
    @doc.css('g-scrolling-carousel')
  end
end
