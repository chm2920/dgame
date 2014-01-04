class Admin::ManageController < ApplicationController
  
  layout 'admin'
  
  def main
    @sys_info = Sysinfo.first
  end
  
  def start_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "started"
    @sys_info.started_at = Time.now
    @sys_info.save
    redirect_to :action => "main"
  end
  
  def pause_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "paused"
    @sys_info.save
    redirect_to :action => "main"
  end
  
  def sys_reset
    redirect_to :action => "main"
  end
  
  def users
    @users = User.all
  end
  
  def rounds
    @rounds = Round.order(no: :desc)
  end
  
end
