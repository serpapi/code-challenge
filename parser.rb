require 'strscan'
require 'cgi'

class Tokens
  OPENING_TAG = "OPENING_TAG"
  CLOSING_TAG = "CLOSING_TAG"
  SELF_CLOSING_TAG = "SELF_CLOSING_TAG"
  TEXT        = "TEXT"
  EOF         = "EOF"
end

Token = Struct.new(:type, :tag_name, :attributes)
Node = Struct.new(:tag_name, :attributes, :text, :children)

EMPTY_HASH = {}.freeze
EMPTY_ARRAY = [].freeze
VOID_ELEMENTS = %w[
  area base br col embed hr img input link meta param source track wbr
].each_with_object({}) { |el, h| h[el] = true }.freeze
TAG_NAME_REGEX = /[\w-]+/.freeze
KEY_REGEX = /[^\s=><\/]+/.freeze
WHITESPACE = /\s*/.freeze
QUOTE_REGEX = /["']/.freeze
SCRIPT_CLOSE_REGEX = %r{</script>}.freeze
STYLE_CLOSE_REGEX = %r{</style>}.freeze
EQUAL_SIGN = /=/.freeze
DOUBLE_QOUTE = /"/.freeze
SINGLE_QOUTE = /'/.freeze
ATTRIBUTE_VALUE = /[^\s><\/]*/.freeze
TEXT_SCANNER = /[^<]+/.freeze
OPENING_TAG_REGEX = /</.freeze
CLOSING_TAG_REGEX = />/.freeze
SELF_CLOSING_TAG_REGEX = %r{/>}.freeze
FORWARD_SLASH_REGEX = %r{/}.freeze
DOCTYPE_REGEX = /<!doctype\s+html\s*>/i.freeze

def parse_attributes(scanner)
  attributes ={}
  scanner.skip(WHITESPACE)

  until scanner.eos? || scanner.match?(/>|\/>/)
    key = scanner.scan(KEY_REGEX)
    break unless key

    scanner.skip(WHITESPACE)
    if scanner.scan(EQUAL_SIGN)
      scanner.skip(WHITESPACE)
      if scanner.scan(QUOTE_REGEX)
        quote = scanner.matched
        value = quote == '"' ? scanner.scan_until(DOUBLE_QOUTE)&.chop : scanner.scan_until(SINGLE_QOUTE)&.chop
      else
        value = scanner.scan(ATTRIBUTE_VALUE)
      end
      attributes[key] = value
    else
      attributes[key] = true
    end
    scanner.skip(WHITESPACE)
  end

  return attributes
end

def tokenize(source_code)
  scanner = StringScanner.new(source_code)
  tokens = []
  in_script = false
  in_style = false

  scanner.scan(DOCTYPE_REGEX)
  until scanner.eos?
    if in_style
      style_content = scanner.scan_until(STYLE_CLOSE_REGEX)
      if style_content
        content_length = style_content.length - 8

        tokens << Token.new(Tokens::CLOSING_TAG,'style',{})
        in_style = false
      else
        scanner.terminate
      end
    elsif in_script
      script_content = scanner.scan_until(SCRIPT_CLOSE_REGEX)
      if script_content
        content_length = script_content.length - 9
        tokens << Token.new(Tokens::TEXT,script_content[0,content_length],{})
        tokens << Token.new(Tokens::CLOSING_TAG,'script',{})
        in_script = false
      else
        tokens << Token.new(Tokens::TEXT,scanner.rest,{})
        scanner.terminate
      end
    elsif scanner.scan(OPENING_TAG_REGEX)
      if scanner.scan(FORWARD_SLASH_REGEX)
        tag_name = scanner.scan(TAG_NAME_REGEX)
        scanner.skip_until(CLOSING_TAG_REGEX)
        tokens << Token.new(Tokens::CLOSING_TAG,tag_name,{})
      else
        tag_name = scanner.scan(TAG_NAME_REGEX)
        attributes = parse_attributes(scanner)

        if scanner.scan(SELF_CLOSING_TAG_REGEX)
          tokens << Token.new(Tokens::SELF_CLOSING_TAG,tag_name,attributes)
        else
          scanner.scan(CLOSING_TAG_REGEX)
          token = nil
          if VOID_ELEMENTS[tag_name]
            token = Token.new(Tokens::SELF_CLOSING_TAG,tag_name,attributes)
          else
            token = Token.new(Tokens::OPENING_TAG,tag_name,attributes)
          end
          tokens << token
          in_script = (tag_name == "script")
          in_style = (tag_name == "style")
        end
      end
    else
      text = scanner.scan(TEXT_SCANNER)
      tokens << Token.new(Tokens::TEXT,text,{}) unless text.empty?
    end
  end
  tokens << Token.new(Tokens::EOF,nil,nil)
  return tokens
end

def parse(tokens)

  root = Node.new(tag_name: :root, attributes: EMPTY_HASH, text: +"", children: [])
  stack = [root]

  tokens.each do |token|
    current_node = stack.last
    case token.type
    when Tokens::OPENING_TAG, Tokens::SELF_CLOSING_TAG
      unescaped_attributes = token.attributes.transform_values do |v|
        v.is_a?(String) ? CGI.unescapeHTML(v) : v
      end
      new_element = Node.new(
        tag_name: token.tag_name,
        attributes: unescaped_attributes,
        text: +"",
        children: EMPTY_ARRAY.dup
      )
      current_node.children << new_element
      stack.push(new_element) unless token.type == Tokens::SELF_CLOSING_TAG
    when Tokens::CLOSING_TAG
      stack.pop if stack.size > 1
    when Tokens::TEXT
      current_node[:text] << token.tag_name
    end
  end
  return root
end

def parse_css_selector(selector)
  tag = selector[/^([a-zA-Z]+)/,1]
  id = selector[/#([\w-]+)/,1]
  classes = selector.scan(/\.([\w-]+)/).flatten

  return {tag: tag&.downcase, id: id, classes: classes}
end

def css(node, selector)
  return [] unless node
  pattern = parse_css_selector(selector)
  results = []
  stack = [node]

  while !stack.empty?
    current = stack.pop

    # Check current node against selector
    if matches_selector?(current, pattern)
      results << current
    end

    # Add children to stack in reverse order to maintain
    # original traversal order (depth-first, left-to-right)
    current[:children].reverse.each do |child|
      stack.push(child)
    end
  end

  results
end

def matches_selector?(node,pattern)

  return false if pattern[:tag] && node[:tag_name] != pattern[:tag]

  return false if pattern[:id] && node[:attributes]["id"] != pattern[:id]

  node_classes = node[:attributes]["class"].to_s.split
  return false if pattern[:classes].any? { |class_name| !node_classes.include?(class_name) }

  return true
end

def css_first(node,selector)
  pattern = parse_css_selector(selector)
  queue = [node]

  while !queue.empty?
    current = queue.shift

    if matches_selector?(current,pattern)
      return current
    else
      current[:children].reverse.each do |child|
        queue.unshift(child)
      end
    end
  end
  return nil
end

def extract_inline_js_images_google(script_nodes)
  image_src_regex = /var s=['"]([^'"]+)['"]/
  image_id_regex = /['"]([^'"]+)['"]/
  image_id_array_regex = /var ii=\[([^\]]+)\]/
  image_map = {}
  script_nodes.each do |script_node|
    script_content = script_node[:text]
    next unless script_content.include?("_setImagesSrc")

    s_match = script_content.match(image_src_regex)
    next unless s_match
    s_value = s_match[1].gsub('\x3d', '=')
    ii_match = script_content.match(image_id_array_regex)
    next unless ii_match

    ii_values = ii_match[1].scan(image_id_regex).flatten

    ii_values.each do |img_id|
      image_map[img_id] = s_value
    end
  end
  return image_map
end

def extract_inline_js_images_google_nokogiri(script_nodes)
  image_src_regex = /var s=['"]([^'"]+)['"]/
  image_id_regex = /['"]([^'"]+)['"]/
  image_id_array_regex = /var ii=\[([^\]]+)\]/
  image_map = {}
  script_nodes.each do |script_node|
    script_content = script_node.content
    next unless script_content.include?("_setImagesSrc")

    s_match = script_content.match(image_src_regex)
    next unless s_match
    s_value = s_match[1].gsub('\x3d', '=')
    ii_match = script_content.match(image_id_array_regex)
    next unless ii_match

    ii_values = ii_match[1].scan(image_id_regex).flatten

    ii_values.each do |img_id|
      image_map[img_id] = s_value
    end
  end
  return image_map
end
