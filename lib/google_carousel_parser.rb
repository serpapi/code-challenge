require "nokogiri"
require "logger"

class GoogleCarouselParser
  BASE_URL = "https://www.google.com".freeze

  # Initializes the parser with HTML content and an optional Logger
  def initialize(html, logger = Logger.new($stdout))
    @doc = Nokogiri::HTML(html)
    @logger = logger
  end

  # Orchestrates the parsing workflow
  # @return [Hash] Structured artwork data
  def call
    hidden_images = parse_hidden_image_data
    if hidden_images.empty?
      @logger.warn("[GoogleCarouselParser] No hidden images found in the HTML.")
    end

    links = find_artwork_links
    if links.empty?
      @logger.warn("[GoogleCarouselParser] No artwork links found in the HTML.")
    end

    {
      "artworks" => build_artworks(links, hidden_images)
    }
  end

  private

  # Parses inline scripts to extract hidden image data
  # @return [Hash{id => decoded_data}]
  def parse_hidden_image_data
    @doc.xpath("//script").each_with_object({}) do |script, images_hash|
      text = script.text
      encoded = text[/var\s+s\s*=\s*'([^']+)'/, 1]
      id = text[/var\s+ii\s*=\s*\[\s*'([^']+)'/, 1]

      if encoded && id
        # Decode escaped hex sequences
        decoded = ("\"" + encoded + "\"").undump
        images_hash[id] = decoded
      end
    end
  end

  # Finds all <a> tags with image children that link to Google search
  # @return [Nokogiri::XML::NodeSet]
  def find_artwork_links
    @doc.xpath("//a[contains(@href,'/search?')][img]")
  end

  # Transforms link nodes into structured artwork hashes
  # @param links [Nokogiri::XML::NodeSet]
  # @param images_hash [Hash]
  # @return [Array<Hash>]
  def build_artworks(links, images_hash)
    links.map do |link|
      img = link.at_xpath("./img")
      year = link.xpath(".//text()").find { |n| n.text.strip =~ /^\d{4}$/ }

      {
        "name" => img["alt"].to_s.strip,
        "extensions" => year ? [year.text.strip] : nil,
        "link" => absolute_url(link["href"]),
        "image" => images_hash[img["id"]] || img["data-src"]
      }
    end
  end

  # Normalizes relative URLs into absolute ones
  # @param href [String]
  # @return [String]
  def absolute_url(href)
    href.start_with?("http") ? href : BASE_URL + href
  end
end
