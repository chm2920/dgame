class StartController < ApplicationController
  
  def index
    if session[:username].nil?
      redirect_to "/users/login"
    else
      @user = User.where(username: session[:username]).first
      @recent_rounds = @user.recent_rounds
      @sys_info = Sysinfo.first
      @round = Round.first
      @last_round = Round.where(no: @round.no - 1).first
    end
  end
  
end
