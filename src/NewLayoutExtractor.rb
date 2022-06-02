require_relative 'MainLayoutExtractor'

class NewLayoutExtractor < MainLayoutExtractor
  # Example structure:
  # <a class="ct5Ked klitem-tr PZPZlf" aria-label="{name}" href="{link}" title="{title}">
  #    <div class="EsIlz klitem" tabindex="-1">
  #       <div >
  #          <div class="keP9hb"></div>
  #          <div class="XAOBve ZvGeOb">
  #             <g-img class="ZGomKf">
  #             	<img id="{image_id}" src="data:image/gif">
  #             </g-img>
  #          </div>
  #          <div class="WGwSK cyKJce">
  #             <div class="dAassd">
  #                <div jsname="T3JDGc" class="FozYP">{name}</div>
  #                <div class="cp7THd"><div class="FozYP">{extintion}</div></div>
  #                <div class="cp7THd FozYP">{extintion}</div>
  #             </div>
  #          </div>
  #       </div>
  #    </div>
  # </a>
  def extract_item_link(item)
    "https://www.google.com" + item['href']
  end

  def extract_item_attributes(item, html)
    attributes = super

    hidden_results = extract_hidden_results(item, html)

    if hidden_results.class != NilClass
      unless attributes[:extensions].kind_of?(Array)
        attributes[:extensions] = hidden_results[:extensions]
      end

      if attributes[:image].class == NilClass
        attributes[:image] = hidden_results[:image]
      end
    end


    attributes

  end

  def extract_item_extensions(item)
    extensions = Array.new

    item.css('.cp7THd').each do |extension|
      extensions.append(Nokogiri::HTML(extension.inner_html.gsub('>', '> ')).text.strip)
    end

    extensions
  end

  def extract_item_name(item)
    item.attributes['aria-label'].text
  end

  def extract_hidden_results(item, html)
    results = nil
    if item.attributes['id']
      id = item.attributes['id']
      re = /window.jsl.dh\('#{id}','(.*?)'/m

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
      end

    end

    results
  end
end
