class ReturnNotification < ApplicationRecord
  belongs_to :user
  belongs_to :library
  #belongs_to :book_number, :foreign_key => 'book_number', :class_name => 'Book', :primary_key => 'book_number'
end
