# frozen_string_literal: true

class TagSanitizerService
  TAGS = [
    '<wbr>'
  ]

  def simple_tags_sanitize(html)
    TAGS.reduce(html) do |inner_html, tag|
      inner_html.gsub(tag, '')
    end
  end

  def tags_sanitize(html)
    html.gsub(/<.*?>/, '')
  end
end