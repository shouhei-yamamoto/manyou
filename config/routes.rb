Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  
  get '/', to: 'tasks#index'
  resources :tasks

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
