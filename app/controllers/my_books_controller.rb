class MyBooksController < ApplicationController
  #TODO require login to access this page
  
  def index    
    @books = CheckoutLog.all
  end

  def borrow
  end

  def return
  end
end
