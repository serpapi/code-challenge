require "pry_wrench/version"
require "pry_wrench/constants"
require "pry_wrench/config"

require 'json'

module PryWrench

  def self.extract_data(json_string)

    json_obj = JSON.parse(json_string)

    binding.pry

    output = [
      json_obj['data']
    ]
  end


  # def self.process_html(html_string)
  #   doc = Nokogiri
  # end

  def self.main
    "test"
  end

  def self.help
    msg = <<-EOF
pry_wrench
TODO: Update this to be correct to this tool!
Commands:
  ls           - List things
  run          - Run things
  status       - Show status
EOF
  end

end
