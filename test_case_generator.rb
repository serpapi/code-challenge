require 'google_search_results'
require 'dotenv/load'
require 'json'
Dotenv.load

banksy_params = {
  q:"Banksy paintings",
  api_key:ENV['API_KEY'],
  no_cache:true,
}

shepard_fairey_params = {
  q:"Shepard Fairey paintings",
  api_key:ENV['API_KEY'],
  no_cache:true,
}

banksy_search = GoogleSearch.new(banksy_params)
shepard_fairey_search = GoogleSearch.new(shepard_fairey_params)

banksy_inline_images = banksy_search.get_hash[:inline_images]
shepard_fairey_inline_images = shepard_fairey_search.get_hash[:inline_images]

puts banksy_inline_images
puts shepard_fairey_inline_images
File.write('./files/banksy-expected-results.json',JSON.dump(banksy_inline_images))
File.write('./files/shepard-fairey-expected-results.json',JSON.dump(shepard_fairey_inline_images))

puts "Test cases generated"
