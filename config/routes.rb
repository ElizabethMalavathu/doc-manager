Docmanager::Application.routes.draw do
  root :to => 'collections#index'

  resources :collections
  resources :documents
end
