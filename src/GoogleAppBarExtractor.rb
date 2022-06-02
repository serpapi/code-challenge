require 'nokogiri'
require 'json'

class GoogleAppBarExtractor

  def initialize
    @html_parser = Nokogiri::HTML
  end

  def extract_cards(html)

    html_dom = get_main_dom(html)

    items = extract_items_dom(html_dom)

    extract_items_content(items, html)

  end

  private

  def extract_item_link(item)
    if item['href']
      return "https://www.google.com" + item['href']
    end

    "https://www.google.com" + item.css('a')[0]["href"]
  end

  def extract_items_content(items, html)
    results = Array.new(items.size) {}

    items.each_with_index do |item, index|

      name = extract_item_name(item)

      link = extract_item_link(item)

      extensions = extract_item_extensions(item)

      img = extract_item_image(item, html)

      hidden_results = get_hidden_results(item, html)
      # puts hidden_results.kind_of
      # exit
      if extensions.size == 0 && (hidden_results.class != NilClass)
        extensions = hidden_results[:extensions]
      end


      if img.class == NilClass && (hidden_results.class != NilClass)
        img = hidden_results[:image]
      end

      if(extensions.size > 0)
        results[index] = { name: name, extensions: extensions, link: link, image: img }
      else
        results[index] = { name: name, link: link, image: img }
      end

    end

    results
  end

  def extract_item_image(item, html)
    # thumbnails are located inside a Javascript code, HTML Parser will not be able to parse it, so, we will use Regex
    # to match the thumbnails with each card.
    img = nil

    if item.css('img')[0]
      img_id = item.css('img')[0]['id']
      match = html.match(/var s='([0-9a-zA-Z:,;+\/\\]*)';var ii=\['#{img_id}'\]/im)

      # Replace `\` to make Base64 image valid.
      unless match.kind_of?(NilClass)
        img = match[1].gsub("\\", "")
      end
    end

    img

  end

  def extract_item_extensions(item)
    extensions = Array.new
    item.css('.ellip.klmeta').each do |extension|
      extensions.append(extension.content)
    end

    if extensions.size == 0
      item.css('.cp7THd').each do |extension|
        extensions.append(Nokogiri::HTML(extension.inner_html.gsub('>', '> ')).text.strip)
      end
    end
    extensions
  end

  def extract_item_name(item)
    name = nil
    if item.css('.kltat')[0].kind_of?NilClass
      name = item.attributes['aria-label'].text
    else
      name = item.css('.kltat')[0].content
    end

    return name
  end

  def extract_items_dom(html_dom)
    html_dom.css('.klitem-tr')
  end

  def get_main_dom(html)
    @html_parser.parse(html)
  end

  def get_hidden_results(item, html)
    results = nil
    if item.attributes['id']
      id = item.attributes['id']
      re = /window.jsl.dh\('#{id}','(.*?)'/m

      item_html = nil
      # Print the match result
      html.match(re) do |match|
        item_html = match[1].to_s

        item_html = item_html.gsub('\x3c', '<').gsub('\x3d', '=').gsub('\x22', '"').gsub('\x3e', '>').gsub('\x26amp;', '&')

        dom = Nokogiri::HTML(item_html)
        image = dom.css('img')[0]['data-src']

        extensions = Array.new
        dom.css('.cp7THd').each do |extension|
          extensions.append(Nokogiri::HTML(extension.inner_html.gsub('>', '> ')).text.strip)
        end


        return { extensions: extensions, image: image }
        exit
        puts extract_attributes(dom, html)
        exit

        return extract_attributes(dom, html)
        puts dom.attributes['']
        exit

        dq = "\x3cdiv jsname\x3d\x22tc98Ke\x22 aria-hidden\x3d\x22true\x22 class\x3d\x22EsIlz klitem\x22 data-sp\x3d\x2224,4,42\x22 tabindex\x3d\x22-1\x22\x3e\x3cdiv jsname\x3d\x22vgzRDe\x22 class\x3d\x22UnFsfe cyKJce\x22 aria-hidden\x3d\x22true\x22\x3e\x3cdiv jsname\x3d\x22mfX1bc\x22 class\x3d\x22keP9hb\x22\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22fmfJsc\x22 class\x3d\x22XAOBve\x22\x3e\x3cg-img class\x3d\x22ZGomKf\x22 style\x3d\x22height:120px;width:120px;background-color:#273D1C\x22\x3e\x3cimg data-src\x3d\x22https://encrypted-tbn0.gstatic.com/images?q\x3dtbn:ANd9GcShTUMGRfmbbNpD3azI9HMWekD5R3JfeXSHT7j5YQWMVuYRXfDfS8hR\x26amp;s\x3d0\x22 src\x3d\x22data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw\x3d\x3d\x22 jscontroller\x3d\x22TSZEqd\x22 jsaction\x3d\x22load:K1e2pe;BUYwVb:eNYuKb;LsLGHf:KpWyKc;rcuQ6b:npT2md\x22 class\x3d\x22YQ4gaf\x22 height\x3d\x22120\x22 width\x3d\x22120\x22 alt\x3d\x22Farms near Auvers\x22\x3e\x3c/g-img\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22QUk9kd\x22 class\x3d\x22WGwSK cyKJce\x22\x3e\x3cdiv class\x3d\x22dAassd\x22\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eFarms near \x3c/div\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eAuvers\x3c/div\x3e\x3cdiv class\x3d\x22cp7THd\x22\x3e\x3cdiv class\x3d\x22FozYP\x22\x3e1890\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e"
        sq = '\x3cdiv jsname\x3d\x22tc98Ke\x22 aria-hidden\x3d\x22true\x22 class\x3d\x22EsIlz klitem\x22 data-sp\x3d\x2224,4,42\x22 tabindex\x3d\x22-1\x22\x3e\x3cdiv jsname\x3d\x22vgzRDe\x22 class\x3d\x22UnFsfe cyKJce\x22 aria-hidden\x3d\x22true\x22\x3e\x3cdiv jsname\x3d\x22mfX1bc\x22 class\x3d\x22keP9hb\x22\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22fmfJsc\x22 class\x3d\x22XAOBve\x22\x3e\x3cg-img class\x3d\x22ZGomKf\x22 style\x3d\x22height:120px;width:120px;background-color:#273D1C\x22\x3e\x3cimg data-src\x3d\x22https://encrypted-tbn0.gstatic.com/images?q\x3dtbn:ANd9GcShTUMGRfmbbNpD3azI9HMWekD5R3JfeXSHT7j5YQWMVuYRXfDfS8hR\x26amp;s\x3d0\x22 src\x3d\x22data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw\x3d\x3d\x22 jscontroller\x3d\x22TSZEqd\x22 jsaction\x3d\x22load:K1e2pe;BUYwVb:eNYuKb;LsLGHf:KpWyKc;rcuQ6b:npT2md\x22 class\x3d\x22YQ4gaf\x22 height\x3d\x22120\x22 width\x3d\x22120\x22 alt\x3d\x22Farms near Auvers\x22\x3e\x3c/g-img\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22QUk9kd\x22 class\x3d\x22WGwSK cyKJce\x22\x3e\x3cdiv class\x3d\x22dAassd\x22\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eFarms near \x3c/div\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eAuvers\x3c/div\x3e\x3cdiv class\x3d\x22cp7THd\x22\x3e\x3cdiv class\x3d\x22FozYP\x22\x3e1890\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e'
        dq = File.read(__dir__ + "/sample.html")
        dq = "\x3cdiv data-name\x3d\x22region-name\x22 class\x3d\x22main-id\x22\x3eUK\x3c/div\x3e"
        # x = HTMLEntities.new.decode(sq.html_safe)
        puts sq.class
        puts dq.class
        x = CGI.unescapeHTML(dq)
        # x = CGI.unescapeHTML("\x3cdiv jsname\x3d\x22tc98Ke\x22 aria-hidden\x3d\x22true\x22 class\x3d\x22EsIlz klitem\x22 data-sp\x3d\x2224,4,42\x22 tabindex\x3d\x22-1\x22\x3e\x3cdiv jsname\x3d\x22vgzRDe\x22 class\x3d\x22UnFsfe cyKJce\x22 aria-hidden\x3d\x22true\x22\x3e\x3cdiv jsname\x3d\x22mfX1bc\x22 class\x3d\x22keP9hb\x22\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22fmfJsc\x22 class\x3d\x22XAOBve\x22\x3e\x3cg-img class\x3d\x22ZGomKf\x22 style\x3d\x22height:120px;width:120px;background-color:#273D1C\x22\x3e\x3cimg data-src\x3d\x22https://encrypted-tbn0.gstatic.com/images?q\x3dtbn:ANd9GcShTUMGRfmbbNpD3azI9HMWekD5R3JfeXSHT7j5YQWMVuYRXfDfS8hR\x26amp;s\x3d0\x22 src\x3d\x22data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw\x3d\x3d\x22 jscontroller\x3d\x22TSZEqd\x22 jsaction\x3d\x22load:K1e2pe;BUYwVb:eNYuKb;LsLGHf:KpWyKc;rcuQ6b:npT2md\x22 class\x3d\x22YQ4gaf\x22 height\x3d\x22120\x22 width\x3d\x22120\x22 alt\x3d\x22Farms near Auvers\x22\x3e\x3c/g-img\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22QUk9kd\x22 class\x3d\x22WGwSK cyKJce\x22\x3e\x3cdiv class\x3d\x22dAassd\x22\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eFarms near \x3c/div\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eAuvers\x3c/div\x3e\x3cdiv class\x3d\x22cp7THd\x22\x3e\x3cdiv class\x3d\x22FozYP\x22\x3e1890\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e")
        # x = CGI.unescapeHTML("\x3cdiv jsname\x3d\x22tc98Ke\x22 aria-hidden\x3d\x22true\x22 class\x3d\x22EsIlz klitem\x22 data-sp\x3d\x2224,4,42\x22 tabindex\x3d\x22-1\x22\x3e\x3cdiv jsname\x3d\x22vgzRDe\x22 class\x3d\x22UnFsfe cyKJce\x22 aria-hidden\x3d\x22true\x22\x3e\x3cdiv jsname\x3d\x22mfX1bc\x22 class\x3d\x22keP9hb\x22\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22fmfJsc\x22 class\x3d\x22XAOBve\x22\x3e\x3cg-img class\x3d\x22ZGomKf\x22 style\x3d\x22height:120px;width:120px;background-color:#273D1C\x22\x3e\x3cimg data-src\x3d\x22https://encrypted-tbn0.gstatic.com/images?q\x3dtbn:ANd9GcShTUMGRfmbbNpD3azI9HMWekD5R3JfeXSHT7j5YQWMVuYRXfDfS8hR\x26amp;s\x3d0\x22 src\x3d\x22data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw\x3d\x3d\x22 jscontroller\x3d\x22TSZEqd\x22 jsaction\x3d\x22load:K1e2pe;BUYwVb:eNYuKb;LsLGHf:KpWyKc;rcuQ6b:npT2md\x22 class\x3d\x22YQ4gaf\x22 height\x3d\x22120\x22 width\x3d\x22120\x22 alt\x3d\x22Farms near Auvers\x22\x3e\x3c/g-img\x3e\x3c/div\x3e\x3cdiv jsname\x3d\x22QUk9kd\x22 class\x3d\x22WGwSK cyKJce\x22\x3e\x3cdiv class\x3d\x22dAassd\x22\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eFarms near \x3c/div\x3e\x3cdiv jsname\x3d\x22T3JDGc\x22 class\x3d\x22FozYP\x22\x3eAuvers\x3c/div\x3e\x3cdiv class\x3d\x22cp7THd\x22\x3e\x3cdiv class\x3d\x22FozYP\x22\x3e1890\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e\x3c/div\x3e")
        enc = x.encoding

        puts CGI.unescapeHTML(x)
        exit
        results = item_html

        puts results
      end

    end


    results

  end
end