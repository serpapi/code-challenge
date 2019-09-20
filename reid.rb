require 'nokogiri'
require 'json'

#doc = Nokogiri::HTML(IO::read('files/bacon.html')).search('.klitem')
#doc = Nokogiri::HTML(IO::read('files/movies.html')).search('.klitem')
doc = Nokogiri::HTML(IO::read('files/van-gogh-paintings.html')).search('.klitem')

artworks = []

for klitem in doc do

    name = klitem['aria-label']
    link = klitem['href']
    ext = klitem.at('div.klmeta')
    img = klitem.at('img')['src']

    frag = {
        'name' => name,
        'link' => 'https://google.com' + link,
    }

    if ext
        frag['extensions'] = [ext.text]
    end

    frag['image'] = img

    artworks << frag

end

puts JSON.pretty_generate({'artworks'=>artworks})
