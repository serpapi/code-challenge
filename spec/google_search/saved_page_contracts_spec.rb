# frozen_string_literal: true

RSpec.describe GoogleSearch::ArtworkExtractor, "with saved Google page contracts" do
  FixtureFiles::SAVED_PAGE_FIXTURES.each do |saved_page|
    it "exactly matches the reviewed JSON for #{saved_page.name}" do
      html = fixture_file(saved_page.html_path)
      expected = json_fixture(saved_page.expected_path)

      expect(described_class.new(html).call).to eq(expected)
    end
  end

  it "requires every saved page to contain Google's visual-artist works marker" do
    aggregate_failures do
      saved_page_fixtures.each do |saved_page|
        document = Nokolexbor::HTML(fixture_file(saved_page.html_path))
        works_root = document.at_css("[data-attrid='kc:/visual_art/visual_artist:works']")

        expect(works_root).not_to be_nil, saved_page.html_path
      end
    end
  end
end
