Rails.application.routes.draw do
  devise_for :users

  resources :people do
    resources :quotes, only: [:new]
  end

  resources :quotes


  root "people#index"

  namespace :api do
    namespace :v1 do
      resources :people, only: [:show]
      resources :quotes, only: [:show]
    end
  end

end
