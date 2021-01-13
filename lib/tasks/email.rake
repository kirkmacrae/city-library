namespace :email do
  desc "send out emails for overdue books"
  task overdue_books: :environment do
    User.find_each do |user|      
      @checkout_logs = CheckoutLog.joins(:book).where(checkout_logs: {user_id: user.id, returned_date: nil}).where(CheckoutLog.arel_table[:due_date].lt(Time.now))
      UserMailer.with(user: user, checkout_logs: @checkout_logs).overdue_books.deliver_now
    end
  end

end
