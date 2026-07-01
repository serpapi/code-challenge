# frozen_string_literal: true

require "nokogiri"
require "uri"

class GoogleSearchParser
  def initialize(html)
    @document = Nokogiri::HTML(html)
  end

  def parse
    {
      answer_box: weather_answer_box,
      organic_results: organic_results
    }
  end

  private

  attr_reader :document

  def weather_answer_box
    weather_node = document.at_css("#wob_wc")
    return nil unless weather_node

    {
      type: :weather_result,
      temperature: weather_node.at_css("#wob_tm")&.text.to_s.strip,
      unit: weather_unit(weather_node),
      precipitation: weather_node.at_css("#wob_pp")&.text.to_s.strip,
      humidity: weather_node.at_css("#wob_hm")&.text.to_s.strip,
      wind: weather_node.at_css("#wob_ws")&.text.to_s.strip,
      location: weather_node.at_css("#wob_loc")&.text.to_s.strip,
      date: weather_node.at_css("#wob_dts")&.text.to_s.strip,
      weather: weather_node.at_css("#wob_dc")&.text.to_s.strip,
    }.compact
  end

  def organic_results
    document.css("#rso .MjjYud").filter_map.with_index(1) do |node, position|
      title_node = node.at_css("h3, h2, [role='heading']")
      link_node = node.at_css("a[href]")
      title = title_node&.text.to_s.strip
      link = normalize_link(link_node&.[]("href"))

      next if title.empty?

      {
        position: position,
        title: title,
        link: link,
        source: node.at_css(".VuuXrf")&.text.to_s.strip,
        snippet: node.at_css(".VwiC3b, .IsZvec")&.text.to_s.strip
      }.compact
    end
  end

  def weather_unit(weather_node)
    label = weather_node.at_css('.wob-unit span[aria-label*="Fahrenheit"]')&.[]("aria-label")
    return "Fahrenheit" if label&.include?("Fahrenheit")

    weather_node.at_css(".wob-unit .wob_t")&.text.to_s.strip
  end

  def normalize_link(href)
    return nil if href.nil? || href.empty?

    href
  end
end
