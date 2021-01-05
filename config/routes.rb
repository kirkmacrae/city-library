Rails.application.routes.draw do    
  devise_for :users
  
  get 'books/my_books'
  get 'books/listing'  
  
  get 'home/index'
  get 'books/borrow', to: 'checkout_logs#borrow'
  get 'books/return', to: 'checkout_logs#return'
  
  resources :books do    
    resources :checkout_logs
  end 

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
