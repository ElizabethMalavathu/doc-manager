Docmanager::Application.routes.draw do
  get "home/index"

  resources :collections
  resources :primary_documents
end
