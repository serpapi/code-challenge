# frozen_string_literal: true

require 'dry-configurable'

class App
  include Dry::Configurable

  PARSERS = {
    google_carousel: Parser::Google::Carousel
  }.freeze

  PAGE_API_ADAPTERS = {
    nokogiri: PageApi::Nokogiri,
    nokolexbor: PageApi::Nokolexbor
  }.freeze

  setting :page_api_adapter, default: :nokolexbor
  setting :fixtures_path

  def fixture_path(fixture)
    File.join(config.fixtures_path, fixture)
  end

  def parser(parser)
    PARSERS[parser] || raise(Errors::ParserNotFound, "provided: '#{value}'")
  end

  def page_api_handler
    PAGE_API_ADAPTERS[config.page_api_adapter] || raise(Errors::PageAdapterNotFound, "provided: '#{value}'")
  end
end
