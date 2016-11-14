Rails.application.routes.draw do
  devise_for :users

  resources :people, only: [:index, :show] do
    resources :quotes, only: [:new]
  end

  resources :quotes


  root "people#index"

end
