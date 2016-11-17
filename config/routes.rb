Rails.application.routes.draw do
  devise_for :users

  resources :people do
    resources :quotes, only: [:new]
  end

  resources :quotes


  root "people#index"

end
