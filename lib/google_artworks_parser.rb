require 'nokolexbor'

class GoogleArtworksParser
  # Creates a new instance of GoogleArtworksParser with the specified path to the HTML file.
  #
  # @param path [String] The path to the HTML file containing Google Artworks data.
  def initialize(path)
    @path = path
  end

  # Gets the current path to the HTML file.
  #
  # @return [String] The current path to the HTML file.
  def path
    @path
  end

  # Sets a new path to the HTML file and clears memorized values if the new path is different from the current path.
  #
  # @param new_path [String] The new path to the HTML file.
  def path=(new_path)
    if @path != new_path
      @path = new_path
      clear_memorized_values
    end
  end

  # Reads and retrieves the HTML content from the specified path.
  #
  # @return [String] The HTML content of the file.
  def get_html
    @html ||= File.open(@path).read
  end

  # Extracts the images from the HTML content and caches them for subsequent calls.
  #
  # @return [Array<String>] An array of base64-encoded image strings.
  def get_images
    @images ||= extract_images
  end

  # Retrieves the Google Artworks data.
  #
  # @return [Hash] A hash containing the artworks data or an error message if no artworks are found.
  def get_results
    artworks = []

    if doc.css('.DAVP1 .MiPcId').any?
      artworks = get_old_artworks
    elsif doc.css('.Cz5hV .iELo6').any?
      artworks = get_new_artworks
    else
      return { error: "There are no artworks matching the specified criteria." }
    end

    { artworks: artworks }
  end

  private

  # Extracts and processes old version artworks data.
  #
  # @return [Array<Hash>] An array of hashes containing old version artworks data.
  def get_old_artworks
    old_artworks = []

    doc.css('.DAVP1 .MiPcId').each_with_index do |artwork, index|
      extensions = artwork.css('.ellip ::text').map(&:text)

      data = {}
      data[:name] = artwork.css('.kltat ::text')
      data[:extensions] = extensions unless extensions.empty?
      data[:link] = "https://www.google.com#{artwork.css('a').attr('href')}"
      data[:image] = get_images[index]

      old_artworks << data
    end

    old_artworks
  end

  # Extracts and processes new version artworks data.
  #
  # @return [Array<Hash>] An array of hashes containing new version artworks data.
  def get_new_artworks
    new_artworks = []

    doc.css('.Cz5hV .iELo6').each_with_index do |artwork, index|
      extensions = artwork.css('.cxzHyb ::text').map(&:text)

      data = {}
      data[:name] = artwork.css('.pgNMRc ::text')
      data[:extensions] = extensions unless extensions.empty?
      data[:link] = "https://www.google.com#{artwork.css('a').attr('href')}"
      data[:image] = get_images[index]

      new_artworks << data
    end

    new_artworks
  end

  # Parses the HTML content using Nokolexbor and caches the result for subsequent calls.
  #
  # @return [Nokolexbor::HTML::Document] The parsed Nokolexbor document.
  def doc
    @doc ||= Nokolexbor::HTML(get_html)
  end

  # Extracts and decodes the images from the HTML content.
  #
  # @return [Array<String>] An array of base64-encoded image strings.
  def extract_images
    image_ids = doc.css('.rISBZc, .taFZJe').map { |node| node['id'] }
    
    # https://regex101.com/r/l1bpke/1
    @images ||= image_ids.map do |image_id|
      match_data = get_html.scan(/var s='(data:image\/jpeg;base64,\S+)';var ii=\[\'#{image_id}\'\];/)
      match_data[0] ?  match_data[0][0].gsub('\\', '') : nil
    end
  end

  # Clears the cached values for HTML content, images, and the parsed document.
  def clear_memorized_values
    @html = nil
    @images = nil
    @doc = nil
  end
end
