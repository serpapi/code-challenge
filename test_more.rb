require './crawler.rb'

[
    "files/ferrari-cars.html",
    "files/dupontel-movies.html",
    "files/klimt-peintures.html"
].each do |filename|
    sample_file = File.open(filename)
    crawler = ArtCrawler.new(sample_file&.read)
    crawler.run().each do |row|
        puts row['name']
        puts row['link']
        puts row['image'] ? row['image'].size: 0
        puts
    end
end
