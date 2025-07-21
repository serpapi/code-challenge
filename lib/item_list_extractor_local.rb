require 'item_list_extractor'

class ItemListExtractorLocal < ItemListExtractor

  def initialize(file_location)
    file = File.read(file_location)
    @doc = Nokogiri::HTML(file)
  end

end
