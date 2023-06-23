require_relative 'carousel_scraper/scraper'
require_relative 'carousel_scraper/carousel_item_parser'
require_relative 'carousel_scraper/carousel_item'

module CarouselScraper
  class Main
    def self.run(html_path, filename, json_key)
      file = File.read(html_path)
      scraper = CarouselScraper::Scraper.new(file)
      carousel_data = scraper.parse_items

      carousel_data.each do |item|
        puts item.as_json
      end

      scraper.save_to_json_file(filename, json_key)
    end
  end
end

CarouselScraper::Main.run('files/van-gogh-paintings.html', 'files/van-gogh-output.json', 'artworks')
CarouselScraper::Main.run('files/neal-stephenson-books.html', 'files/neal-stephenson-output.json', 'books')
CarouselScraper::Main.run('files/christopher-nolan-films.html', 'files/christopher-nolan-output.json', 'films')
