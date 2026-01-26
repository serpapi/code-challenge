class CarouselItemExtractor
  def initialize(raw_html)
    @raw_html = raw_html
    @image_cache = nil
  end

  def extract(link)
    name = extract_name(link)
    return nil if name.nil? || is_action_text?(name)

    {
      name: name,
      extensions: extract_extensions(link, name),
      link: link['href']&.start_with?('http') ? link['href'] : "https://www.google.com#{link['href']}",
      image: extract_image(link)
    }.compact
  end

  def carousel_item_link?(link)
    href = link['href'].to_s
    return false if href.empty? || is_action_text?(link.text)
    return false unless href.include?('stick=')

    has_visual = link.at_css('img') || link.at_css('[role="heading"]')
    has_label = link['aria-label'] && !link['aria-label'].strip.empty?
    has_text = link.text && !link.text.strip.empty?

    has_visual || has_label || has_text
  end

  private

  def extract_name(link)
    candidates = []

    heading = link.at_css('[role="heading"]')
    candidates << heading.text if heading && !heading.text.strip.empty?

    candidates << link['aria-label'] if link['aria-label']

    img = link.at_css('img[alt]')
    candidates << img['alt'] if img && img['alt'] && !img['alt'].empty?

    candidates << link['title'] if link['title']

    title_el = link.at_css('.JjtOHd')
    candidates << title_el.text if title_el

    pg_el = link.at_css('.pgNMRc')
    candidates << pg_el.text if pg_el

    direct_text = link.children.select(&:text?).map { |n| n.text.strip }.reject(&:empty?).first
    candidates << direct_text if direct_text

    candidates.each do |text|
      cleaned = clean_text(text)
      next if cleaned.empty? || is_year?(cleaned)

      return cleaned
    end

    link.traverse do |node|
      next unless node.text?

      cleaned = clean_text(node.text)
      next if cleaned.empty? || is_year?(cleaned)

      return cleaned
    end

    nil
  end

  def extract_extensions(link, name)
    extensions = []

    text_nodes = link.xpath('.//text()').map { |node| clean_text(node.text) }.reject(&:empty?).uniq
    text_nodes.each do |text|
      next if is_action_text?(text)
      next if name && clean_text(name) == text
      extensions << text unless text.empty? || extensions.include?(text)
    end

    link.css('.ellip, .cxzHyb').each do |el|
      text = clean_text(el.text)
      extensions << text unless text.empty? || extensions.include?(text)
    end

    if extensions.empty?
      link.traverse do |node|
        next unless node.text?

        text = node.text.strip
        if text.match?(/\A\d{4}\z/) && text.to_i.between?(1000, 2100)
          extensions << text unless extensions.include?(text)
        end
      end
    end

    extensions.uniq
  end

  def extract_image(link)
    img = link.at_css('img')
    return nil unless img

    src = img['src'].to_s
    data_src = img['data-src'].to_s

    if src.start_with?('data:image/jpeg', 'data:image/png', 'data:image/webp')
      return src
    end

    if src.start_with?('https://encrypted-tbn', 'http://encrypted-tbn')
      return src
    end

    if data_src.start_with?('data:image/jpeg', 'data:image/png', 'data:image/webp')
      return data_src
    end

    if data_src.start_with?('https://encrypted-tbn', 'http://encrypted-tbn')
      return data_src
    end

    if img['id'] && (img['data-deferred'] || src.include?('gif;base64'))
      @image_cache ||= build_image_cache
      deferred = @image_cache[img['id']]
      return deferred if deferred
    end

    if src.include?('gstatic.com/knowledgecard/') && src.end_with?('.png')
      return src.start_with?('//') ? "https:#{src}" : src
    end

    if data_src.include?('gstatic.com/knowledgecard/') && data_src.end_with?('.png')
      return data_src.start_with?('//') ? "https:#{data_src}" : data_src
    end

    nil
  end

  def build_image_cache
    cache = {}
    @raw_html.scan(/\(function\(\)\{var s='(data:image\/[^']+)';var ii=\[([^\]]+)\]/) do |match|
      base64_image = match[0]
      ids_string = match[1]
      ids_string.scan(/'([^']+)'/).flatten.each do |id|
        cache[id] = base64_image
      end
    end
    cache
  end

  def clean_text(text)
    text.to_s.gsub(/\s+/, ' ').strip
  end

  def is_action_text?(text)
    normalized = clean_text(text).downcase
    normalized == 'show more' || normalized == 'see more' || normalized == 'more'
  end

  def is_year?(text)
    text.match?(/\A\d{4}\z/) && text.to_i.between?(1000, 2100)
  end
end
