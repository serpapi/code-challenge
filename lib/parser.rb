# frozen_string_literal: true

class Parser
  def self.execute!(infile, outfile)
    new(infile, outfile).execute!
  end

  attr_reader :doc, :outfile

  def initialize(infile, outfile)
    # Docs say to preferentially use an IO object
    # instead of a string but when I did that I got
    # weird unicode issues
    @doc = Nokogiri::HTML(File.read(infile))
    @outfile = outfile
  end

  def execute!
    paintings = doc.css('.klbar .klitem')

    paintings = paintings.map { |p| Painting.new(doc, p).to_h }

    output = { artworks: paintings }

    File.write(outfile, JSON.pretty_generate(output))
  end
end
