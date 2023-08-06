require 'grape-swagger'

module Searcher
  class Api < Grape::API
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({ status_code: 'not_found', error: e.message }, 404)
    end

    mount Searcher::GooglePaintings

    add_swagger_documentation
  end
end