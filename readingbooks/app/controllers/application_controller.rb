class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :can_edit_users

  private
	  def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

     def can_edit_users
       unless (@current_user.admin? if current_user)
         flash[:error] = "unauthorized access"
         redirect_to root_path
         false
       end
     end
end
