class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def auth_user
    if session[:username].nil?
      redirect_to "/users/login"
    else
      @user = User.where(username: session[:username]).first
      @recent_rounds = @user.recent_rounds
    end
  end
  
end
