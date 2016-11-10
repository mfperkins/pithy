Rails.application.routes.draw do
  devise_for :users

  resources :people, only: [:index, :show]
  resources :quotes, only: [:new]

  root "people#index"

end
