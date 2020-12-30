class MyBooksController < ApplicationController
  #TODO require login to access this page
  
  def index
    # TODO:
    # show all checkoutlogs for user_id user that do not have a returnedDate.    
    @books = CheckoutLog.all
  end

  def borrow
    # TODO:
    #1. find a matching book that is still available
    #2. create new entry in checkoutlog table with that book_id and user_id of current_user
  end

  def return
    # TODO:
    #update returneddate in checkoutlog table for book_id and current_user user_id to currentdate
  end
end
