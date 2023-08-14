require 'selenium-webdriver'
require './lib/scraper/super_parser'

module Scraper
  ITEM  = '#extabar g-scrolling-carousel .klitem'
  NAME  = '.kltat span'.freeze
  EXT   = '.klmeta'.freeze
  IMG   = '.klic'.freeze
end
