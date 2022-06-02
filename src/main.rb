require_relative "GoogleAppBarExtractor"

html = File.read(__dir__ + "/tests/mu-fc-players.html")

extractor = GoogleAppBarExtractor.new

extractor.extract_cards(html)
# File.write(__dir__ + '/res.json' , extractor.extract_cards(html).to_json)