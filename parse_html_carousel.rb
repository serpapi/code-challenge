require "nokogiri"
require "json"
require "pry"
require "base64"

file = File.open(File.join(File.dirname(__FILE__), 'files/van-gogh-paintings.html'), 'r+')
doc = Nokogiri::HTML(file)
paintings = {}
paintings["knowledge_graph"] = {}
paintings["organic_results"] = []
paintings["search_parameters"] = {}
paintings["search_information"] = {}
paintings["related_questions"] = []
paintings["people_also_search_for"] = []

doc.css('div.g').each_with_index do |res, index|

  res.css(".mod").each do |ele|
    paintings["knowledge_graph"][ele.css("h3").text.downcase] = ele.css("span").text unless ele.css("h3").text.empty?
    ele.css("a").each do |link|
      paintings["knowledge_graph"]["people_also_search_for_link"] = link['href'] if link.text == "People also search for"
      if link.text == "Wikipedia"
        source = {
          "name": link.text,
          "link": link['href']
        }
        paintings["knowledge_graph"]["source"] = source
      end
      unless link.css('img').empty?
        people = {
          "name": link.text,
          "link": link['href'],
          "image": link.css('img').first['src'],
          "source": "peopleperson"
        }
        paintings["people_also_search_for"].push(people)
      end
    end
    text_arr = ele.css("span").text.split(": ")
    paintings["knowledge_graph"][text_arr[0].downcase] = text_arr[1] if text_arr.length == 2
  end

  res.css(".related-question-pair").each do |ques|
    question = {}
    question["question"] = ques.text
    paintings["related_questions"].push(question)
  end
  if !res.css('h3').text.empty? && res.css('h3').text.downcase != "description"
    result = {}
    result["position"] = index + 1
    result["title"] = res.css('h3').text.strip
    result["snippet"] = res.at_css('div.s span.st')&.text&.strip
    result["link"] = res.at_css('a')['href']
    result["displayed_link"] = res.css("div.TbwUpd").text
    result["cached_page_link"] = res.at_css("li a")&.attributes["href"]&.value
    inline = []
    res.css("div.osl a").each do |link|
      inline_link = {}
      inline_link["title"] = link.text
      inline_link["link"] = link.attributes["href"].value
      inline.push(inline_link)
    end
    result["sitelinks"] = {}
    result["sitelinks"]["inline"] = inline
    result["rich_snippet"] = {}
    result["rich_snippet"]["bottom"] = {}
    result["rich_snippet"]["bottom"]["extensions"] = []
    res.css(".P1usbc .VNLkW").children.each do |child|
      result["rich_snippet"]["bottom"]["extensions"].push(child.text)
    end
    paintings["organic_results"].push(result)
  end
end

doc.css('div input[title="Search"]').each do |input|
  value = input.attr('value')
  if value
    paintings["search_parameters"][input.attr('name')] = value 
    paintings["search_information"]["query_displayed"] = value
    paintings["knowledge_graph"]["title"] = value
  end
end

doc.css('div input[type="hidden"]').each do |input|
  value = input.attr('value')
  paintings["search_parameters"][input.attr('name')] = value if value
end
paintings["search_parameters"]["google_domain"] = "google.com"
paintings["search_parameters"]["device"] = "desktop"

paintings["related_searches"]=[]
doc.css(".nVcaUb a").each do |ele|
  search = {}
  search["query"] = ele.text 
  search["link"] = "https://www.google.com" + ele.attributes["href"].value
  paintings["related_searches"].push(search)
end

paintings["knowledge_graph"]["artworks"] = []
doc.css("a.klitem").each do |painting|
  artwork = {}
  artwork['name'] = painting.css(".kltat").text.strip
  artwork['extensions'] = [painting.css(".ellip").text.strip] unless painting.css(".ellip").text.empty?
  artwork['link'] = "https://www.google.com" + painting.attributes["href"].value
  artwork['image'] = painting.css(".klic img").attribute('src')&.value
  paintings["knowledge_graph"]["artworks"].push(artwork)
end

other_pages = {}
paintings["pagination"] = {}
doc.css('table[role="presentation"] tr[valign="top"] td').children.each do |td|
  paintings["pagination"]["current"] = td.text if td.text == "1"
  paintings["pagination"]["next"] = td.attributes["href"].value if td.text == "Next"
  other_pages[td.text] = "https://www.google.com" + td.attributes["href"]&.value if !td.text.empty? && td.text != "1" && td.text != "Next"
end
paintings["pagination"]["other_pages"] = other_pages

paintings["search_metadata"] = {}
doc.css('meta').each do |tag|
  search_url = tag['content'].split("url=").last
  paintings["search_metadata"]["google_url"] = "https://www.google.com" + search_url
end

# propulate the JSON van-gogh-paintings file

File.open("van-gogh-paintings.json", "wb") do |json|

  json << JSON.pretty_generate(paintings)

end

# propulate the JSON expected_array file

File.open("expected_array.json", "wb") do |json|

  json << JSON.pretty_generate({ "artworks": paintings["knowledge_graph"]["artworks"]})

end
