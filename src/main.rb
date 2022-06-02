require_relative "GoogleAppBarExtractor"

html = File.read(__dir__ + "/../files/mu-fc-players.html")

extractor = GoogleAppBarExtractor.new

File.write(__dir__ + '/res.json' , extractor.extract_cards(html).to_json)