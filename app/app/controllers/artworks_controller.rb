require 'nokogiri'
class ArtworksController < ApplicationController

  def index
    html = File.open('/Users/dev/Desktop/code-challenge/files/van-gogh-paintings.html') { |f| Nokogiri::HTML(f) }
    container = html.at('div[jsname="s2gQvd"]').children
    artworks = []
    container.each do |element|
      name = element.at('a')['aria-label']
      link = "https://www.google.com" + element.at('a')['href']
      image = element.at('img')['src']
      extensions = [element.at('.ellip.klmeta')&.text]
      artworks.push (
        {
          name: name,
          extensions: extensions,
          link: link,
          image: image
        }
      )
    end

    data = JSON.pretty_generate( "artworks": artworks)
    render json: data
  end
end
