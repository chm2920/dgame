class Admin::ManageController < ApplicationController
  
  layout 'admin'
  
  @@scheduler = Rufus::Scheduler.new
  @@timeout = 0
  
  def main
    @sys_info = Sysinfo.first
  end
  
  def start_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "started"
    @sys_info.started_at = Time.now
    @sys_info.save
    
    
    @@scheduler.every '60s' do |job|
      if @sys_info.game_status == "started" && @@timeout != 180
        @@timeout += 60
      else
        @sys_info = Sysinfo.first
        if @sys_info.game_status == "started"
          recycle_coins = 0
          
          @round = Round.order(no: :desc).first
          @round_details = @round.round_details
          @ls = @round.ls
          @rs = @round.rs
          if @ls.map{|t|t.coins}.sum == @rs.map{|t|t.coins}.sum || @round_details.length < 2
            @round.re = "="
          else
            if @ls.map{|t|t.coins}.sum < @rs.map{|t|t.coins}.sum
              @round.re = "l"
            else
              @round.re = "r"
            end
            @round.save
            
            @round_details.each do |round_detail|
              user = round_detail.user
              if round_detail.lr == @round.re
                user.coins += round_detail.coins
              else
                user.coins -= round_detail.coins
                recycle_coins += round_detail.coins
              end
              user.save
            end
          end
          
          @round = Round.new
          @round.no = @sys_info.round_no.to_i + 1
          @round.re = ""
          @round.save
          
          @sys_info.game_status = "paused"
          @sys_info.started_at = Time.now
          @sys_info.round_no = @sys_info.round_no.to_i + 1
          @sys_info.recycle_coins += recycle_coins
          @sys_info.save
          puts "game result."
        else
          @@timeout = 0
          
          @sys_info.game_status = "started"
          @sys_info.started_at = Time.now
          @sys_info.save
          puts "new game started."
        end
      end
    end
    redirect_to :action => "main"
  end
  
  def stop_game
    @sys_info = Sysinfo.first
    @sys_info.game_status = "stopped"
    @sys_info.save
    
    @@scheduler.every_jobs.each(&:unschedule)
    redirect_to :action => "main"
  end
  
  def sys_reset
    @sys_info = Sysinfo.first
    @sys_info.game_status = "stopped"
    @sys_info.round_no = 1
    @sys_info.started_at = Time.now
    @sys_info.recycle_coins = 0
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
