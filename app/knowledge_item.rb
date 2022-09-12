class KnowledgeItem
  attr_reader :html_element

  def initialize(html_element)
    @html_element = html_element
  end

  def to_h
    {
      name: name,
      extensions: extensions,
      link: link,
      image: image
    }
  end

  # private

  def name
    @html_element.attributes['aria-label'].value
  end

  def extensions
    @html_element.children.css('.klmeta').map(&:text)
  end

  def link
    @html_element.attributes['href'].value
  end

  def image
    @html_element.children.css('img').first['src']
  end
end