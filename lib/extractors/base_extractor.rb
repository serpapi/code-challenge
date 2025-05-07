# frozen_string_literal: true

require 'ostruct'
# BaseExtractor provides a flexible interface for extracting artworks from HTML carousels.
class BaseExtractor
  GALLERY_ATTRID = nil

  attr_accessor :doc, :container

  def initialize(doc)
    @doc = doc
    @container = container_selector ? doc.at_css(container_selector) : doc
  end

  def extract
    return [] unless container

    containers
      .map { |item_div| extract_entry(item_div) }
      .compact
      .select { |entry| valid_entry?(entry) }
      .map { |entry| OpenStruct.new(entry).to_h }
  end

  def containers
    @containers ||= container.css(item_selector)
  end

  def extract_entry(item_div)
    a_tag = item_div.at_css('a')
    return nil unless a_tag

    {
      'name' => extract_name(item_div),
      'extensions' => extract_extensions(item_div),
      'link' => extract_link(a_tag),
      'image' => extract_image(a_tag)
    }
  end

  def extract_name(item_div)
    selectors = selectors_config['name']
    node = item_div.at_xpath(selectors['xpath']) || item_div.at_css(selectors['css'])
    node&.text&.strip || ''
  end

  def extract_extensions(item_div)
    selectors = selectors_config['extensions']
    node = item_div.at_xpath(selectors['xpath']) || item_div.at_css(selectors['css'])
    year = node&.text&.strip
    year ? [year] : []
  end

  def extract_link(a_tag)
    selectors = selectors_config['link']
    link = begin
      a_tag.at_xpath(selectors['xpath'])&.text
    rescue StandardError
      nil
    end
    link = a_tag['href'] if link.nil? || link.empty?
    return '' unless link

    if link.start_with?('http')
      link
    else
      ((defined?(GOOGLE_SEARCH_BASE_URL) ? GOOGLE_SEARCH_BASE_URL : 'https://www.google.com') + link)
    end
  end

  def extract_image(a_tag)
    selectors = selectors_config['image']
    src = begin
      a_tag.at_xpath(selectors['xpath'])&.text
    rescue StandardError
      nil
    end
    if src.nil? || src.empty?
      img_tag = a_tag.at_css(selectors['css'])
      src = img_tag&.attribute('src')&.to_s || img_tag&.attribute('data-src')&.to_s
    end
    src || ''
  end

  def valid_entry?(entry)
    entry['name'] && !entry['name'].empty? && entry['link'] && !entry['link'].empty?
  end

  def selectors_config
    require 'yaml'
    return @selectors_config if defined?(@selectors_config) && @selectors_config

    config_path = self.class.const_defined?(:SELECTORS_CONFIG_PATH) ? self.class::SELECTORS_CONFIG_PATH : nil
    @selectors_config = if config_path && File.exist?(config_path)
                          YAML.load_file(config_path)
                        else
                          {
                            'name' => { 'xpath' => nil, 'css' => '.JjtOHd' },
                            'extensions' => { 'xpath' => nil, 'css' => '.ellip.yF4Rkc.AqEFvb' },
                            'link' => { 'xpath' => nil, 'css' => 'a' },
                            'image' => { 'xpath' => nil, 'css' => 'img' }
                          }
                        end
    @selectors_config
  end

  def container_selector
    (selectors_config['container_selector'] && selectors_config['container_selector']['css']) || "div[data-attrid='#{GALLERY_ATTRID}']"
  end

  def item_selector
    (selectors_config['item_selector'] && selectors_config['item_selector']['css'])
  end
end
