# frozen_string_literal: true

require 'dry-configurable'

class App
  include Dry::Configurable

  setting :page_api_adapter, default: :nokolexbor
  setting :fixtures_path

  def fixture_path(fixture)
    File.join(config.fixtures_path, fixture)
  end

  def parser(parser)
    case parser
    in :google_carousel
      Parser::Google::Carousel
    in value
      raise Errors::ParserNotFound, "provided: '#{value}'"
    end
  end

  def page_api_handler
    case config.page_api_adapter
    in :nokogiri
      PageApi::Nokogiri
    in :nokolexbor
      PageApi::Nokolexbor
    in value
      raise Errors::PageAdapterNotFound, "provided: '#{value}'"
    end
  end
end
