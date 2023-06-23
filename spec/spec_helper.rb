$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
Dir[File.dirname(__FILE__) + '/shared_examples/*.rb'].each { |file| require file }
require 'carousel_scraper/scraper'
require 'carousel_scraper/carousel_item'
require 'carousel_scraper/carousel_item_parser'
