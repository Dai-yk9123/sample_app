Rails.application.routes.draw do
  root 'static_pages#home' # => root_path
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  # => contact_path
  get '/signup',    to: 'users#new'
  resources :users

  #root 'application#hello'
end
