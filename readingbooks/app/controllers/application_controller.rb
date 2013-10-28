class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :can_edit_users, :admin?, :owner?

  private
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

     def can_edit_users
       unless admin?
         flash[:error] = "unauthorized access"
         redirect_to root_path
         false
       end
     end

     def admin?
       @current_user.admin? if current_user
     end

     def can_edit_books
        unless owner? or admin?
          flash[:error] = "unauthorized access"
          redirect_to root_path
          false
        end
     end

     def owner?
       admin?
     end
end
