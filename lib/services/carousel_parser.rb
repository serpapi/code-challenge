# frozen_string_literal: true

require_relative 'abstract_service'
require 'json'
require 'nokolexbor'
require 'uri'
require_relative 'logger'

module Services
  # parse google search carousel
  class CarouselParser < AbstractService
    URL = 'https://www.google.com'
    CAROUSEL_TAG = 'g-scrolling-carousel'
    IMAGE_TAG = 'g-img img'
    META_TAG = '.klmeta'
    NAME_LABEL = 'aria-label'

    def initialize(html, result_name = nil)
      super()
      @result_name = result_name
      @parser = ::Nokolexbor::HTML(html)
    end

    def call
      # get carousel items
      parent_nodes = @parser&.css(CAROUSEL_TAG)&.[](0)&.css('a') || []
      # map carousel items to our special flavour artwork array :)
      results = build_items_by_parent_nodes(parent_nodes)

      {
        @result_name || 'results' => results
      }
    end

    private

    def build_items_by_parent_nodes(parent_nodes)
      parent_nodes.map do |node|
        params = %i[name meta link image].map(&(proc { |item| send("build_#{item}", node) }))
        build_carousel_item(*params)
      end
    end

    def build_carousel_item(name, meta, link, image)
      item = {
        'name' => name,
        'image' => image,
        'link' => link
      }
      item['extensions'] = [meta] if meta
      item
    end

    def build_link(node)
      link = node&.attributes&.[]('href')&.value
      if link.nil?
        Services::Logger.instance.log(:warn, "no link found for #{node.inspect}")
        return
      end

      link = [URL, link].join unless link.start_with? URL
      link
    end

    def build_name(node)
      name = node.attributes[NAME_LABEL].value
      Services::Logger.instance.log(:error, "no name found for #{node.inspect}") if name.nil?
      name
    end

    def build_image(node)
      id = node&.css(IMAGE_TAG)&.[](0)&.attributes&.[]('id')
      image = extract_base64(id)
      Services::Logger.instance.log(:warn, "no image found for #{node.inspect}") if image.nil?
      image
    end

    def build_meta(node)
      meta = node&.css(META_TAG)&.[](0)&.text
      # since meta info is not always existent, we will log this as an info.
      Services::Logger.instance.log(:info, "no meta info found for #{node.inspect}") if meta.nil?
      meta
    end

    def extract_base64(id)
      @parser
        &.xpath("//script[contains(., '#{id}')][1]")
        &.text
        &.[](/(data:image[^']+)/, 1)
        &.delete('\\')
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    puts 'Please enter a path to an HTML file.'
    exit
  end

  file_path = ARGV[0]
  unless File.exist?(file_path)
    puts 'The given file does not exist.'
    exit
  end
  html = File.read(file_path)
  parser = Services::CarouselParser.call(html, ARGV[1])
  result = parser.to_json
  puts result
end
