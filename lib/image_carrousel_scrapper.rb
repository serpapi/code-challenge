# frozen_string_literal: true

require 'json'

class ImageCarrouselScrapper
  attr_reader :driver, :file

  def initialize(driver:, file:)
    @driver = driver
    @file = file
  end

  def result(format: :json)
    case format
    when :json
      JSON.pretty_generate(data)
    else
      data
    end
  end

  private

  def data
    @data ||= carrousel_list.each_with_object({ "artworks": [] }) do |item, buff|
      buff[:artworks] << item.to_h.slice(:image, :link, :name).tap do |value|
        value[:extensions] = item.extensions if item.extensions
      end
    end
  end

  def carrousel_list = html_content.carrousel_list

  def html_content = @html_content ||= driver.new(file)
end

