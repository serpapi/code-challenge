require './lib/google_search'

begin
    puts 'Program is starting successfully'

    file = File.open('./files/van-gogh-paintings.html')

    google_search = GoogleSearch.new
    artworks = google_search.get_artworks(file)
    File.write('./artworks.json', JSON.pretty_generate({
        artworks: artworks
    }))
    puts 'Program is finishing successfully'
rescue => e
    puts "Program is finish with error #{e.message}"
end