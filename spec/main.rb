require 'nokogiri'
require 'pry'

puts "hey"

class GoogleImageCard
  attr_reader :name, :link, :image, :extensions

  def initialize(params)
    @name = params[:name]
    @link = params[:link]
    @image = params[:image]&.gsub('\\x3d', 'x3d')
    @extensions = params[:extensions]
  end

  def to_h
    image_card_hash = { name: name, link: link, image: image }
    image_card_hash[:extensions] = extensions unless extensions.empty?
    image_card_hash
  end
end

class GoogleParser
  DEFAULT_FILE_PATH = '../files/van-gogh-paintings.html'.freeze

  attr_reader :search_image_items

  def initialize(path = DEFAULT_FILE_PATH)
    @path = path
    @search_image_items = []
  end

  def parse
    klitems.each.with_index do |each_image_item, idx|
      @search_image_items << GoogleImageCard.new(
        name: each_image_item.attr('aria-label'),
        extensions: select_extensions(each_image_item),
        link: link(each_image_item.attr('href')),
        image: each_image_item.at_css('g-img img').attr(:src) ? images[idx] : nil
      )
    end
  end

  private

  def klitems
    document.css('a.klitem') + document.css('a.klitem-tr')
  end

  def select_extensions(node)
    legacy_select = node.css('.klmeta')
    return legacy_select.map(&:text) unless legacy_select.empty?

    node = node.children.last until node.nil? || node.text?
    return [] if node.nil?

    node.parent.children.map(&:text)
  end

  def link(href)
    "https://www.google.com#{href}"
  end

  def document
    file = File.open(@path)
    @document ||= Nokogiri::HTML(file.read)
  ensure
    file.close
  end

  def images
    @search_image_items ||= document.content.scan(%r{var s='(data:image/jpeg;base64,\S+)';}).map { _1[0] }
  end
end



# binding.pry




































































# files = ['files/van-gogh-paintings.html', 'files/picasso-paintings.html', 'files/claude-paintings.html']

# def parse_from_file(filename)
#   doc = Nokogiri::HTML(open(filename).read)

#   script = doc.search('script').select { |s| s.to_s.index('setImagesSrc') }
#   matches = script.to_s.scan(/var s='([^']+)';var ii=\['([^']+)'\];_setImagesSrc\(ii,s\);/)

#   payload_h = {}
#   matches.each do |payload, klass|
#     payload_h[klass] = payload.gsub('\\\\', '') 
#   end

#   results = []
#   (doc.search('a.klitem').to_a + doc.search('a.klitem-tr')).to_a.each do |a|
#     id = a.at('img')&.[]('id')
#     extensions = [a.at('.klmeta')&.text].compact
#     result = {
#       'name' => a['aria-label'],
#       'image' => payload_h[id],
#       'link' => 'https://www.google.com' + a['href'],
#     }
#     unless extensions.empty?
#       result['extensions'] = extensions
#     end
#     results << result
#   end

#   results
# end

# def save_image(payload)
#   decoded = Base64.decode64(payload.delete_prefix('data:image/jpeg;base64,'))
#   File.open('test.jpeg', 'wb') { |f| f.write(decoded) }
# end

# def verify_paintings
#   truth = JSON.parse(open('files/expected-array.json').read)
#   payload = JSON.parse(open('files/van-gogh-paintings.json').read)

#   truth['knowledge_graph']['artworks'] == payload
# end

# puts verify_paintings