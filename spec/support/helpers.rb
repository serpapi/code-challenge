# frozen_string_literal: true

require "json"
require "nokogiri"

def project_root
  File.dirname(File.expand_path("..", __dir__))
end

def file_fixture(path)
  File.new("#{project_root}/spec/fixtures/#{path}")
end

def google_search_results(search)
  search.strip.downcase.tr(" ", "-").then { file_fixture("#{_1}.html") }
end

def json_fixture(path)
  path
    .strip
    .downcase
    .chomp(".json")
    .then { file_fixture("#{_1}.json").read }
    .then { JSON.parse(_1, symbolize_names: true) }
end

def html_fixture(html)
  Nokogiri::HTML::Document.parse(html, nil, Encoding::UTF_8.to_s)
end
