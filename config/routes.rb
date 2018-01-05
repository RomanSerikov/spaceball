Rails.application.routes.draw do
  devise_for :users
  root to: "teams#index"

  resources :teams, only: %i[index show new create]
  resources :players, only: %i[show new create]
  resources :tournaments, only: %i[show new create] do
    post :add_team, on: :member
    delete :remove_team, on: :member
  end
end
