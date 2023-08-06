# frozen_string_literal: true

class DrillService

  def pick(html, drill_map)
    drilled_html =
      drill_map.reduce(tag_sanitizer_service.simple_tags_sanitize(html)) do |inner_html, map_item|
        case map_item[:strategy]
        when 'drill'
          drill(inner_html, map_item[:element])
        when 'remove_wrong_tags'
          remove_wrong_tags(inner_html, map_item[:element])
        when 'skip'
          skip(inner_html, map_item[:element])
        else
          inner_html
        end
      end

    remove_tail(drilled_html)
  end

  private

  def drill(html, element)
    '<' + html.split(/<#{element}.*?</, 2).last
  end

  def remove_wrong_tags(html, element)
    html.gsub(/<#{element}.*?>/, '')
  end

  def skip(html, element)
    skip_mark = '</skip_tag>'
    marked = false
    quote_level = 0

    html_with_skip_mark =
      html.gsub(/<#{element}|\/#{element}>/) do |tag|
        case (tag)
        when "<#{element}"
          quote_level += 1
          tag
        when "/#{element}>"
          quote_level -= 1

          if !marked && quote_level == 0
            marked = true
            skip_mark
          else
            tag
          end
        else
          tag
        end
      end

    html_with_skip_mark.split(skip_mark).last
  end

  def remove_tail(html)
    remove_mark = '<REMOVE_HERE>'
    marked = false
    quote_level = 0

    html_with_remove_mark =
      html.gsub(/<.*?>|<\/.*>/) do |tag|
        if tag[0..1] == '</'
          quote_level -= 1

          if !marked && quote_level < 0
            marked = true
            tag + remove_mark
          else
            tag
          end
        else
          quote_level += 1
          tag
        end
      end

    html_with_remove_mark.split(remove_mark).first
  end

  def tag_sanitizer_service
    @tag_sanitizer_service ||= TagSanitizerService.new
  end
end