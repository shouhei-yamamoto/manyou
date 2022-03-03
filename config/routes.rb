Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  resources :tasks
end
