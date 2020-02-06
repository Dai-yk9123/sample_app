Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home' # => root_path
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  # => contact_path
  get '/signup',    to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  # GET /account_activations/:id/edit
  # params[:id] <==== 有効化トークン
  # Controller: params[:id]

  #root 'application#hello'
end
