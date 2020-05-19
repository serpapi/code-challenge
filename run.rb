# frozen_string_literal: true

require_relative './scraper'

# prepare files:
# urls = [{url: 'https://www.google.com/search?hl=en&q=Michelangelo%20paintings', file: 'files/michelangelo.html'},
#         {url: 'https://www.google.com/search?hl=en&q=Van%20Gogh%20paintings', file: 'files/van-gogh-updated.html'},
#         {url: 'https://www.google.com/search?hl=en&q=Rembrandt%20paintings', file: 'files/rembrandt.html'},
#         {url: 'https://www.google.com/search?hl=en&q=serp+api', file: 'files/serp-api.html'}
#        ].each do |x|
#   puts "Downloading #{x[:url]} to #{x[:file]} ..."
#   data = Scraper.dump_html(x[:url])
#   File.write(x[:file], data)
# end

# run for original file:
data = Scraper.run(FileURI.new('./files/van-gogh-paintings.html'))
puts JSON.pretty_generate(data)
