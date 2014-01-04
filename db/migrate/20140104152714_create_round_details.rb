class CreateRoundDetails < ActiveRecord::Migration
  def change
    create_table :round_details do |t|
      t.integer :user_id
      t.integer :round_id
      t.string :lr
      t.integer :coins

      t.timestamps
    end
  end
end
