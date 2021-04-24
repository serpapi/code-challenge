load "van-gogh-class.rb"
require 'rspec/autorun'

testing_batch={"batch"=>[{"query"=>"Van Gogh paintings","path"=>'files/van-gogh-paintings.html'},
{"query"=>"Da Vinci Paintings","path"=>'files/da-vinci-paintings.html'},
{"query"=>"Books of 2021","path"=>'files/books-of-2021.html'},
{"query"=>"Sinatra albums","path"=>'files/sinatra-albums.html'}]}
testing_batch['batch'].each do |result|
    link=result['path']
    query=result['query']
    describe "Checking query \'#{query}\' with filepath \'#{link}'\ ..." do
        artworks=Scrape.execute(link)
        if link == "code-challenge/files/van-gogh-paintings.html"
            it "checks if the solution files are same" do
                artworks=Scrape.execute(link)
                expect(File.read("solution.json")).to eq(File.read("code-challenge/files/expected-array.json"))
            end
        end
        artworks['artworks'].each do |artwork|
            describe "Checking for #{artwork['name']}" do
                it "Checks for name" do
                    expect(artwork['name'].is_a? String)
                end
                it "Checks for link" do
                    expect(artwork['link'].is_a? String)
                end
                it "Checks for image base64" do
                    expect(artwork['link'].is_a? String)
                end
                unless artwork['extensions'].nil?
                    it "Checks for extensions" do
                        expect(artwork['extensions'].is_a? Array)
                    end
                end
            end
        end
    end
end
