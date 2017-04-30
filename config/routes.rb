Rails.application.routes.draw do
  devise_for :users
  resources :links, only: [:new, :create]
  resources :revert, only: [:index, :create]
  resources :trending, only: [:index, :show]
  root to: "links#new"

  #redirect
  get ":id", to: "shorten#index"

end
