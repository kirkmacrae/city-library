class ApplicationController < ActionController::Base
    def url_not_found
    end
    
    def is_admin
        redirect_to root_path unless current_user.admin?
    end
end
