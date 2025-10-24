class ScraperController < ApplicationController
  def index
    filename = params[:file]
    file_path = Rails.root.join('files', "#{filename}.html")

    if File.exist?(file_path)
      html = File.read(file_path)
      json = Scraper.scrape(html)

      render json: json
    else
      render plain: "File not found: #{filename}.html", status: :not_found
    end
  end
end
