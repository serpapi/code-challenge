# frozen_string_literal: true

RSpec.describe GoogleAiOverviewParser do
  def fixture(name)
    File.read(File.expand_path("../fixtures/#{name}", __dir__))
  end

  let(:result) { described_class.new(fixture("google_ai_overview_top_stories_iran_war_status.html")).parse }

  it "returns an ai_overview hash" do
    expect(result[:ai_overview]).to be_a(Hash)
  end

  it "returns text_blocks array" do
    expect(result[:ai_overview][:text_blocks]).to be_an(Array)
    expect(result[:ai_overview][:text_blocks]).not_to be_empty
  end

  describe "text_blocks" do
    let(:text_blocks) { result[:ai_overview][:text_blocks] }

    {
      type: String,
      snippet: String,
    }.each do |attribute, type|
      it "has #{attribute}" do
        text_blocks.each do |text_block|
          expect(text_block[attribute]).to be_a(type)
          expect(text_block[attribute]).not_to be_empty if text_block[attribute].respond_to?(:empty?)
        end
      end
    end
  end
end
