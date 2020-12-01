class ParserWorker
  def process(node)
    node.map do |n|
      parse(n)
    end
  end

  def parse(n)
    result = {}

    # name
    k = n.css('.klitem').first
    result[:name] = n.css('.kltat').children.text

    # extensions
    year = n.css('.klmeta').text
    ext = { :extensions => [year] }
    result.merge!(ext) unless ext[:extensions].first.empty?

    # link
    k = n.css('.klitem').first
    result[:link] = "https://www.google.com#{k['href']}"

    # image
    result[:image] = n.css('div.klic > g-img > img')[0]['src']

    result
  end
end
