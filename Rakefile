# frozen_string_literal: true

require 'rake'

namespace :artwork do
  desc 'Extract artworks from an input HTML file. Usage: rake artwork:extract[INPUT]'
  task :extract, [:input] do |_t, args|
    input_file = args[:input] || 'files/da-vinci-paintings.html'
    script = File.expand_path('scripts/extract_artwork_details.rb', __dir__)
    sh "ruby #{script} --input #{input_file}"
  end
end
