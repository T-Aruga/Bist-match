Rails.application.routes.draw do

  get 'messages/index'
  get 'conversations/index'
  root 'homes#top'

  devise_for :users

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

  resources :reservations, only: [:approve, :decline] do
    member do
      post '/approve' => "reservations#approve"
      post '/decline' => "reservations#decline"
    end
  end

  get '/your_reservation' => 'reservations#your_reservation'
  get '/your_entry' => 'reservations#your_entry'

  resources :restaurants, only: [:create, :update]
  get '/search_gnabi' => 'restaurants#search_gnabi'

  get 'search' => 'homes#search'

  get 'dashboard' => 'dashboards#index'

  get '/payment_method' => "users#payment"
  get '/payout_method' => "users#payout"
  post '/add_card' => "users#add_card"

  resources :conversations, only: [:index, :create]  do
    resources :messages, only: [:index, :create]
  end

  mount ActionCable.server => '/cable'

end
