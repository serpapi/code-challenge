require './lib/services/artwork_creator'

task :van_gogh do
  ArtworkCreator.new('lib/files/van-gogh-paintings.html', 'lib/files/van-gogh.json').to_json_file
end

task :picasso do
  ArtworkCreator.new('lib/files/picasso-paintings.html', 'lib/files/picasso.json').to_json_file
end
