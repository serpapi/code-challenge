# Used this snippet to get the html for the xbox games carousel:
#
# require "selenium-webdriver"
#
# driver = Selenium::WebDriver.for :chrome
# driver.navigate.to("https://www.google.com/search?q=playstation+5+games")
#
# File.write("./files/ps5-games.html", driver.page_source)

require "json"
require "./app/google/carousel_parser"

van_gogh_html = File.read("./files/van-gogh-paintings.html")
van_gogh_paintings = Google::CarouselParser.new(van_gogh_html).items
File.write("./files/van-gogh-artwork.json", JSON.generate(van_gogh_paintings))
pp van_gogh_paintings

xbox_html = File.read("./files/xbox-games.html")
xbox_games = Google::CarouselParser.new(xbox_html).items
File.write("./files/xbox-games.json", JSON.generate(xbox_games))

ps5_html = File.read("./files/ps5-games.html")
ps5_games = Google::CarouselParser.new(ps5_html).items
File.write("./files/ps5-games.json", JSON.generate(ps5_games))
