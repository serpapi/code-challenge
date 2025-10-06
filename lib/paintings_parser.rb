# frozen_string_literal: true

require 'nokogiri'
require 'json'
require 'cgi'

class PaintingsParser
  def initialize(html_content)
    @html = html_content.force_encoding('UTF-8')
    @doc = Nokogiri::HTML(html_content)
  end

  def parse
    paintings = []
    seen_names = Set.new

    # extract paintings from json arrays in the html
    pattern_with_year = %r{\["([^"]+)","(\d{4})","(https://encrypted[^"]*)",\d+,\d+(?:,\[2,null,\["([^"]+)"\]\])?}
    pattern_without_year = %r{\["([^"]+)","","(https://encrypted[^"]*)",\d+,\d+(?:,\[2,null,\["([^"]+)"\]\])?}

    @html.scan(pattern_with_year).each do |match|
      name, year, thumbnail, alternative_name = match

      next if name.length < 3 || name.match?(/^http/i) || seen_names.include?(name)

      seen_names.add(name)

      link = extract_link_for_painting(name, alternative_name)
      paintings << build_painting_hash(name, year, thumbnail, link)
    end

    @html.scan(pattern_without_year).each do |match|
      name, thumbnail, alternative_name = match

      next if name.length < 3 || name.match?(/^http/i) || seen_names.include?(name)

      seen_names.add(name)

      link = extract_link_for_painting(name, alternative_name)
      paintings << build_painting_hash(name, '', thumbnail, link)
    end

    # fallback for different carousel layouts (movies, books)
    paintings.empty? ? parse_from_html_structure : paintings
  end

  private

  def build_painting_hash(name, year, thumbnail, link)
    {
      'name' => name,
      'extensions' => year.empty? ? [] : [year],
      'link' => link,
      'image' => thumbnail
    }
  end

  def extract_link_for_painting(name, alternative_name = nil)
    anchor = find_link_by_name(name)
    anchor ||= find_link_by_name(alternative_name) if alternative_name

    return '' unless anchor

    relative_url = anchor['href']
    relative_url.start_with?('http') ? relative_url : "https://www.google.com#{relative_url}"
  end

  def find_link_by_name(name)
    encoded_name = encode_for_google_url(name)

    # look for knowledge graph links (they have stick= parameter)
    @doc.css('a').find do |link|
      href = link['href']
      href&.include?("q=#{encoded_name}") && href.include?('stick=')
    end
  end

  def encode_for_google_url(text)
    # google uses + for spaces and doesn't encode some chars
    CGI.escape(text)
       .gsub('%20', '+')
       .gsub('%28', '(')
       .gsub('%29', ')')
       .gsub('%3A', ':')
       .gsub('%2C', ',')
  end

  def parse_from_html_structure
    # for pages where regex doesn't work, parse carousel elements from dom
    paintings = []

    @doc.css('g-scrolling-carousel a, div[data-hveid]').each do |item|
      name_elem = item.at_css('.pgNMRc, h3, .fYMiGb')
      next unless name_elem

      name = name_elem.text.strip
      next if name.empty? || name.length < 3

      link_elem = item.name == 'a' ? item : item.at_css('a')
      link = link_elem ? link_elem['href'] : ''
      link = link.gsub('&amp;', '&') if link

      date_elem = item.at_css('.ellip, .YrbPuc, .OSrXXb')
      year = date_elem&.text&.match(/\d{4}/)&.to_s

      img_elem = item.at_css('img')
      thumbnail = img_elem ? (img_elem['src'] || img_elem['data-src']) : ''

      paintings << {
        'name' => name,
        'extensions' => year ? [year] : [],
        'link' => link,
        'image' => thumbnail
      }
    end

    paintings
  end
end
