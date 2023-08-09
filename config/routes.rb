Rails.application.routes.draw do
  devise_for :users
  # Root route
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end

  resources :posts do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create]
  end
end
