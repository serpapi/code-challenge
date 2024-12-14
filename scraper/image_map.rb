require_relative 'element_not_found_error'

# image links are stored in js script(s) variables
# this class scrapes the script(s) and builds image_id => blob mapping for easy access
class ImageMap
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  def to_h
    [single_script_content, multiple_scripts_content].lazy.map { build_mapping(_1) }.find(&:any?) ||
      raise(ElementNotFoundError)
  end

  private

  def single_script_content
    doc.at("//script[contains(text(), 'function _setImagesSrc')]")&.text.to_s
  end

  def multiple_scripts_content
    doc.css('script[nonce]').select { |node| node.text.include?('_setImagesSrc(') }.map(&:text).join
  end

  def build_mapping(script)
    script
      .scan(/var s='(.*?)';var ii=\['(.*?)'\]/)
      .map { |base64, key| [key, base64.gsub('\\', '')] }
      .to_h
  end
end
