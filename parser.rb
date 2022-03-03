require 'nokogiri'

class Parser
  attr_reader :parsed_data

  def initialize(html_doc)
    @html_doc = html_doc
    @parsed_data = []
  end

  def parse
    @html_doc.search('div.MiPcId.klitem-tr.mlo-c').each do |painting_box|
      name = painting_name painting_box
      extensions = painting_extensions painting_box
      link = painting_link painting_box
      image = painting_img painting_box

      @parsed_data << { name: name, extensions: extensions, link: link, image: image }
    end
  end

  private

  def painting_name(d)
    d.search('div.kltat').first.nil? ? nil : d.search('div.kltat').first.content
  end

  def painting_extensions(d)
    d.search('div.ellip.klmeta').first.nil? ? nil : d.search('div.ellip.klmeta').first.content.split(' ')
  end

  def painting_link(d)
    "https://www.google.com#{d.search('a').first['href']}"
  end

  def painting_img(d)
    d.search('img').attr('src').nil? ? nil : d.search('img').attr('src').value
  end
end
