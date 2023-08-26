# Given a SERP page, extract the artwork carousel and related data
class SerpArtworkExtractor

  def extract_artworks(document)
    image_base64_map = build_image_base64_map(document)
    artworks = []

    document.css('.klitem').each do |node|
      extensions = node.css('.klmeta').map {|meta_node| meta_node.inner_html}

      artworks.push({
        'name': node['aria-label'],
        'extensions': extensions.size > 0 ? extensions : nil,
        'link': 'https://www.google.com' + node['href'],
        'image': image_base64_map[node.xpath('.//img').first.attributes['id'].value]
      })
    end

    artworks
  end

  private

  # Build a map of image IDs to base 64 encoded image data by parsing <script> tags in the page
  def build_image_base64_map(document)
    map = {}
    document.inner_html.scan(/setImagesSrc.+?\'(.*?)\'.*?\'(\w+)/) {|image_data, id| map[id] = image_data.delete('\\')}
    map
  end
end