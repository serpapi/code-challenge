require './html_extractor'
require 'json'

@html_extractor = HtmlExtractor.new("../files/van-gogh-paintings.html")
# @html_extractor = HtmlExtractor.new("../files/fastfurious.html")
# @html_extractor = HtmlExtractor.new("../files/harry-potter-3.html")
puts @html_extractor.extract_all_paintings_information().to_json
# output of above puts is saved in actual-array.json