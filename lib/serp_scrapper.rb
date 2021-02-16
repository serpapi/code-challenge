# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/object/deep_dup'
require 'nokogiri'
require 'oj'
require 'English'

module SERP
  ##
  # SERP::Scrapper Class
  # Scraps HTML Doc-ish object with one of the approaches
  # for the original (old) SERP HTML and the current (new) HTML
  #
  # Returns the scraped data as Hash
  #
  class Scrapper
    attr_accessor :html_doc
    attr_accessor :result_key

    SCRAPPER_TYPES = [:old, :new]
    SCRAPPER_TYPE_ERROR = "Wrong type of scrapper provided! Choose between #{SCRAPPER_TYPES.join(' / ')} variants"

    GOOGLE_BASE_URL = 'https://www.google.com'

    def initialize(html_doc: nil, result_key: :items, scrapper: SCRAPPER_TYPES.first)
      @html_doc = html_doc
      @result_key = result_key

      validate_scrapper(scrapper)
      @scrapper = scrapper
    end

    def scrap
      return {} if !@html_doc || !@result_key
      return build_result(parse_old) if @scrapper == :old
      return build_result(parse_new) if @scrapper == :new
    end

    def scrapper=(scrapping_type)
      validate_scrapper(scrapping_type)
      @scrapper = scrapping_type
    end

    private

    def validate_scrapper(scrapping_type)
      raise ArgumentError, SCRAPPER_TYPE_ERROR unless SCRAPPER_TYPES.include?(scrapping_type.to_sym)
    end

    def build_result(data)
      data
    end

    def parse_old
      results = {
        @result_key => []
      }

      images = extract_old_images

      @html_doc.css('g-scrolling-carousel .klitem-tr').each_with_index do |carousel_item, i|
        result = {}

        extensions = carousel_item.css('.klmeta').first&.text

        result[:name] = carousel_item.css('.kltat span').text
        result[:link] = "#{GOOGLE_BASE_URL}#{carousel_item.css('.klitem').first['href']}"
        result[:image] = images[carousel_item.css('g-img img').first['id']]
        result[:extensions] = !extensions || extensions.empty? ? nil : Array.wrap(extensions)

        results[@result_key] << result
      end

      results
    end

    def parse_new
      results = {
        @result_key => []
      }

      images = extract_new_images

      @html_doc.css('g-scrolling-carousel .klitem-tr').each_with_index do |carousel_item, i|
        result = {}

        image = carousel_item.css('g-img img').first
        extensions = carousel_item['title']&.match(/\((.*)\)/)&.captures&.fetch(0, nil)

        result[:name] = carousel_item['data-entityname']
        result[:link] = "#{GOOGLE_BASE_URL}#{carousel_item['href']}"
        result[:image] = images[image['id']] if image
        result[:extensions] = !extensions || extensions.empty? ? nil : Array.wrap(extensions)

        results[@result_key] << result
      end

      results
    end

    def extract_old_images
      matches = {}

      @html_doc.css('div#cnt > script').each do |script|
        if script.content =~ /\Afunction _setImagesSrc/
          # script.content.scan(/(?<img_id>kximg\d+).*?(?<base64>data\:.*?)(?>\')/) do
          script.content.scan(/(?<base64>data\:.*?)(\';.*?')(?<img_id>kximg\d+)/) do
            # create image Hash using named captures
            image = Hash[%i[base64 img_id].zip($LAST_MATCH_INFO.captures)]

            # set img_id => base64 with extra unescaping
            matches[image[:img_id]] = image[:base64].gsub('\\', '')
          end
        end
      end

      matches
    end

    def extract_new_images
      matches = {}

      @html_doc.css('script').each do |script|
        if script.content =~ /_setImagesSrc\(ii,s\);}\)\(\);\Z/
          # script.content.scan(/(?<img_id>kximg\d+).*?(?<base64>data\:.*?)(?>\')/) do
          script.content.scan(/(?<base64>data\:.*?)(\';.*?')(?<img_id>dimg_\d+)/) do
            # create image Hash using named captures
            image = Hash[%i[base64 img_id].zip($LAST_MATCH_INFO.captures)]

            # set img_id => base64 with extra unescaping
            matches[image[:img_id]] = image[:base64].gsub('\\', '')
          end
        end
      end

      matches
    end
  end
end

# This is how I prefer to write and test while developing independent, pure, old-good Ruby classes
#
# bundle exec ruby ./lib/serp_scrapper.rb
if $PROGRAM_NAME == __FILE__
  # https://gist.github.com/smileart/1b9217389904580316780e7c2a0d466a – my replacepent of letters#o from letters gem
  require 'testrocket'

  require_relative './utils/tapp_amazing_print'
  require_relative './json_generator'

  # html_filepath = File.expand_path('./files/the-big-lebowski-characters.html', Dir.pwd)
  html_filepath = File.expand_path('./files/x-files-characters.html', Dir.pwd)
  html_text = File.read(html_filepath)
  html_doc = Nokogiri::HTML(html_text)

  scrapper = SERP::Scrapper.new(
    html_doc: html_doc,
    scrapper: :new
  )

  data = scrapper.scrap.tapp

  # html_filepath = File.expand_path('./files/van-gogh-paintings.html', Dir.pwd)
  # html_text = File.read(html_filepath)
  # html_doc = Nokogiri::HTML(html_text)

  # scrapper.scrapper = :old
  # scrapper.html_doc = html_doc
  # scrapper.result_key = :characters

  # data = scrapper.scrap

  # puts SERP::JSONGenerator.generate(data: data, pretty: true)
end
