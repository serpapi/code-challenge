require './lib/services/artwork_creator'

task :artworks_json do
  ArtworkCreator.new('lib/files/van-gogh-paintings.html').to_json_file
end
