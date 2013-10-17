class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email].downcase)
    if @user && @user.password == params[:password]
      
    else
      flash[:error] = "Invalid email/password"
      render 'new'
    end
  end

  def destroy

  end
end
