Rails.application.routes.draw do
  devise_for :users

  resources :people do
    resources :quotes, only: [:new]
  end

  resources :quotes


  root "people#index"

  namespace :api do
    namespace :v1 do
      resources :slack_auth
      resources :slack, only: [:create]
      resources :people, only: [:show, :index] do
        resources :quotes, only: [:show, :index]
      end
    end
  end

end
