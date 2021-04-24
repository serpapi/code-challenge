require 'nokogiri'
require 'json'
class Scrape
  def self.execute(path)
    file = File.read(path)
    doc = Nokogiri::HTML(file)
    carousel = doc.search("g-scrolling-carousel").first
    anchors=[]
    artworks=[]
    carousel.search('a').each do |anchor|
      if anchor.text.gsub("#{anchor.attribute('aria-label').value}","")==""
        artwork={"name"=>anchor.attribute('aria-label').value,
        "link"=>unless anchor.attribute('href').nil? then "https://www.google.com"+anchor.attribute('href').value end,
        "image"=>begin if doc.text.split("#{anchor.search('img').first.attribute('id').value}")[0].gsub("\';var ii=[\'","").split("var s=\'")[-1].gsub('\\','').include? " " then nil else doc.text.split("#{anchor.search('img').first.attribute('id').value}")[0].gsub("\';var ii=[\'","").split("var s=\'")[-1].gsub('\\','') end rescue nil end}
      else
        artwork={"name"=>anchor.attribute('aria-label').value,
        "extensions"=>[anchor.text.gsub("#{anchor.attribute('aria-label').value}","")],
        "link"=>unless anchor.attribute('href').nil? then ("https://www.google.com"+anchor.attribute('href').value).gsub("https://www.google.comhttps://www.google.com","https://www.google.com") end,
        "image"=>begin if doc.text.split("#{anchor.search('img').first.attribute('id').value}")[0].gsub("\';var ii=[\'","").split("var s=\'")[-1].gsub('\\','').include? " " then nil else doc.text.split("#{anchor.search('img').first.attribute('id').value}")[0].gsub("\';var ii=[\'","").split("var s=\'")[-1].gsub('\\','') end rescue nil end}
      end
      artworks.append(artwork)
    end
    artworks={"artworks"=>artworks}
    File.open("solution.json","w") do |f|
    f.write(JSON.pretty_generate(artworks).lines[0..-2].join.gsub("\n  ","\n")[2..-2])
    end
    return artworks
  end
end
