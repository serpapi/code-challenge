# frozen_string_literal: true

module Utils
  def self.get_base_url(page)
    case page.css('base').to_a
    in [base] if base['href']&.length&.> 0
      base['href']
    else
      nil
    end
  end

  def self.add_host(url, params)
    case [url, params]
    in '/', { base_url: String } if base_url.size.positive?
      File.join(base_url, url)
    else
      url
    end
  end
end
