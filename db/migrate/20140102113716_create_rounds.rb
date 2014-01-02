class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :no
    end
  end
end
