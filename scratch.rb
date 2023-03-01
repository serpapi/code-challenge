# Scratch file while I play around with file

# This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
# Try to come up with your own solution and your own test.
#
# Extract the
# - painting `name`,
# - `extensions` array (date),
# - Google `link` in an array.
# ---------------------------------------------------------------------------------------------------------------------
# Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.
#
# [relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
# [sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
# [html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
# [expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json
#
# Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed).
#
# Test against 2 other similar result pages. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)
# ---------------------------------------------------------------------------------------------------------------------
# JSON Shape
# "artworks": [
#   {
#     "name": "The Starry Night",
#     "extensions": [
#       "1889"
#     ],
#     "link": "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
#     "image": "data:image/jpeg;base64,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"
#   },
#   {
#     "name": "Irises",
#     "extensions": [
#       "1889"
#     ],
#     "link": "https://www.google.com/search?gl=us&hl=en&q=Irises+(painting)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLGMzUvMi7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhX0LMosTi1W0ChIzASqz0vXBADZ_49eqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIMg",
#     "image": "data:image/jpeg;base64,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"
#   },
#
# ---------------------------------------------------------------------------------------------------------------------
# Notes to self:
# `expected-array.json` isn't valid JSON, may need to format it differently to be read by JSON parser
# it starts as a key-value without enclosing { }
#

require 'mechanize'
require 'pry'

FILE_PATH = File.expand_path('files/van-gogh-paintings.html', File.dirname(__FILE__))
file_url = "file:///#{FILE_PATH}"

@agent = Mechanize.new
page = @agent.get(file_url)
# - All of the content exists in div#main
# - Carousel looks to exist in div.appbar/div#appbar
# - There's an interesting <g-scrolling-carousel ..></g-scrolling-carousel> element
# - Functionally the left/right arrow buttons in carousel don't do anything, maybe cause it's local? Can still horizonal scroll

# Structure of g carousel
# <g-scrolling-carousel
#   <div
#   <g-left-button
#   <g-right-button
#   <script
# </g-scrolling-carousel

# The content we want to scrape is in the <div>
binding.pry

content = page.search('g-scrolling-carousel/div/div/a')
# Scraper assumptions, that g-scrolling-carousel has a div that nests another div
# This 2nd div has all of the items that we want

def parse_content(div)
  # Expects a div that's an carousel "element"

  # Assumes only 1 image and that it exists
  image = div.at('img')
  image_attributes = image.attributes.map { |k, v| [k, v.value] }.to_h
  # => {"data-key"=>
  #   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0",
  #  "id"=>"kximg0",
  #  "src"=>"data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==",
  #  "data-deferred"=>"1",
  #  "class"=>"rISBZc M4dUYb",
  #  "height"=>"120",
  #  "width"=>"120",
  #  "alt"=>""}
  #
  # What's interesting is the `src` actually differs from what is in expected-array.json and what you get in chrome inspector
  # Actual value from chrome:
  # <<~ACTUAL_DATA
  #  data:image/jpeg;base64,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
  # ACTUAL_DATA

  # Source: content.children[0].search('a').first <> div.search('a').first
  #
  # {"class"=>#(Attr:0xc8b4 { name = "class", value = "klitem" }),
  #  "aria-label"=>#(Attr:0xc8c8 { name = "aria-label", value = "The Starry Night" }),
  #  "aria-posinset"=>#(Attr:0xc8dc { name = "aria-posinset", value = "1" }),
  #  "aria-setsize"=>#(Attr:0xc8f0 { name = "aria-setsize", value = "51" }),
  #  "data-sp"=>#(Attr:0xc904 { name = "data-sp", value = "0,17,26" }),
  #  "href"=>
  #   #(Attr:0xc918 {
  #     name = "href",
  #     value = "/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"
  #     }),
  #  "style"=>#(Attr:0xc92c { name = "style", value = "height:193px;width:120px" }),
  #  "title"=>#(Attr:0xc940 { name = "title", value = "The Starry Night (1889)" }),
  #  "role"=>#(Attr:0xc954 { name = "role", value = "button" }),
  #  "data-hveid"=>#(Attr:0xc968 { name = "data-hveid", value = "47" }),
  #  "data-ved"=>#(Attr:0xc97c { name = "data-ved", value = "0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw" })}

  # Looks like the actual hierarchy is:
  # div/a has 2 divs
  # div/a/div[0]:
  # - has image information
  #   - data-key: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0"
  #   ^ looks like a google url
  #   - src: base64 image data
  #
  # div/a/div[1]
  # - has 2 divs
  # - 1st div has the name of the art piece
  # - 2nd div has text of the year (extension)
end
