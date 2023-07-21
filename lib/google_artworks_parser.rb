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

  def html
    @html ||= File.open(@path).read
  end

  def images
    # https://regex101.com/r/qmmOX0/1
    @images ||= html.scan(/var s='(data:image\/jpeg;base64,\S+)';/).map { |image| image[0].gsub('\\', '') }
  end

  def artworks
    doc = Nokolexbor::HTML(html)

    artworks = []
    doc.css('.DAVP1 .MiPcId').each_with_index do |artwork, index|
      name = artwork.css('a').attr('aria-label')
      link = "https://www.google.com#{artwork.css('a').attr('href')}"
      extensions = artwork.css('.ellip').map(&:text)

      if extensions.empty?
        artworks << {
          name: name,
          link: link,
          image: images[index]
        }
      else
        artworks << {
          name: name,
          extensions: extensions,
          link: link,
          image: images[index]
        }
      end
    end

    { artworks: artworks }
  end

  private

  def clear_memorized_values
    @html = nil
    @images = nil
  end
end