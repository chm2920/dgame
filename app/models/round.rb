class Round < ActiveRecord::Base
  
  has_many :round_details
  
  def ls
    self.round_details.where(lr: 'l')
  end
  
  def rs
    self.round_details.where(lr: 'r')
  end
  
end
