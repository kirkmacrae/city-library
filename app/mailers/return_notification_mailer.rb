class ReturnNotificationMailer < ApplicationMailer
    def return_notifications
        @user = params[:user]
        @book = params[:book]
        mail(to: @user.email, subject: 'A book you were interested in has been returned!')
    end
end
