Rails.application.routes.draw do
  devise_for :users
  root to: "teams#index"

  resources :teams
  resources :players
  resources :tournaments do
    post :add_team, on: :member
    delete :remove_team, on: :member
  end
end
