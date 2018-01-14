Rails.application.routes.draw do
  devise_for :users
  root to: "teams#index"

  namespace :admin do
    resources :teams, only: %i[index show new create]
    resources :players, only: %i[index show new create]
    resources :tournaments, only: %i[index show new create] do
      resources :matches, only: %i[index show new create update], shallow: true
      post :add_team, on: :member
      delete :remove_team, on: :member
    end
  end

  resources :teams, only: %i[index show]
  resources :players, only: %i[index show]
  resources :tournaments, only: %i[index show] do
    resources :matches, only: %i[index show], shallow: true
  end
end
