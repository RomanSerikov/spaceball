Rails.application.routes.draw do
  devise_for :users
  root to: "tournaments#index"

  namespace :admin do
    get "/index" => "static_pages#index"
    resources :teams, only: %i[index show new create]
    resources :players, only: %i[index show new create]
    resources :users, only: %i[index show edit update]
    resources :tournaments, only: %i[index show new create] do
      resources :matches, only: %i[index show new create update], shallow: true
      post :add_team, on: :member
      delete :remove_team, on: :member
    end
  end

  resources :teams, only: %i[index show]
  resources :players, only: %i[index show new create]
  resources :tournaments, only: %i[index show] do
    resources :matches, only: %i[index show update], shallow: true
  end
end
