require_relative 'lib/FileManager'
require_relative 'lib/HtmlDocument'
require_relative 'lib/ArtworkExtractor'



puts "Please enter the number for below options:\n 1. Van Gogh\n 2. Picasso\n 3. Da Vinci"

number = gets.chomp

if number == '1'
  file_path = "files/van-gogh-paintings.html"
  output_path = "files/new-van-gogh-paintings.json"
elsif number == '2'
  file_path = "files/picasso-paintings.html"
  output_path = "files/new-picasso-paintings.json"
elsif number == '3'
  file_path = "files/da-vinci-paintings.html"
  output_path = "files/new-da-vinci-paintings.json"
else
  puts "Please enter a valid number"
end



html_content = FileManager.read_file(file_path)
html_doc = HtmlDocument.new(html_content)
artworks = []

html_doc.carousel.each do |painting_element|
  extractor = ArtworkExtractor.new(painting_element)
  
  if extractor.check_artwork
    painting = Artwork.new(
      name: extractor.name,
      link: extractor.link,
      image: extractor.image,
      extensions: extractor.extensions
    )

    artworks << painting.to_hash
  end
end


FileManager.write_to_file(output_path, artworks)
