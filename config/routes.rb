Rails.application.routes.draw do

  root 'homes#top'

  resources :restaurants, only: [:create]
  get '/search_gnabi' => 'restaurants#search_gnabi'


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
