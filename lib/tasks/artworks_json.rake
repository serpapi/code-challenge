require './lib/services/artwork_creator'

task :van_gogh do
  ArtworkCreator.new('lib/files/van-gogh-paintings.html', 'lib/files/van-gogh.json').to_json_file
end

task :picasso do
  ArtworkCreator.new('lib/files/picasso-paintings.html', 'lib/files/picasso.json').to_json_file
end

task :mark_twain do
  ArtworkCreator.new('lib/files/mark-twain-books.html', 'lib/files/mark-twain.json').to_json_file
end
