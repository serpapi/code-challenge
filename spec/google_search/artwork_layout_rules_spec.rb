# frozen_string_literal: true

RSpec.describe GoogleSearch::ArtworkLayoutRules do
  def rules_for(path)
    document = Nokolexbor::HTML(fixture_file(path))
    described_class.new(document)
  end

  it "recognizes every saved page with the shared card-structure rule" do
    saved_page_fixtures.each do |saved_page|
      rules = rules_for(saved_page.html_path)
      cards = rules.cards
      expected_count = json_fixture(saved_page.expected_path).fetch("artworks").length

      expect(cards.length).to eq(expected_count), saved_page.html_path
      expect(rules.matches?(cards, described_class::STRUCTURAL_RULE)).to be(true), saved_page.html_path
    end
  end

  it "ignores Google-generated classes and JavaScript attributes when checking cards" do
    document = Nokolexbor::HTML(<<~HTML)
      <div data-attrid="kc:/visual_art/visual_artist:works">
        <div class="ignored-collection" jsname="ignored-collection">
          <div class="ignored-card" jsdata="ignored-card-data">
            <a href="/search?q=one">
              <img alt="One">
              <div><span class="ignored-name">One</span><span class="ignored-extension">1901</span></div>
            </a>
          </div>
          <div class="different-ignored-card" jsdata="different-ignored-card-data">
            <a href="/search?q=two">
              <img alt="Two">
              <div><span class="different-ignored-name">Two</span><span>1902</span></div>
            </a>
          </div>
        </div>
      </div>
    HTML
    rules = described_class.new(document)
    cards = rules.cards

    expect(rules.matches?(cards, described_class::STRUCTURAL_RULE)).to be(true)
  end
end
