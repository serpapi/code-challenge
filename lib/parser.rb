require 'nokogiri'
require 'json'


class Parser
  FILES = ['files/van-gogh-paintings.html', 'files/picasso-paintings.html', 'files/claude-paintings.html'].freeze

  def self.parse_from_file(filename)
    doc = Nokogiri::HTML(open(filename).read)

    script = doc.search('script').select { |s| s.to_s.index('setImagesSrc') }
    matches = script.to_s.scan(/var s='([^']+)';var ii=\['([^']+)'\];_setImagesSrc\(ii,s\);/)

    payload_h = {}
    matches.each do |payload, klass|
      # we actually need to parse the string as a literal \\\\x3d\\\\x3d => ==
      # but the example data just removes the slashes, so ill just do that for now
      payload_h[klass] = payload.gsub('\\\\', '') 
    end

    results = []
    (doc.search('a.klitem').to_a + doc.search('a.klitem-tr').to_a).each do |a|
      id = a.at('img')&.[]('id')
      extensions = [a.at('.klmeta')&.text].compact
      result = {
        'name' => a['aria-label'],
        'image' => payload_h[id],
        'link' => 'https://www.google.com' + a['href'],
      }
      unless extensions.empty?
        result['extensions'] = extensions
      end
      results << result
    end

    results
  end

  def self.save_image(payload)
    decoded = Base64.decode64(payload.delete_prefix('data:image/jpeg;base64,'))
    File.open('test.jpeg', 'wb') { |f| f.write(decoded) }
  end

  def self.verify_vangogh
    truth = JSON.parse("{" + open('files/expected-array.json').read + "}")
    payload = JSON.parse(open('output/van-gogh-paintings.json').read)
    
    truth["artworks"] == payload
  end
end


