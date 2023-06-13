require_relative '../lib/HtmlDocument'
require 'nokogiri'

RSpec.describe HtmlDocument do
  describe '.new' do
    it 'parses HTML content' do
      # Setup
      html_content = '<html><body><g-scrolling-carousel><a href="link1"></a><a href="link2"></a></g-scrolling-carousel></body></html>'

      # Exercise
      html_doc = HtmlDocument.new(html_content)

      # Verify
      carousel_elements = html_doc.carousel
      expect(carousel_elements.length).to eq(2)
      expect(carousel_elements.map { |a| a['href'] }).to contain_exactly('link1', 'link2')
    end
  end
end

