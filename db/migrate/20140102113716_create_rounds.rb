class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :no
      t.string :re
      
      t.timestamps
    end
    
    Round.create(:no => 1, :re => '')
  end
end
