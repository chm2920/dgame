#encoding: utf-8
class UsersController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => [:login_rst, :reg_rst]
  
  before_action :auth_user, :only => :main
  
  def login
    @sys_info = Sysinfo.first
  end
  
  def login_rst
    @user = User.where(username: params[:login][:username]).first
    if !@user.nil?
      if @user.password == params[:login][:password]
        session[:username] = @user.username
        redirect_to "/"
      else
        flash[:notice] = "用户名密码错误"
        render :action => "login"
      end
    else
      flash[:notice] = "用户名密码错误"
      render :action => "login"
    end
  end
  
  def reg_rst
    @user = User.where(username: params[:reg][:username]).first
    puts params[:reg][:username]
    if !@user.nil?
      flash[:notice] = "用户名已存在"
      render :action => "login"
    else
      @user = User.new
      @user.username = params[:reg][:username]
      @user.password = params[:reg][:password]
      @user.coins = 100
      @user.save
      session[:username] = @user.username
      redirect_to "/"
    end
  end
  
  def logout
    session[:username] = nil
    redirect_to "/"
  end
  
  def main
    @round_details = @user.round_details.paginate :page => params[:page], :per_page => 30, :order => "id desc"
  end
  
end
