require 'nokogiri'

# Mocks a HTTP request to load a Search Engine Results Page
class MockSerpLoader
  def load_serp_document
    Nokogiri::HTML.parse(File.open('spec/mock-artwork-serp.html'), nil, Encoding::UTF_8.to_s)
  end
end