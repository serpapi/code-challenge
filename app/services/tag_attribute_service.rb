# frozen_string_literal: true

class TagAttributeService

  def get_attribute_value(html, attribute)
    matches = get_first_tag(html).scan(/.* #{attribute}=(".*?"|'.*?').*/)
    attribute_value = (matches.first || []).first
    attribute_value = remove_quotes(attribute_value) if attribute_value

    attribute_value
  end

  private

  def get_first_tag(html)
    html.split('</').first
  end

  def remove_quotes(value)
    value
      .gsub('"', '')
      .gsub("'", '')
  end
end