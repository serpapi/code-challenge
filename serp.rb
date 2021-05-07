require 'json'
require 'nokogiri'

# Run with:
# ruby serp.rb files/van-gogh-paintings.html
# ruby serp.rb files/kubrick.html
# ruby serp.rb files/dostoevsky.html

# It would be nice to have some proper error messages for missing arg/file
# but that's too much work...
doc = Nokogiri::HTML(File.open(ARGV[0]), nil, Encoding::UTF_8.to_s)

ls = doc.css("script").select{ |x| x.text.match(/_setImagesSrc/) }.join
tlookup = ls.scan(/(data:image[^']+)';var ii=\['([^']+)'\]/).to_h.invert

arr = Array.new
prefix = "https://www.google.com"
doc.css(".klitem-tr").each do |elem|
  var = elem.css("img").attribute("id")
  link = prefix
  if elem.name == "a"
    link += elem.attribute("href")
  else
    link += elem.css("a").attribute("href")
  end
  arr.push({
    :name => elem.css(".kltat").text,
    :link => link, # prefix + elem.css("a").attribute("href"),
    :extensions => elem.css(".klmeta").map { |x| x.text },
    :image => tlookup[var.to_s]
  })
end
puts JSON.pretty_generate(arr)

