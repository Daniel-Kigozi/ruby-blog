Rails.application.routes.draw do
  
  devise_for :user do
    authenticated :user do
      root :to => 'users#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create]
  end

  namespace :api do
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
