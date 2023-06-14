require_relative 'config/boot'
require_relative 'service/scraper'

class App < Sinatra::Base
  # Set the default content type for all responses to JSON
  before do
    content_type :json
  end

  # Application routes
  get '/scrape' do
    # Specify the URL to scrape
    url = File.join(__dir__, 'files', 'van-gogh-paintings.html')

    # Scrape the data
    scraped_data = Scraper.scrape_data(url)

    # return as the response
    scraped_data.to_json
  end
end