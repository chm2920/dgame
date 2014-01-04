class User < ActiveRecord::Base
  
  has_many :round_details
  
  def recent_rounds
    self.round_details.where(user_id: self.id).order(round_id: :desc)
  end
  
end
