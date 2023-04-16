# frozen_string_literal: true

class Painting
  attr_reader :doc, :node
  def initialize(doc, node)
    @doc = doc
    @node = node
  end

  def id
    node.css('img').first.attribute('id').value
  end

  def name
    node.attribute('aria-label').value
  end

  def extensions
    date = node.css('.klmeta').text

    date == "" ? nil : [date]
  end

  def link
    @link ||= "https://www.google.com#{node.attribute('href').value}"
  end

  # I'm so, so sorry
  # https://i.imgur.com/gOPS2.png
  # (Tho technically this isn't matching the markup so maybe we won't summon Zalgo?)
  def img_src
    previous_id = "kximg#{id.gsub(/[^0-9]/, '').to_i-1}"
    matchdata =
      if id == 'kximg0'
        doc.text.match(/\(function\(\){var s='(.*?)';var ii=\['kximg0'\];/)
      else
        doc.text.match(/var ii=\['#{previous_id}'\];_setImagesSrc\(ii,s\);}\)\(\);\(function\(\){var s='(.*?)';var ii=\['#{id}'\];/)
      end

    # matchdata is frustratingly nil instead of [] when no matches
    return unless matchdata

    match = matchdata[1]

    # Strip out some random backslashes to make it comply with expected-array.json
    match.gsub('\\', '')
  end

  def to_h
    # Weird structure because `image` must always be present even when nil,
    # but `extensions` should be left out entirely when empty
    hash = {
      name: name,
      link: link,
      image: img_src
    }

    hash[:extensions] = extensions if extensions

    hash
  end
end