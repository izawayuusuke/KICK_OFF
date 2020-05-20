Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'search', to: 'homes#search', as: 'search'
  get 'leagues/domestic'
  get 'leagues/abroad'
  get 'leagues/representative'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update] do
    member do
      get :following, :followers, :likes
    end
  end

  resources :posts, only: [:index, :show, :create, :destroy] do
    resource :like, only: [:create, :destroy]
    resource :share, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :players do
    resource :belongs, only: [:create]
  end

  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:index, :show, :create,]
  resources :teams
  resources :leagues
end
