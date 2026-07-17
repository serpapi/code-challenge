# frozen_string_literal: true

require "json"

module FixtureFiles
  PROJECT_ROOT = File.expand_path("../..", __dir__).freeze
  ADDITIONAL_FIXTURE_DIRECTORY = File.join(PROJECT_ROOT, "spec", "fixtures").freeze
  SavedPageFixture = Data.define(:name, :html_path, :expected_path)

  additional_html_names = Dir.children(ADDITIONAL_FIXTURE_DIRECTORY).filter_map do |filename|
    filename.delete_suffix(".html") if filename.end_with?(".html")
  end.sort
  additional_expected_names = Dir.children(ADDITIONAL_FIXTURE_DIRECTORY).filter_map do |filename|
    filename.delete_suffix(".expected.json") if filename.end_with?(".expected.json")
  end.sort

  unless additional_html_names == additional_expected_names
    missing_expected = additional_html_names - additional_expected_names
    missing_html = additional_expected_names - additional_html_names
    problems = []
    problems << "missing expected JSON for #{missing_expected.join(", ")}" unless missing_expected.empty?
    problems << "missing HTML for #{missing_html.join(", ")}" unless missing_html.empty?

    raise "Saved-page fixtures are incomplete: #{problems.join("; ")}"
  end

  SAVED_PAGE_FIXTURES = [
    SavedPageFixture.new(
      name: "van-gogh-paintings",
      html_path: "files/van-gogh-paintings.html",
      expected_path: "files/expected-array.json"
    ),
    *additional_html_names.map do |name|
      SavedPageFixture.new(
        name: name,
        html_path: "spec/fixtures/#{name}.html",
        expected_path: "spec/fixtures/#{name}.expected.json"
      )
    end
  ].freeze

  def fixture_file(*path)
    File.binread(File.join(PROJECT_ROOT, *path))
  end

  def json_fixture(*path)
    JSON.parse(fixture_file(*path))
  end

  def saved_page_fixtures
    SAVED_PAGE_FIXTURES
  end
end
