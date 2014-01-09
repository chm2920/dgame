#encoding: utf-8
class StartController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  before_action :auth_user, :only => [:index]
  
  def index
    @round = Round.last
    @last_round = Round.where(no: @round.no - 1).first
  end
  
  def p
    @result = {}
    if session[:username].nil?
      @result['code'] = '1'
      @result['msg'] = '未登录'
    else
      @user = User.where(username: session[:username]).first
      if !@user.nil?
        @round = Round.last
        if @round.re != ''
          @result['code'] = '1'
          @result['msg'] = '已结束'
        else
          @round_detail = RoundDetail.where(user_id: @user.id, round_id: @round.id).first
          if @round_detail.nil?
            @round_detail = RoundDetail.new
            @round_detail.round = @round
            @round_detail.user = @user
            @round_detail.lr = params[:lr]
            @round_detail.coins = params[:coins]
            @round_detail.save
          else
            @round_detail.lr = params[:lr]
            @round_detail.coins = params[:coins]
            @round_detail.save
          end
          @result['code'] = '0'
          @result['msg'] = 'ok'
        end
      else
        @result['code'] = '1'
        @result['msg'] = '未登录'
      end
    end
    
    render :json => @result
  end
  
end
