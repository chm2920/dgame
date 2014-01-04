class CreateSysinfo < ActiveRecord::Migration
  def change
    create_table :sysinfos do |t|
      t.string :round_no
      t.datetime :started_at
      t.string :game_status
    end
    
    Sysinfo.create(:round_no => 1, :started_at => Time.now, :game_status => "paused")
  end
end
