# frozen_string_literal: true

require 'rake'
require 'json'

# Zeitwerk simplifies autoloading and
# provides reloading for later integration with web server or job processing
require_relative 'app/setup'

task :load do
  setup_auto_loading
end

namespace :google do
  desc 'Manualy run Google Carousel parser'
  task carousel: :load do
    variant = 'variant1'

    app = App.new.configure do |config|
      config.fixtures_path = "#{__dir__}/fixtures"
    end

    fixture = Fixture.load!(app.fixture_path("google/carousel/#{variant}"))

    parser = app.parser(:google_carousel).new(
      page_api: app.page_api_handler,
      data: fixture.data
    )

    case parser.parse
    in Parser::Response(data) => response
      is_verified = Parser::Verifier.new(response, fixture.expected).valid?

      puts "[#{variant}] Parsed data matches expected results (verified = #{is_verified}):"
      puts JSON.pretty_generate(data)
    in Parser::Error(exception)
      raise exception
    in value
      raise StandardError, "unexpected response: '#{value}'"
    end
  end
end
