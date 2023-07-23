require 'nokogiri'

class GoogleCarousel
  def initialize(html)
    @page = Nokogiri.HTML5(html)
    @image_src_script = @page.at_css('script:contains(\'_setImagesSrc\')').text
  end

  def items
    @page.css('.kappbar g-scrolling-carousel a').map { |a| item(a) }
  end

  private

  def item(a)
    {}.tap do |h|
      h['name'] = a.at_css('.kltat').text.strip
      meta_els = a.css('.klmeta')
      h['extensions'] = meta_els.map { |el| el.text.strip } if meta_els.any?
      h['link'] = "https://www.google.com#{a['href']}"
      h['image'] = item_image_src(a.at_css('img')&.[]('id'))
    end
  end

  def item_image_src(id)
    return nil if id.nil?
    index = @image_src_script.index(id)
    return nil if index.nil?
    data_start = @image_src_script.rindex('data:image', index)
    data_end = @image_src_script.index('\'', data_start)
    @image_src_script[data_start...data_end].gsub('\\', '')
  end
end
