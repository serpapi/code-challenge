# frozen_string_literal: true

class ListService

  def split(html, element)
    split_mark = 'SPLIT_MARK'
    marked = false
    quote_level = 0

    html_with_split_mark =
      html.gsub(/<#{element}|\/#{element}>/) do |tag|
        case (tag)
        when "<#{element}"
          quote_level += 1
          tag
        when "/#{element}>"
          quote_level -= 1

          if !marked && quote_level <= 0
            marked = true if quote_level < 0
            tag + (!marked ? split_mark : '')
          else
            tag
          end
        else
          tag
        end
      end

    html_with_split_mark.split(split_mark)[0...-1]
  end
end