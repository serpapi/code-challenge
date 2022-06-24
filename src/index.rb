require 'nokogiri'
require_relative '../src/Carousel'

def main
    html_file = File.open('files/van-gogh-paintings.html');
    parsed_html = Nokogiri::HTML.parse(html_file);
    carousel = Carousel.new(parsed_html.at('g-scrolling-carousel'));
    puts carousel.artworks();
end

main();