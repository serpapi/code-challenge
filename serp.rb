require "nokolexbor"
require "open-uri"
require "uri"

def get_serp_for_file(file_name, main_json_key)
  raise "Parser requires HTML files" unless file_name.end_with? ".html"

  file_path = File.join(__dir__, "files", file_name)

  raise "File not found: #{file_path}" unless File.file? file_path

  output_json = {
    main_json_key => get_json_from_html(File.read(file_path))
  }

  output_json
end

def get_image_lookup_dict(input_html)
  cur_script_list = input_html.xpath('//script[contains(text(), "_setImagesSrc(")]')
  cur_regex = /\(function\(\){var s='([^']+)';var ii=\['([^']+)'\];_setImagesSrc\(ii,s\);}\)\(\);/

  image_lookup_dict = {}

  cur_script_list.each do |cur_script|
    work_dict = cur_script.to_html.scan(cur_regex).to_h.invert
    next if work_dict.empty?

    raise "Unusual script tag detected" if work_dict.empty?
    image_lookup_dict.merge! work_dict
  end

  image_lookup_dict
end

def get_extensions_list(input_element)
  while input_element.next_sibling.nil?
    input_element = input_element.parent
  end

  output_list = []
  sibling_children = input_element.next_sibling.children

  input_element.next_sibling.children.each do |cur_child|
    # handle old google layout
    if cur_child.children[0].name != "div"
      output_list << cur_child.text
      next
    end

    # handle new google layout
    cur_child.children.each do |grand_child|
      grand_child.children.each do |great_grand_child|
        output_list += great_grand_child.children.map(&:text)
      end
    end
  end

  output_list
end

def get_json_from_html(raw_html, cur_domain = "https://www.google.com/")
  cur_html = Nokolexbor::HTML(raw_html)

  image_lookup_dict = get_image_lookup_dict(cur_html)

  extrabar_carousels = cur_html.css("#extabar g-scrolling-carousel")
  raise "Unexpected number of carousels found in extrabar" unless extrabar_carousels.length == 1

  cur_links = extrabar_carousels[0].css("a")
  raise "No links were found in carousel" if cur_links.empty?

  cur_items = []

  cur_links.each_with_index do |cur_link, cur_index|

    cur_item = {}

    cur_link_url = cur_link["href"]

    cur_item_link = URI.join(cur_domain, cur_link_url).to_s

    cur_item_link = cur_item_link.gsub("%27", "'") # unencode single quote character

    if cur_link.children.empty?
      # google now lazy loads children inside links

      cur_item["name"] = cur_link["aria-label"]
      cur_item["link"] = cur_item_link
      cur_item["image"] = nil

      cur_items << cur_item
      next
    end

    cur_image_list = cur_link.css("img")

    raise "Unexpected number of images found in carousel item" unless cur_image_list.length == 1

    cur_image = cur_image_list[0]

    cur_image_url = image_lookup_dict[cur_image["id"]]

    unless cur_image_url.nil?
      cur_image_url = cur_image_url.gsub("\\x", "x")
    end

    cur_extensions = get_extensions_list cur_image

    cur_item["name"] = cur_extensions.shift

    unless cur_extensions.empty?
      cur_item["extensions"] = cur_extensions
    end

    cur_item["link"] = cur_item_link

    cur_item["image"] = cur_image_url

    cur_items << cur_item
  end

  cur_items
end
