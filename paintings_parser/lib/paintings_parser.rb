require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'json'
require 'nokogiri'

class PaintingsParser
  include Capybara::DSL
  @@prepared = false

  attr_reader :path

  def initialize(path)
    raise missing_file(path)  unless File.exists?(path)
    raise invalid_file_format unless html_file?(path)

    @path = path
  end

  def self.create_parser_for(path)
    unless @@prepared
      PaintingsParser.prepare
      @@prepared = true
    end
    PaintingsParser.new(path)
  end

  def parse
    visit(path)
    result = {}
    result[:artworks] = parse_paintings()
    JSON.pretty_generate(result)
  end

  private

  def self.prepare
    Capybara.default_driver = :poltergeist
    Capybara.run_server = false
  end


  def html_file?(path)
    File.extname(path) == ".html"
  end

  def invalid_file_format
    ArgumentError.new("Unsupported file format. Please provide an html file.")
  end

  def missing_file(path)
    ArgumentError.new("Invalid path. The file '#{path}' does not exists.")
  end

  def parse_paintings
    results_nodes.map {|node| parse_painting(node) }
  end

  def results_nodes
    doc = Nokogiri::HTML(page.html)
    doc.css('a.klitem')
  end

  def parse_painting node
    painting = {}
    painting[:name] = parse_name(node);
    painting[:extensions] = parse_date(node);
    painting[:link] = parse_link(node);
    painting[:image] = parse_img(node);
    painting
  end

  def parse_name node
    node['aria-label']
  end

  def parse_date node
    meta = node.css('div.klmeta')
    date = meta.length > 0 ? meta[0]&.content : nil
    [date]
  end

  def parse_link node
    "https://www.google.com#{node['href']}"
  end

  def parse_img node
    img = node.css('div.klic > g-img > img')
    if img.length > 0
      img[0]['src']
    end
  end
end
