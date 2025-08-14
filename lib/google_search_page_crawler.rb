require_relative 'google_search_page_crawler/parser'

class GoogleSearchPageCrawler
  attr_reader :agent

  def crawl(file_path)
    html = open(file_path).read
    parser = GoogleSearchPageCrawler::Parser.new(html)

    format_result(parser.parse)
  end

  private

  def format_result(result)
    # Here we decouple the Parser result data from the format we want to return.
    # I'm just returning a simple JSON output but we could expand this could be
    # implemented in a another class or using a builder.
    artworks = result.artworks.map do |artwork|
      json_response = {
        name: artwork.name,
        link: artwork.link,
        image: artwork.image
      }

      if artwork.extensions.any?
        json_response[:extensions] = artwork.extensions
      end

      json_response
    end

    JSON.pretty_generate({ artworks: })

  end
end