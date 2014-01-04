#encoding: utf-8
class UsersController < ApplicationController
  
  def login
    
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
    if session[:username].nil?
      redirect_to "/users/login"
    else
      @user = User.where(username: session[:username]).first
      @recent_rounds = @user.recent_rounds
      @round_details = @user.round_details
    end
  end
  
end
