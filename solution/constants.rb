require 'uri'

module Constants
  GOOGLE_BASE_URL = 'https://google.com'

  FILE_URL = URI::File.build([nil, File.join(Dir.pwd, '/source_data', 'van-gogh-paintings.html')])
end

