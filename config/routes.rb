Rails.application.routes.draw do    
  resources :return_notifications
  resources :libraries
  devise_for :users
  
  get 'books/notify', to: 'return_notifications#notify'
  get 'books/end_notify', to: 'return_notifications#end_notify'
  get 'books/borrow', to: 'checkout_logs#borrow'
  get 'books/return', to: 'checkout_logs#return'
  get 'books/my_books'
  get 'books/listing'
  get 'books/listing/:book_number' => 'books#details', :as => :book_listing_details
  get 'books/:id/add_copy' => 'books#add_copy', :as => :add_copy

  
  resources :books do    
    resources :checkout_logs
  end 

  get 'home/index'

  root to: "home#index"

  #match all other routes to 'url_not_found'
  match "*path", to: "application#url_not_found", via: :all  
end
