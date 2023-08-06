# frozen_string_literal: true

module Google
  class SearchService
    URL = 'https://www.google.com/search'
    MAP = [
      { element: 'html', strategy: 'drill' },
      { element: 'head', strategy: 'skip' },
      { element: 'body', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'noscript', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'noscript', strategy: 'skip' },
      { element: 'style', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'span', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'script', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'script', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'style', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'h1', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'g-scrolling-carousel', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' }
    ]

    def paintings(search_text)
      list_service.split(
        drill_service.pick(body(search_text), MAP),
        'div'
      ).map do |item|
        painting_service.html_to_json(item)
      end
    end

    private

    def body(search_text)
      if Figaro.env.google_search_service_mock == 'true'
        File.read("#{Rails.root}/spec/fixtures/google_van_gogh_result.html")
      else
        response = connection.get('') do |request|
          request.params = {q: prepare_search_text(search_text)}
        end

        response.body
      end
    end

    def connection
      @connection ||=
        Faraday.new(url: URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
    end

    def prepare_search_text(text)
      text.gsub(' ', '+').gsub('%2B', '+').downcase
    end

    def drill_service
      @drill_service ||= DrillService.new
    end

    def list_service
      @list_service ||= ListService.new
    end

    def painting_service
      @painting_service ||= Google::PaintingService.new
    end
  end
end