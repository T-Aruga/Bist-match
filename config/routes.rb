Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'notifications/index'
  get 'revenues_controller/index'
  get 'messages/index'
  get 'conversations/index'
  root 'homes#top'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

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
  get 'search_jenre' => 'homes#search_jenre'

  get 'dashboard' => 'dashboards#index'
  resources :revenues, only: [:index]

  get '/payment_method' => "users#payment"
  post '/add_card' => "users#add_card"

  post 'messages' => 'messages#create'
  get '/conversations' => 'conversations#list'
  get '/conversations/:id' => 'conversations#show', as: "conversation_detail"

  get '/about' => "homes#about"
  get '/privacy' => "homes#privacy"
  get '/notifications' => 'notifications#index'

  mount ActionCable.server => '/cable'

end
