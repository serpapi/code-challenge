class CarouselCardWrapper
  TITLE_SELECTOR = 'div.kltat'.freeze
  EXTENTION_SELECTOR = 'div.klmeta'.freeze
  LINK_SELECTOR = 'a.klitem'.freeze

  def initialize(card, file_content)
    @card = card
    @file_content = file_content
  end

  def perform
    {
      title: title,
      extentions: extentions,
      link: link,
      image: image
    }
  end

  def title
    @card.css(TITLE_SELECTOR).text
  end

  def extentions
    extentions = []
    @card.css(EXTENTION_SELECTOR).each do |meta|
        extentions << meta.content
    end
    return extentions
  end

  def link
    href = @card.css(LINK_SELECTOR).first['href']

    if href[0, 'https://www.google'.length] == 'https://www.google'
      href
    else
      'https://www.google.com' + href
    end
  end

  def image
    image_id = @card.at_css('img').attr('id')
    return @file_content[image_regex(image_id)]&.gsub('\\', '')
  end

  def image_regex(id)
    /(?<=var ii=\['#{id}'\];_setImagesSrc\(ii,s\);\}\)\(\)\;\(function\(\)\{var s=\')[^']+(?<!';var)/
  end
end

