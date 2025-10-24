Rails.application.routes.draw do
  root "scraper#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
