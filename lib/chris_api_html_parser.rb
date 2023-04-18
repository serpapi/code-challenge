# frozen_string_literal: true

require 'nokogiri'
require 'uri'

module ChrisApiHtmlParser
  # Parses a search results page. This implementation seems to support far fewer
  # features than the SerpAPI. But, that seems to be ok, for the point of this
  # evaluation.
  #
  # NOTE: We parse strings here, as opposed to files, under the assumption that
  # 'in production' we'll be network io, and not files
  class KnowledgeGraph
    def initialize(html_as_s)
      @html = Nokogiri::HTML html_as_s
    end

    # I'm not confident that this will parse across other samples. But, since
    # my sample size is one, I'm leaving it this way...
    def title
      @html.xpath('//div[@id="kx"]//*[@class="ravrDc"]//*/span[1]/text()').map(&:to_s).first
    end

    def image
      carrousel.first.xpath('.//img').first['src']
    end

    def description
      synopsis_card.at('./span[1]/text()').to_s
    end

    def source
      a = synopsis_card.at('./span[2]/a')
      { 'name' => a.text, 'link' => a['href'] }
    end

    def born
      synopsis_attr 'Born'
    end

    def died
      synopsis_attr 'Died'
    end

    def periods
      synopsis_attr 'Periods'
    end

    # It probably makes more sense to search for b tags in the the search results, that
    # correspond to highlights from wiki results. But, I budgeted four hours for this,
    # and my sample size is only 'one'...
    def education
      @html.at('//*[b[text()="Education"]]/a/text()').to_s
    end

    def artworks
      carrousel.map do |c|
        a = c.at './a[1]'

        { 'name' => a['aria-label'],
          'link' => ['https://www.google.com', a['href']].join,
          # NOTE: This property is 'incorrect' as currently written, since javascript
          # is overwriting this value at runtime, in the dom, and the html we're using
          # doesn't execute javascript. (And parsing the javascript seems ... comparatively futile)
          'image' => a.at('img')['src'],
          # I'm pretty sure this is about right. Tough to tell with a sample size of one
          'extensions' => a.xpath('div[last()]/div/text()').map(&:text) }
      end
    end

    private

    def carrousel
      @html.xpath('//div[@id="kx"]//div[contains(@class,"MiPcId")]')
    end

    def synopsis_card
      @html.at('//div[h3[text()="Description"]]')
    end

    def synopsis_attr(name)
      @html.at(format('//*[a[text()="%s"]]/../span[2]', name)).text
    end

  end

end
