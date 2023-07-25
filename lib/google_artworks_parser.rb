require 'nokolexbor'

class GoogleArtworksParser
  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def path=(new_path)
    if @path != new_path
      @path = new_path
      clear_memorized_values
    end
  end

  def get_html
    @html ||= File.open(@path).read
  end

  def get_images
    @images ||= extract_images
  end

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

  def doc
    @doc ||= Nokolexbor::HTML(get_html)
  end

  def extract_images
    image_ids = doc.css('.rISBZc, .taFZJe').map { |node| node['id'] }
    
    # https://regex101.com/r/l1bpke/1
    @images ||= image_ids.map do |image_id|
      match_data = get_html.scan(/var s='(data:image\/jpeg;base64,\S+)';var ii=\[\'#{image_id}\'\];/)
      match_data[0] ?  match_data[0][0].gsub('\\', '') : nil
    end
  end

  def clear_memorized_values
    @html = nil
    @images = nil
    @doc = nil
  end
end
