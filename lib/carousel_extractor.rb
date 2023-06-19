require 'nokolexbor'


module CarouselExtractor

  def get_carousel(html_content)
    doc = Nokolexbor::HTML(html_content)
    carousel_element = doc.at_css("g-scrolling-carousel")
  end

  def get_carousel_heading(carousel)
    common_ancestor = carousel.ancestors.find do |ancestor|
      ancestor.css('[aria-level="2"][role="heading"]').any?
    end

    if common_ancestor
      heading_element = common_ancestor.css('[aria-level="2"][role="heading"]')
      heading_text = heading_element.inner_text
      def extract_string(input)
        match = input.match(/.*([A-Z][a-z]*)/)
        match[1] if match
      end
      extract_string(heading_text)
    end
  end


  def get_carousel_content(carousel)
    carousel.css('a')
  end
end