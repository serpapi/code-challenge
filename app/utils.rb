# frozen_string_literal: true

module Utils
  def self.get_base_url(page)
    case page.css('base').to_a
    in [base] if base['href']&.length&.positive?
      base['href']
    else
      nil
    end
  end

  def self.add_host(url, params)
    case [url[0], params]
    in ['/', { base_url: base_url }] if base_url&.length&.positive?
      File.join(base_url, url)
    else
      url
    end
  end
end
