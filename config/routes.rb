Rails.application.routes.draw do
  get "/admin/users", to: 'admin/users#index', as: :admin_users_path_index
  namespace :admin do
    resources :users
  end
  
  get '/', to: 'tasks#index'
  resources :tasks

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
