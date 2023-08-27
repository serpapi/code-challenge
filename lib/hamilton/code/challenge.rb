# frozen_string_literal: true

require_relative "challenge/version"
require 'nokogiri'

module Hamilton
  module Code
    module Challenge
      def self.parse(e)
        puts e.child.attribute_nodes.select {|a| a.name == "aria-label"}[0].value
      end
      class Error < StandardError; end
      doc = File.open('files/van-gogh-paintings.html') { |f| Nokogiri::HTML(f) }
      carousel = doc.xpath("//g-scrolling-carousel")
      # TODO this navigation is brittle
      elements = carousel.children.first.children.first.children
      
      # TODO replace values w/ parse
      elements.each {|e| Challenge.parse(e)}

      #name
      #extensions array w/ date
      #link
      #thumbnail
    end
  end
end
