require_relative 'paintings'
require 'json'

module Challenge
  
  def self.main(argv)
    puts( JSON.pretty_generate( Paintings::paintings(argv[0] || 'files/van-gogh-paintings.html') ) )
  end
end

Challenge::main(ARGV)