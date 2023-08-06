Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  root 'home#index'

  mount Searcher::Api => '/'
end
