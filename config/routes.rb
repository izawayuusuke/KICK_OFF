Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'leagues/domestic'
  get 'leagues/abroad'
  get 'leagues/representative'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers, :likes
    end
  end

  resources :posts, only: [:index, :show, :create, :destroy] do
    resource :like, only: [:create, :destroy]
    resource :share, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :players, only: [:index, :show, :edit, :update] do
    resources :belongs, only: [:create]
  end

  resources :teams, only: [:show, :edit, :create, :update] do
    resource :players, only: [:create]
    resources :belongs, only: [:destroy]
    resources :discussions, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:index, :show, :create]
  resources :leagues, only: [:index, :show, :create, :update]
  resources :notifications, only: [:index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "letter_opener"
  end
end
