module Searcher
  class GooglePaintings < Grape::API
    resource :google_paintings do
      desc 'Google paintings search'
      params do
        requires :search, type: String, desc: 'Search', documentation: { param_type: 'query' }
      end
      get do
        search_service = Google::SearchService.new

        {
          paintings: search_service.paintings(params[:search])
        }
      end
    end
  end
end