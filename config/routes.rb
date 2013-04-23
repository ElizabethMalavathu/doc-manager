Docmanager::Application.routes.draw do
  devise_for :users

  root :to => 'collections#index'

  resources :collections
  resources :documents do
    collection do
      post :add_collections
    end
  end
  resources :users
end
