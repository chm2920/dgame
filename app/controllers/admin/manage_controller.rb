class Admin::ManageController < ApplicationController
  
  layout 'admin'
  
  @@scheduler = Rufus::Scheduler.new
  
  def main
    @sys_info = Sysinfo.first
  end
  
  def start_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "started"
    @sys_info.started_at = Time.now
    @sys_info.timeout = params[:timeout]
    @sys_info.save
    
    
    @@scheduler.every @sys_info.timeout do |job|
      @sys_info = Sysinfo.first
      if @sys_info.game_status == "started"
        @sys_info.game_status = "paused"
        @sys_info.started_at = Time.now
        @sys_info.round_no = @sys_info.round_no.to_i + 1
        @sys_info.save
        @round = Round.order(no: :desc).first
        if @round.ls.length >= @round.rs.length
          @round.re = "l"
        else
          @round.re = "r"
        end
        @round.save
        
        @round.round_details.each do |round_detail|
          user = round_detail.user
          if round_detail.lr == @round.re
            user.coins += round_detail.coins
          else
            user.coins -= round_detail.coins
          end
          user.save
        end
        
        @round = Round.new
        @round.no = @sys_info.round_no
        @round.re = ""
        @round.save
        puts "game result."
      else
        @sys_info.game_status = "started"
        @sys_info.started_at = Time.now
        @sys_info.save
        puts "new game started."
      end
    end
    redirect_to :action => "main"
  end
  
  def stop_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "stopped"
    @sys_info.timeout = params[:timeout]
    @sys_info.save
    
    @@scheduler.every_jobs.each(&:unschedule)
    redirect_to :action => "main"
  end
  
  def sys_reset
    @sys_info = Sysinfo.first
    @sys_info.game_status = "stopped"
    @sys_info.round_no = 1
    @sys_info.started_at = Time.now
    @sys_info.timeout = '240s'
    @sys_info.save
    
    Round.destroy_all
    User.destroy_all
    RoundDetail.destroy_all
    
    Round.create(:no => 1, :re => "")
    redirect_to :action => "main"
  end
  
  def users
    @users = User.all
  end
  
  def rounds
    @rounds = Round.order(no: :desc)
  end
  
end
