Rails.application.routes.draw do
  get 'welcome/index'

  resources :images

  get '/images/search', to: 'images#search'
  get '/csv', to: 'images#csv', as: :csv

  get '/machrie', to: 'images#machrie'

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'
end
