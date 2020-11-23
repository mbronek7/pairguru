Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  get "/commenters", to: "home#top_commenters"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
    resources :comments, only: [:create, :destroy]
  end
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :movies, only: [:index, :show]
    end
    namespace :v2 do
      resources :movies, only: [:index, :show]
    end
  end
end
