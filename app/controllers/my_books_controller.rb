class MyBooksController < ApplicationController
  #TODO require login to access this page
  
  def index
    # TODO:
    # show all checkoutlogs for user_id user that do not have a returned_date.
    # TODO: verify this when borrow button works     
    @books = CheckoutLog.select(Arel.star).where(
      CheckoutLog.arel_table[:id].eq(current_user.id).and(CheckoutLog.arel_table[:returned_date].eq(nil))
    )
  end

  def borrow
    
  end

  def return
    # TODO:
    #update returned_date in checkoutlog table for book_id and current_user user_id to currentdate
  end
end
