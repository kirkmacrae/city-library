Rails.application.routes.draw do    
  devise_for :users
  
  get 'books/borrow', to: 'checkout_logs#borrow'
  get 'books/return', to: 'checkout_logs#return'
  get 'books/my_books'
  get 'books/listing'
  get 'books/:id/add_copy' => 'books#add_copy', :as => :add_copy
  
  resources :books do    
    resources :checkout_logs
  end 

  get 'home/index'

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
