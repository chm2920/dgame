class RoundsController < ApplicationController
  
  def index
    if session[:username].nil?
      redirect_to "/users/login"
    else
      @user = User.where(username: session[:username]).first
      @recent_rounds = @user.recent_rounds
    end
  end
end
