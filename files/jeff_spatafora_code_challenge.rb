### I tried to get to a solution using the Nokogiri gem for parsing html in Ruby. Not sure if I was on the right path with this. I was trying to find more for a solution via the Nokogiri documentation, but wasn't able to get there in the alloted time. I spent some time trying other approches using the json gem and active_support gem.

### I attempted to parse out the 'klitem' anchor tags since that seemed to be the tags associated with the images in the top carrousel when I was scanning through the html with the javascript console dev tool in Chrome. 

### I didn't feel like I got a point in this challenge to implemnet any RSpec tests. I have worked with RSpec testing in my bootcamp, however we only spent about half a day with it. So I haven't had much experience with it yet, but I feel it's something I can definitely learn, with more time.



#### work with Nokogiri ####

require 'nokogiri'

# html = File.read('file:///Users/jefferyspatafora/Actualize/serpapi-code-challenge/code-challenge/files/van-gogh-paintings.html')
# document = Nokogiri::HTML.parse(html)

# p document

# html = "<title>test</title>actual content here..."
# parsed_data = Nokogiri::HTML.parse(html)

# puts parsed_data.title


html = "file:///Users/jefferyspatafora/Actualize/serpapi-code-challenge/code-challenge/files/van-gogh-paintings.html"
document = Nokogiri::HTML.parse(html)

p document

# anchors = document.css('klitem')
# headers    = document.css("h1")
# paragraphs = document.css("p")

title = document.at('title')
p title

anchors = document.search('a')
p anchors
# p headers
# p paragraphs