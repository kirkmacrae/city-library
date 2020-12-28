Rails.application.routes.draw do
  resources :checkout_logs
  devise_for :users
  get 'home/index'
  resources :books

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
