require "uri"

# Represents a single image result, built from a DOM node.
class ImageResultEntry
  def initialize(node)
    @name = node.attribute("aria-label")
    @link = remote_url(node.attribute("href"))
    @image = node.find_element(css: "g-img img").attribute("src")

    begin
      @extensions = [ node.find_element(css: ".klmeta").text ]
    rescue Selenium::WebDriver::Error::NoSuchElementError
      nil
    end
  end

  def as_json
    result = {
      name: @name,
      link: @link,
      image: @image,
      extensions: @extensions
    }

    result.delete(:extensions) if @extensions.nil?
    result
  end

  private

  # Because we're loading a local file with a file:// URL, chomedriver reports
  # them as relative to the local file.  Adjust file://... to https://www.google.com/...
  def remote_url(path)
    url = URI(path)
    url.scheme = "https"
    url.host = "www.google.com"
    url.to_s
  end
end
