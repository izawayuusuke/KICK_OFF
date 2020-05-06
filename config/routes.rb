Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'search', to: 'homes#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:index, :show, :create, :destroy] do
    resource :like, only: [:create, :destroy]
  end
end
