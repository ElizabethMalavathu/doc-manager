DocManager::Application.routes.draw do
  devise_for :users

  root :to => 'collections#index'

  resources :collections do
    collection do
      get :datatable
    end
    member do
      get :order
      post :reorder
    end
  end
  
  resources :documents do
    collection do
      post :add_collections
    end
  end
  resources :users
end
