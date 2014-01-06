class RoundsController < ApplicationController
  
  before_action :auth_user
  
  def index
    @rounds = Round.paginate :page => params[:page], :per_page => 2, :conditions => ["re != ''"], :order => "id desc"
  end
  
  def show
    @round = Round.find(params[:id])
  end
  
end
