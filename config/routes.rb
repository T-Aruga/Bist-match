Rails.application.routes.draw do

  root 'homes#top'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except: [:edit]  do
    member do
      get 'profile'
      get 'description'
      get 'favorite_store'
      get 'photo_upload'
      get 'exit'
    end
  end

  resources :plans, except: [:edit] do
    member do
      get 'listing'
      get 'rest_info'
      get 'description'
      get 'photo_upload'
      get 'time_info'
    end
    resources :photos, only: [:update, :destroy]
    resources :reservations, only: [:create]
    resource :favorites, only: [:create, :destroy]
  end

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]

  get '/your_plans' => 'plans#your_plans'
  get '/your_reservation' => 'reservations#your_reservation'
  get '/your_entry' => 'reservations#your_entry'

  resources :restaurants, only: [:create, :update]
  get '/search_gnabi' => 'restaurants#search_gnabi'

  get 'search' => 'homes#search'

  get 'dashboard' => 'dashboards#index'

end
