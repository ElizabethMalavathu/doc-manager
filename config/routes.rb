Docmanager::Application.routes.draw do
  devise_for :users

  root :to => 'collections#index'

  resources :collections
  resources :documents
  resources :users
end
