class UserMailer < ApplicationMailer
    def overdue_books
        @user = params[:user]
        @checkout_logs = params[:checkout_logs]
        mail(to: @user.email, subject: 'You have overdue books')
    end
end
