# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/object/deep_dup'
require 'hash_remapper'
require 'nokogiri'
require 'oj'
require 'sanitize'

Oj.default_options = { mode: :strict, symbol_keys: true }

require_relative './html_scraper'

module SERP
  ##
  # SerpCrawler Class
  # Crawls HTML Doc-ish object with the stencil provided
  # and forms the final Hash
  #
  # WARNING: Pretty old class whitha a few features retrofited purely for the
  #          of this task (without any tesing or desing consideration, to save time)
  class Crawler
    def initialize(html_doc:, stencil:)
      @html_scraper = HtmlScraper.new
      @html_doc = html_doc
      @stencil = stencil
    end

    def crawl(&data_builder)
      @html_scraper.parse(html: @html_doc, stencils: @stencil, &data_builder)
    end
  end
end

# This is how I prefer to write and test while developing independent, pure, old-good Ruby classes
# Also creating/debugging stencils is much more conviniet through here than through the CLI serpcrawler
#
# bundle exec ruby ./lib/serp_crawler.rb
if $PROGRAM_NAME == __FILE__
  # https://gist.github.com/smileart/1b9217389904580316780e7c2a0d466a – my replacepent of letters#o from letters gem
  require_relative './utils/tapp_amazing_print'
  require 'testrocket'

  require_relative './json_generator'
  require_relative '../stencils/google_film_characters_carousel'

  html_filepath = File.expand_path('./files/the-big-lebowski-characters.html', Dir.pwd)
  html_text = File.read(html_filepath)

  html_doc = Nokogiri::HTML(html_text)

  crawler = SERP::Crawler.new(
    html_doc: html_doc,
    stencil: SERP::GOOGLE_FILM_CHARACTERS_CAROUSEL_STENCIL
  )

  data = crawler.crawl(
    &SERP::GOOGLE_FILM_CHARACTERS_CAROUSEL_DATA_BUILDER
  )

  puts SERP::JSONGenerator.generate(data: data, pretty: true)
end
