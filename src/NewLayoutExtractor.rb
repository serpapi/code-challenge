require_relative 'MainLayoutExtractor'

class NewLayoutExtractor < MainLayoutExtractor

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
