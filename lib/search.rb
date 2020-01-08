# frozen_string_literal: true

require 'json'
require 'nokogiri'

class Search
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def extract!
    page = Nokogiri::HTML(open(url))
    children = page.xpath("//g-scrolling-carousel//*[contains(@class, 'MiPcId')]").children

    children.map do |c|
      name = c['title']&.gsub(/\s\(\d+\)/, '')

      href = c['href'] || c.xpath('.//parent::a').first['href']
      link = ['https://www.google.com', href].join('/')

      img_node = c.xpath('.//g-img/img').first
      image = img_node['data-key'] || img_node['data-src'] || img_node['src']

      extensions = c.xpath(".//div[@class='ellip klmeta']").collect(&:text)

      {
        name: name,
        image: image,
        link: link,
        extensions: extensions
      }
    end
  end
end
