# frozen_string_literal: true

require "nokogiri"
require "uri"

class GoogleAiOverviewParser
  def initialize(html)
    @document = Nokogiri::HTML(html)
  end

  def parse
    {
      ai_overview: ai_overview
    }.compact
  end

  private

  attr_reader :document

  def ai_overview
    return nil unless ai_overview_node

    {
      text_blocks: text_blocks
    }
  end

  def ai_overview_node
    @ai_overview_node ||= document.at_css(".EyBRub.jUja0e:has(.LT6XE), .em0bhd.EyBRub:has(.niO4u)")
  end

  def text_blocks
    ai_overview_node.css('[data-subtree="aimfl,mfl"]').map do |node|
      {
        type: "paragraph",
        snippet: node.text.to_s.strip
      }
    end
  end

  def normalize_link(href)
    return nil if href.nil? || href.empty?

    href
  end
end
